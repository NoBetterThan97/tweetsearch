# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

CREDENTIALS = YAML.load_file('config/credentials.yml')
TAGS = ['#food', '#yum'].freeze
