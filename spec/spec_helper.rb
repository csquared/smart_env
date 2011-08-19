require_relative '../lib/smart_env'

RSpec.configure do |config|
  config.after(:each) { SmartEnv.reset_registry }
end
