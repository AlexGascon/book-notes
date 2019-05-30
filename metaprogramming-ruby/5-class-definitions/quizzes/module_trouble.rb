module MyModule
  def self.my_method; 'hello'; end
end

"""
We want to include MyModule in a class definition so we can do 'MyClass.my_method' and make it work

Most developers try like this:

  class MyClass
    include MyModule
  end

But it doesn't actually work.

How would you create MyClass to achieve what we want to?
"""

class MyClass
  class << self
    include MyModule
  end
end

require 'test/unit'

class TestModuleTrouble < Test::Unit::TestCase
  def test_method_is_included
    MyClass.my_method
    assert true
  rescue NoMethodError
    assert false
  end
end