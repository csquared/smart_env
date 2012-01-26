require File.expand_path('../../lib/smart_env', __FILE__)
require 'rspec/core'
require 'smart_env/auto'

RSpec.configure do |config|
  config.after(:each) do
    ENV.clear_registry
  end
end
