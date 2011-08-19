require 'spec_helper'

describe SmartEnv, 'registering your own Proxies' do
  before do
    class TestProxy
      def initialize(value)
      end
    end
    SmartEnv.use(TestProxy).when { |key, value| key == 'FOO' }
  end

  it "should use the specified proxy when the block returns true" do
    ENV['FOO'] = 'bar'
    ENV['FOO'].should be_a(TestProxy)
    ENV['BAR'] = 'bar'
    ENV['BAR'].should == 'bar'
    ENV['BAR'].should be_a(String)
  end

  it "raises error if the block doens't have two args" do
    lambda { SmartEnv.use(TestProxy).when { |k,v,x| name == 'FOO' } }.should raise_error
    lambda { SmartEnv.use(TestProxy).when { |value| name == 'FOO' } }.should raise_error
    lambda { SmartEnv.use(TestProxy).when { false } }.should_not raise_error
  end
end
