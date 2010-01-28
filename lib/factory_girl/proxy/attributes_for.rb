class Factory
  class Proxy #:nodoc:
    class AttributesFor < Proxy #:nodoc:
      def initialize(klass)
        @hash = {}
      end

      def get(attribute)
        if @instance.respond_to? attribute
          @hash[attribute]
        else
          @locals[attribute]
        end
      end

      def set(attribute, value)
        if @instance.respond_to? :"#{attribute}="
          @hash[attribute] = value
        else
          @locals[attribute] = value
        end
      end

      def result
        @hash
      end
    end
  end
end
