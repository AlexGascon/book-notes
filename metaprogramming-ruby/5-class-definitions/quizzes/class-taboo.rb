# Did you ever play Taboo?[8] The rules are simple: you’re given a secret word
# and a list of words that you cannot use. (They are “taboo.”) You must help a
# teammate guess the secret word. You can give your teammate as many suggestions
# as you want, but you must never say a taboo word. If you do that, you lose
# immediately.
#
# Your challenge: play Taboo with Ruby code. You have only one taboo word, the
# class keyword. Your “secret word” is actually a Ruby class:
#
#   ​class​ MyClass < Array  ​ 	
#     ​def​ my_method
#       ​'Hello!'​
#     ​end​
#   ​end​
#
# You have to write a piece of code that has exactly the same effect as the
# previous one, without ever using the class keyword. Are you up to the
# challenge? (Just one hint: look at the documentation for Class.new)

MyClass = Class.new(super_class=Array) do
  def my_method
    'Hello!'
  end
end
