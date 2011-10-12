require 'spec_helper'

describe SmartEnv, 'memoizing values' do 
  before do
    @env = {}
    @env.extend SmartEnv
    @env.use(SmartEnv::UriProxy)
    @env['TEST'] = 'http://service.com'
  end

  it "should return the same object after calling" do
    ENV['TEST'].object_id.should == ENV['TEST'].object_id
  end
end
