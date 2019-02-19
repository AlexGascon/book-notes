def add_checked_attribute(klass, attribute)
  methods = <<~METHOD_SOURCE
    class #{klass}
      def #{attribute}=(value)
        raise 'Invalid attribute' unless value
        @#{attribute} = value
      end

      def #{attribute}
        @#{attribute}
      end
    end
  METHOD_SOURCE

  eval methods
end