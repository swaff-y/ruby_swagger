# frozen_string_literal: true

require_relative './lib/config'

Gem::Specification.new do |s|
  s.name        = 'ruby_swagger'
  s.version     = Swagger::Config.version
  s.summary     = 'A'
  s.description = 'A cli tool for creating swagger files'
  s.authors     = ['Kyle Swaffield']
  s.email       = 'kyle@swaff.com.au'
  s.files       = Dir[
    "{lib}/**/*.*", 
    "bin/*", 
    "LICENSE", 
    "CHANGELOG.md", 
    "README.md"
  ]
  s.homepage    = 'https://rubygems.org/gems/ruby_swagger'
  s.license     = 'MIT'
  s.executables << 'swagger'
  s.required_ruby_version = '>= 3.2.2'
end