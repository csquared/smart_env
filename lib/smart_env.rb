require "smart_env/version"
require "smart_env/uri_proxy"

module SmartEnv
  attr_accessor :registry

  def clear_registry
    @registry = []
  end

  def reset_registry
    @registry = default
  end

  def default
    []
  end

  def use(klass)
    @class = klass
    if @class.respond_to? :when
      registry << [@class, lambda { |k,v| @class.when(k,v)  }]
    end
    self
  end

  def when(&block)
    raise "Block must take 0 or 2 arguments: key and value" unless (block.arity == 0 || block.arity == 2)
    registry << [@class, block]
    self
  end

  def registry
    @registry ||= default
  end

  def unload!
    class << self
      alias_method :[], :get  
#      alias_method :[]=, :set
    end
  end

  def self.extended(base)
    class << base
      alias_method :get, :[]  

      def [](key)
        value = get(key)
        registry.each do |klass, condition|
          result = condition.call(key, value) rescue false
          value  = klass.new(key, value) if value && result
        end
        value
      end
    end
  end
end

ENV.extend SmartEnv
