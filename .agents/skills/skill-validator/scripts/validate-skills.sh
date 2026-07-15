#!/usr/bin/env bash
set -euo pipefail

skill_root="${1:-.agents/skills}"
manifest="${2:-.agents/skills/manifest.md}"

ruby - "$skill_root" "$manifest" <<'RUBY'
skill_root = ARGV.fetch(0)
manifest_path = ARGV.fetch(1)

failures = []
warnings = []

def add(failures, path, message)
  failures << [path, message]
end

def frontmatter(text)
  return nil unless text.start_with?("---\n")

  parts = text.split("---\n", 3)
  return nil unless parts.length == 3

  [parts[1], parts[2]]
end

def field(frontmatter, name)
  frontmatter[/^#{Regexp.escape(name)}:\s*(.+)$/, 1]&.strip
end

unless Dir.exist?(skill_root)
  add(failures, skill_root, "skill root does not exist")
end

skill_files = Dir[File.join(skill_root, "*", "SKILL.md")].reject do |path|
  File.basename(File.dirname(path)) == "_template"
end.sort

if skill_files.empty?
  add(failures, skill_root, "no active SKILL.md files found")
end

skills = {}

skill_files.each do |path|
  text = File.read(path)
  parsed = frontmatter(text)

  unless parsed
    add(failures, path, "missing YAML frontmatter block at top of file")
    next
  end

  yaml, body = parsed
  name = field(yaml, "name")
  description = field(yaml, "description")
  dir_name = File.basename(File.dirname(path))

  if name.nil? || name.empty?
    add(failures, path, "missing required frontmatter field: name")
  else
    skills[name] = path
    unless name.match?(/\A[a-z0-9]+(-[a-z0-9]+)*\z/)
      add(failures, path, "name must match ^[a-z0-9]+(-[a-z0-9]+)*$: #{name}")
    end
    unless (1..64).cover?(name.length)
      add(failures, path, "name must be 1-64 characters: #{name.length}")
    end
    unless name == dir_name
      add(failures, path, "frontmatter name must match directory name: #{name} != #{dir_name}")
    end
  end

  if description.nil? || description.empty?
    add(failures, path, "missing required frontmatter field: description")
  elsif !(1..1024).cover?(description.length)
    add(failures, path, "description must be 1-1024 characters: #{description.length}")
  end

  unless body.include?("## When to use")
    add(failures, path, "missing required section: ## When to use")
  end

  action_sections = ["## Workflow", "## Required behaviors", "## Validation", "## Output", "## Output contract"]
  unless action_sections.any? { |section| body.include?(section) }
    add(failures, path, "missing action section: expected Workflow, Required behaviors, Validation, Output, or Output contract")
  end

  text.scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.each do |target|
    next if target.start_with?("http://", "https://", "#", "mailto:")

    local_target = target.split("#", 2).first
    next if local_target.empty?

    resolved = File.expand_path(local_target, File.dirname(path))
    unless File.exist?(resolved)
      add(failures, path, "broken local markdown link: #{target}")
    end
  end
end

if File.exist?(manifest_path)
  manifest = File.read(manifest_path)
  registered = manifest.scan(/\[`([^`]+)`\]\(([^)]+)\)/)
  registered_names = registered.map(&:first)

  registered.each do |name, link|
    link_path = File.expand_path(link, File.dirname(manifest_path))
    repo_relative_path = File.expand_path(link, Dir.pwd)
    unless File.exist?(link_path) || File.exist?(repo_relative_path)
      add(failures, manifest_path, "manifest entry for #{name} points to missing file: #{link}")
    end
  end

  skills.each do |name, path|
    unless registered_names.include?(name)
      add(failures, path, "skill is discoverable but not registered in #{manifest_path}")
    end
  end
else
  warnings << [manifest_path, "manifest not found; skipped manifest checks"]
end

if failures.empty?
  puts "skill validation: pass"
  puts "validated #{skill_files.length} active skills under #{skill_root}"
  warnings.each { |path, message| puts "warning: #{path}: #{message}" }
  exit 0
end

puts "skill validation: fail"
failures.each do |path, message|
  puts "#{path}: #{message}"
end
warnings.each { |path, message| puts "warning: #{path}: #{message}" }
exit 1
RUBY
