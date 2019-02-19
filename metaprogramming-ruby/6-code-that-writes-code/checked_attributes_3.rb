# Now we need to enable the possibility of specifying the validation through a
# block. 

def add_checked_attribute(klass, attribute, &validation)
  klass.class_eval do
    define_method attribute do
      instance_variable_get("@#{attribute}")
    end

    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless validation.call(value)
        
      instance_variable_set("@#{attribute}", value)
    end
  end
end