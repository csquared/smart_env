require 'spec_helper'

describe SmartEnv, 'uri support' do
  before do
    ENV.use(SmartEnv::UriProxy)
  end

  context "with a value FOO that is not a URI" do
    before do
      ENV['FOO'] = 'bar'
    end

    it "should not wrap it" do
      lambda { ENV['FOO'].scheme }.should raise_error(::NoMethodError)
    end
  end

  context "with a value FOO that is a URI" do
    before do
      @url = 'http://username:password@this.domain.example.com:3000/path?var=val'
      ENV['FOO'] = @url
    end

    it "should leave the original value unchanged" do
      ENV['FOO'].should == @url
    end

    it "should return scheme://host:port for #base_uri" do
      ENV['FOO'].base_uri.should == 'http://this.domain.example.com:3000'
      ENV['FOO'] = @url.gsub(':3000','')
      ENV['FOO'].base_uri.should == 'http://this.domain.example.com:80'
    end

    it "should return scheme://host for #base_uri(false)" do
      ENV['FOO'].base_uri(false).should == 'http://this.domain.example.com'
    end

    it "should respond to #scheme with the scheme" do
      ENV['FOO'].scheme.should == 'http'
    end

    it "should respond to #host with the host" do
      ENV['FOO'].host.should == 'this.domain.example.com'
    end

    it "should respond to #password with the password" do
      ENV['FOO'].password.should == 'password'
    end

    it "should respond to #user with the user" do
      ENV['FOO'].user.should == 'username'
    end

    it "should respond to #port with the port" do
      ENV['FOO'].port.should == 3000
    end

    it "should expose params via the #params method" do
      ENV['FOO'].params['var'].should == 'val'
    end
  end
end
