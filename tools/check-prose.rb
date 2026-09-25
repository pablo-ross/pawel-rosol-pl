#!/usr/bin/env ruby
# frozen_string_literal: true

# Mechanical checks for the rules in .claude/skills/humanizer/SKILL.md that a
# script can decide without judgement. Run from tools/test.sh before the build.
#
#   ruby tools/check-prose.rb            # the default set of files
#   ruby tools/check-prose.rb FILE...    # only those files
#
# Checks, on prose outside code fences, inline code, Liquid, HTML tags, URLs
# and Polish typographic quotes „…” (a quoted statute keeps its own dashes):
#
#   dash      no em dash (—) or en dash (–); the house style is a spaced hyphen
#   question  a heading that opens like a question ends with "?"
#   h1        a post or tab body starts at ##; Chirpy renders title: as the H1
#   residue   chatbot sign-offs that address the prompter, not the reader
#
# Front matter prose (title, description, faq) gets the dash and residue checks.
# Posts published before 30 November 2022 are the author's own habits and are
# skipped, as the skill says; everything else in the default set is checked.

require "date"
require "yaml"

CUTOFF = Date.new(2022, 11, 30)

DEFAULT_FILES = Dir["_posts/*.md"] + Dir["_tabs/*.md"] + %w[zasady.md llms.txt]

QUESTION_WORDS = %w[Co Czy Jak Kto Kiedy Gdzie Dlaczego Czego Czym Który Która
                    Które Ile Skąd Komu].freeze
QUESTION_RE = /\A\#{2,4}\s+(?:#{QUESTION_WORDS.join('|')}|Za co|Po co|A co)\b/

RESIDUE = [
  "mam nadzieję, że to pomoże",
  "świetne pytanie",
  "czy chcesz, żebym",
  "podsumowując powyższe",
  "daj znać, jeśli chcesz"
].freeze

def strip_non_prose(line, quotes: true)
  s = line.dup
  s.gsub!(/`[^`]*`/, " ")            # inline code
  s.gsub!(/\{%.*?%\}|\{\{.*?\}\}/, " ") # Liquid
  s.gsub!(/\{:[^}]*\}/, " ")         # kramdown attribute blocks
  s.gsub!(/<[^>]+>/, " ")            # HTML tags
  s.gsub!(%r{https?://\S+}, " ")     # URLs
  s.gsub!(/„[^”]*”/, " ") if quotes  # quoted text keeps its own punctuation
  s
end

def split_front_matter(text)
  return [nil, text, 0] unless text.start_with?("---\n")

  close = text.index("\n---\n", 4)
  return [nil, text, 0] unless close

  fm = text[4...close]
  body = text[(close + 5)..]
  [fm, body, fm.count("\n") + 2]
end

def front_matter_strings(fm)
  data = YAML.safe_load(fm, permitted_classes: [Date, Time]) || {}
  out = []
  %w[title description].each { |k| out << [k, data[k]] if data[k].is_a?(String) }
  Array(data["faq"]).each_with_index do |q, i|
    next unless q.is_a?(Hash)

    out << ["faq[#{i}].question", q["question"]] if q["question"].is_a?(String)
    out << ["faq[#{i}].answer", q["answer"]] if q["answer"].is_a?(String)
  end
  out
rescue Psych::Exception => e
  warn "#{e.class}: #{e.message}"
  []
end

def check_file(path)
  problems = []
  text = File.read(path, encoding: "UTF-8")
  fm, body, offset = split_front_matter(text)
  markdown = path.end_with?(".md")

  if fm
    front_matter_strings(fm).each do |key, value|
      clean = strip_non_prose(value)
      problems << "#{path}: #{key}: em/en dash in prose" if clean.match?(/[—–]/)
      RESIDUE.each do |phrase|
        problems << "#{path}: #{key}: chatbot residue \"#{phrase}\"" if value.downcase.include?(phrase)
      end
    end
  end

  in_fence = false
  body.each_line.with_index(offset + 1) do |raw, n|
    line = raw.chomp
    if line.match?(/\A\s*(```|~~~)/)
      in_fence = !in_fence
      next
    end
    next if in_fence
    next if line.match?(/\A {4}|\A\t/) # indented code

    where = "#{path}:#{n}"

    if markdown && line.match?(/\A#\s/) && path.match?(%r{\A_(posts|tabs)/})
      problems << "#{where}: '# H1' in a body; Chirpy renders title: as the H1, start at ##"
    end

    heading = line.sub(/\s*\{:?[^}]*\}\s*\z/, "").rstrip
    if heading.match?(QUESTION_RE) && !heading.end_with?("?")
      problems << "#{where}: question heading without '?'"
    end

    clean = strip_non_prose(line)
    problems << "#{where}: em/en dash in prose" if clean.match?(/[—–]/)

    RESIDUE.each do |phrase|
      problems << "#{where}: chatbot residue \"#{phrase}\"" if clean.downcase.include?(phrase)
    end
  end

  problems
end

def skip?(path)
  m = path.match(%r{\A_posts/(\d{4}-\d{2}-\d{2})-})
  m && Date.parse(m[1]) < CUTOFF
end

files = ARGV.empty? ? DEFAULT_FILES : ARGV
files = files.reject { |f| skip?(f) }

problems = files.sort.flat_map { |f| check_file(f) }

if problems.empty?
  puts "Prose OK - #{files.size} file(s) checked against the humanizer rules."
else
  problems.each { |p| warn p }
  warn "ERROR: #{problems.size} prose problem(s); see .claude/skills/humanizer/SKILL.md"
  exit 1
end
