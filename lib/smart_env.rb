require "smart_env/version"
require "smart_env/uri_proxy"

module SmartEnv
  attr_accessor :registry

  def clear_registry
    @registry = empty_registry
  end

  def empty_registry
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
    raise "Block must take 0 or 2 arguments: key and value" unless (block.arity < 1 || block.arity == 2)
    registry << [@class, block]
    self
  end

  def registry
    @registry ||= empty_registry
  end

  def self.extended(base)
    raise RuntimeError.new("#{base.inspect} doesn't respond to #[]") \
      unless base.respond_to? :[]

    class << base
      alias_method :__get, :[]  

      def [](key)
        value = __get(key)
        registry.each do |klass, condition|
          result = condition.call(key, value) rescue false
          value  = klass.new(key, value) if value && result
        end
        value
      end
    end
  end
end
