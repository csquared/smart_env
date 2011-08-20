require 'spec_helper'

describe SmartEnv, 'decoration' do
  before do
    class PassOne < String
      attr_accessor :one
      def initialize(value)
        @one = true
        super
      end
    end

    class PassTwo < PassOne
      attr_accessor :two
      def initialize(value)
        @two = true
        super
      end
    end

    ENV.use(PassOne).when{ true }
    ENV.use(PassTwo).when{ true }
  end

  it "should pass successive value to all callbacks that match" do
    ENV['FOO'] = "bar"
    ENV['FOO'].one.should be_true
    ENV['FOO'].two.should be_true
  end
end
