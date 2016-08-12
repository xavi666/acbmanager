# -*- encoding: utf-8 -*-
# stub: money-rails 1.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "money-rails"
  s.version = "1.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andreas Loupasakis", "Shane Emmons", "Simone Carletti"]
  s.date = "2016-06-21"
  s.description = "This library provides integration of RubyMoney - Money gem with Rails"
  s.email = ["alup.rubymoney@gmail.com"]
  s.homepage = "https://github.com/RubyMoney/money-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.5"
  s.summary = "Money gem integration with Rails"

  s.installed_by_version = "2.2.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<money>, ["~> 6.7"])
      s.add_runtime_dependency(%q<monetize>, ["~> 1.4.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_development_dependency(%q<database_cleaner>, ["< 1.4.0", ">= 0.8.0"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.0"])
    else
      s.add_dependency(%q<money>, ["~> 6.7"])
      s.add_dependency(%q<monetize>, ["~> 1.4.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<railties>, [">= 3.0"])
      s.add_dependency(%q<rails>, [">= 3.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_dependency(%q<database_cleaner>, ["< 1.4.0", ">= 0.8.0"])
      s.add_dependency(%q<test-unit>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<money>, ["~> 6.7"])
    s.add_dependency(%q<monetize>, ["~> 1.4.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<railties>, [">= 3.0"])
    s.add_dependency(%q<rails>, [">= 3.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
    s.add_dependency(%q<database_cleaner>, ["< 1.4.0", ">= 0.8.0"])
    s.add_dependency(%q<test-unit>, ["~> 3.0"])
  end
end
