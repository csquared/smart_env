require 'spec_helper'

describe SmartEnv, 'load/unload' do 
  before do
    class PassOne < String
      attr_accessor :one
      def initialize(key, value)
        @one = true
        super(value)
      end
    end

    @env = {} 
  end

  context "on extend" do
    before do
      @env.extend SmartEnv
    end

    after do
      @env.clear_registry if @env
    end

    it "should not bleed" do
      ENV['FOO'] = 'bar'
      @env['FOO'] = 'bar'
      @env.use(PassOne).when{ true }

      ENV['FOO'].should_not respond_to :one
      @env['FOO'].one.should be_true
    end
  end

  context "::clear_registry" do
    before do
      @env.extend SmartEnv
      @env.use(PassOne).when{ true }
    end

    it "should clear the hooks" do
      @env.clear_registry
      @env['FOO'].should_not respond_to :one
    end 

    it "should clear memoized values" do
      @env['FOO'] = 'test'
      memoized = @env['FOO']
      @env.clear_registry
      @env['FOO'].object_id.should_not == memoized.object_id
    end
  end
end
