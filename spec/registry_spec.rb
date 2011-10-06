require 'spec_helper'
shared_examples_for "all proxies" do

  it "should use the specified proxy when the block or when returns true" do
    ENV['FOO'] = 'bar'
    ENV['FOO'].should be_a(TestProxy)
    ENV['BAR'] = 'bar'
    ENV['BAR'].should == 'bar'
    ENV['BAR'].should be_a(String)
  end
end

describe SmartEnv, 'registering your own Proxies' do
  context 'with a bloack' do
    before do
      class TestProxy
        def initialize(key, value)
        end
      end
      ENV.use(TestProxy).when { |key, value| key == 'FOO' }
    end

    it_should_behave_like "all proxies"

    it "raises error if the block doens't have two args" do
      lambda { ENV.use(TestProxy).when { |k,v,x| name == 'FOO' } }.should raise_error
      lambda { ENV.use(TestProxy).when { |value| name == 'FOO' } }.should raise_error
      lambda { ENV.use(TestProxy).when { false } }.should_not raise_error
    end
  end

  context 'with a class that implements ::when' do
    before do
      class TestProxy
        def initialize(key, value)
        end
        
        def self.when(key, value)
          key == 'FOO'
        end
      end
      ENV.use(TestProxy)
    end

    it_should_behave_like "all proxies"
  end
end


