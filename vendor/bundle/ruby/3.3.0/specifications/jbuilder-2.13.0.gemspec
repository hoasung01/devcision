# -*- encoding: utf-8 -*-
# stub: jbuilder 2.13.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jbuilder".freeze
  s.version = "2.13.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rails/jbuilder/issues", "changelog_uri" => "https://github.com/rails/jbuilder/releases/tag/v2.13.0", "mailing_list_uri" => "https://discuss.rubyonrails.org/c/rubyonrails-talk", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/rails/jbuilder/tree/v2.13.0" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2024-09-15"
  s.email = "david@basecamp.com".freeze
  s.homepage = "https://github.com/rails/jbuilder".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "3.5.16".freeze
  s.summary = "Create JSON structures via a Builder-style DSL".freeze

  s.installed_by_version = "3.5.11".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.0.0".freeze])
  s.add_runtime_dependency(%q<actionview>.freeze, [">= 5.0.0".freeze])
end
