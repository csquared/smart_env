require 'uri'
require 'cgi'
require 'forwardable'

class BasicObject
  instance_methods.each { |m| undef_method m unless m =~ /^__|instance_eval/ }
end unless defined?(BasicObject)

module SmartEnv
  class UriProxy < BasicObject
    attr_reader :params
    extend ::Forwardable
    def_delegators :@uri, *(::URI::Generic::COMPONENT + [:user, :password])

    def initialize(_key, uri)
      @original = uri
      @uri = ::URI.parse(uri)
      @params = ::CGI.parse(@uri.query.to_s)
      @params.each do |key, values|
        @params[key] = values.first if values.size == 1
      end
    end

    #for SmartEnv
    def self.when(key, value)
      value.match(/^\w+:\/\//) 
    end

    def base_uri(port = false)
      base = "#{@uri.scheme}://#{@uri.host}"
      port ? "#{base}:#{@uri.port}" : base
    end

    def method_missing(method, *args, &block)
      @original.send(method, *args, &block) 
    end
  end
end
