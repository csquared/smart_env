require 'spec_helper'

describe SmartEnv, 'load/unload' do 
  context "on extend" do
    before do
      @env = {} 
      @env.extend SmartEnv

      class PassOne < String
        attr_accessor :one
        def initialize(key, value)
          @one = true
          super(value)
        end
      end
    end

    it "should not bleed" do
      ENV['FOO'] = 'bar'
      @env['FOO'] = 'bar'
      @env.use(PassOne).when{ true }

      ENV['FOO'].should_not respond_to :one
      @env['FOO'].one.should be_true
    end
  end
end
