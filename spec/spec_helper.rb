
require 'simplecov'
SimpleCov.start

require_relative '../lib/influencer'
require 'bundler/setup'
Bundler.setup

require "byebug"
require "timeout"

RSpec.configure do |config|
  config.around(:each) do |example|
    Timeout::timeout(2) {
      example.run
    }
  end
end
