# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'tweetsearch/version'

Gem::Specification.new do |s|
  s.name        =  'tweetsearch'
  s.version     =  TweetSearch::VERSION

  s.summary     =  'Search Tweets on the Tweeter'
  s.description =  'Extracts tweets'
  s.authors     =  ['NoBetterThan97']
  s.email       =  ['m@cyhsu.me']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'tweetsearch'

  #s.add_runtime_dependency 'http', '~> 2.0'
  s.add_runtime_dependency 'httparty', '~> 0.14'
  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.42'
  s.add_development_dependency 'httparty', '~> 0.14'


  s.homepage    =  'https://github.com/NoBetterThan97/tweetsearch'
  s.license     =  'MIT'
end
