# -*- encoding: utf-8 -*-
# stub: smart_listing 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "smart_listing"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sology"]
  s.date = "2015-04-01"
  s.description = "Ruby on Rails data listing gem with built-in sorting, filtering and in-place editing."
  s.email = ["contact@sology.eu"]
  s.homepage = "https://github.com/Sology/smart_listing"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "SmartListing helps creating sortable lists of ActiveRecord collections with pagination, filtering and inline editing."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.2"])
      s.add_runtime_dependency(%q<coffee-rails>, [">= 0"])
      s.add_runtime_dependency(%q<kaminari>, ["~> 0.16.1"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<bootstrap-sass>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<capybara-webkit>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.2"])
      s.add_dependency(%q<coffee-rails>, [">= 0"])
      s.add_dependency(%q<kaminari>, ["~> 0.16.1"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<bootstrap-sass>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<capybara-webkit>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.2"])
    s.add_dependency(%q<coffee-rails>, [">= 0"])
    s.add_dependency(%q<kaminari>, ["~> 0.16.1"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<bootstrap-sass>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<capybara-webkit>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
  end
end
