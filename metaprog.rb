# Dynamic method (parse another class for data)

class AnotherClass
  def get_foo_stuff; end

  def get_bar_stuff; end

  def get_baz_stuff; end
end

class Baz
  def initialize(a_class)
    a_class.methods.grep(/^get_(.*)_stuff$/) do
      meth = Regexp.last_match(1)

      Baz.create_method meth
    end
  end

  def self.create_method(method)
    pp method
    define_method "my_#{method}" do
      puts "Dynamic method called 'my_#{method}'"
    end
  end
end

# another_class = AnotherClass.new
# baz = Baz.new(another_class)
# p baz.my_foo # => "Dynamic method called 'my_foo'"
# p baz.my_bar # => "Dynamic method called 'my_bar'"
# p baz.my_baz # => "Dynamic method called 'my_baz'"


##############################################################

# Dynamic proxies

class Foo
  def method_missing(message, *args, &block)
    return get(Regexp.last_match(1).to_sym, *args, &block) if /^get_(.*)$/ =~ message.to_s
    super # if we don't find a match then we'll call the top level `BasicObject#method_missing`
  end

  private

  def get(smth)
    p "I've got #{smth.to_s.split('_').join(' ')}"
  end
end

# Foo.new.get_a_lot_of_money
# Foo.new.get_big_house
# Foo.new.get_new_car

##############################################################

# Flattening the Scope (aka Nested Lexixal Scopes)

my_var = 'abc'

class OuterScopeGate
  # puts my_var

  def inner_scope_gate
    puts my_var
  end
end

# OuterScopeGate.new.inner_scope_gate # fires 2 exceptions

MyClass = Class.new do
  puts "Here is `my_var` inside my class definition: #{my_var}"

  define_method :my_method do
    puts "Here is `my_var` inside my class instance method: #{my_var}"
  end
end

# MyClass.new.my_method