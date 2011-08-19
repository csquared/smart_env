require 'uri'
require 'forwardable'

module SmartEnv
  class UriProxy < BasicObject
    extend ::Forwardable
    def_delegators :@uri, *(::URI::Generic::COMPONENT + [:user, :password])

    def initialize(uri)
      @original = uri
      @uri = ::URI.parse(uri)
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
