# Now we need to enable the possibility of specifying the validation through a
# block.

class Object
  def attr_checked(attribute, &validation)
    self.class_eval do
      define_method attribute do
        instance_variable_get("@#{attribute}")
      end

      define_method "#{attribute}=" do |value|
        raise 'Invalid attribute' unless validation.call(value)

        instance_variable_set("@#{attribute}", value)
      end
    end
  end
end

# Note: even if this works, it's a bit a matter of luck: in order to make 
# attr_checked a class method it should have been added to Class, not to Object
#
# This works too simply because Class inherits from Object too. I've left it
# as it is to reflect my original solution, instead of just modifying it to
# mimic the one used in the book.