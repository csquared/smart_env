require 'uri'
require 'cgi'
require 'forwardable'

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

    def base_uri
      base = "#{@uri.scheme}://#{@uri.host}"
      (@uri.port ? "#{base}:#{@uri.port}" : base) + '/'
    end
    alias url base_uri

    def method_missing(method, *args, &block)
      @original.send(method, *args, &block) 
    end
  end
end
