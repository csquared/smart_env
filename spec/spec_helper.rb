require_relative '../lib/smart_env'

RSpec.configure do |config|
  config.after(:each) do
    ENV.reset_registry
    @env.reset_registry if @env
  end
end
