require "smart_env/version"
require "smart_env/uri_proxy"

module SmartEnv
  extend self

  @@loaded   = false
  @@registry = []

  def reset_registry
    @@registry = [
      [lambda{ |k,v| v.match(/^\w+:\/\//) }, UriProxy]
    ]
  end

  def use(klass)
    @class = klass
    self
  end

  def when(&block)
    raise "Block must take 0 or 2 arguments" unless ( block.arity == 0 || block.arity == 2)
    @@registry << [block, @class]
    self
  end

  def [](key)
    value = ENV.get(key)
    @@registry.each do |condition, klass|
      result = condition.call(key, value) rescue false
      return klass.new(value) if result
    end
    value
  end

  def unload!
    class << ENV
      alias_method :[], :get  
      alias_method :[]=, :set
    end
    @@loaded = false
  end

  def load!
    reset_registry
    return if @@loaded
    class << ENV
      alias_method :get, :[]  

      def [](key)
        SmartEnv[key]
      end
    end
    @@loaded = true
  end
end

SmartEnv.load!
