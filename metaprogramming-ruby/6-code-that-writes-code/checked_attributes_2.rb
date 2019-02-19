# Your next step is refactoring add_checked_attribute and replacing eval with
# regular Ruby methods
#
# The same tests (the ones on test_checked_attribute.rb) apply

def add_checked_attribute(klass, attribute)
  klass.class_eval do
    define_method attribute do
      instance_variable_get("@#{attribute}")
    end

    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless value
        
      instance_variable_set("@#{attribute}", value)
    end
  end
end