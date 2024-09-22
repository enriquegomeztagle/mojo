def greet(name):
    greeting = "Hello, " + name + "!"
    return greeting

# Compared to an fn function, a def function has fewer restrictions. The def function works more like a Python def function. For example, this function works the same in Python and Mojo:

def greet(name: String) -> String:
    var greeting = "Hello, " + name + "!"
    return greeting

# In a Mojo def function, you have the option to specify the argument type and the return type. You can also declare variables with var, with or without explicit typing. So you can write a def function that looks almost exactly like the fn function shown earlier:

# Here's everything to know about def:

# Arguments don't require a declared type.

# Undeclared arguments are actually passed as an object, which allows the function to receive any type (Mojo infers the type at runtime).

# Return types don't need to be declared, and also default to object. (If a def function doesn't declare a return type of None, it's considered to return an object by default.)

# Arguments are mutable. Arguments default to using the borrowed argument convention) like an fn function, with a special addition: if the function mutates the argument, it makes a mutable copy.

# If an argument is an object type, it's received as a reference, following object reference semantics.

# If an argument is any other declared type, it's received as a value.

fn my_pow(base: Int, exp: Int = 2) -> Int:
    return base ** exp

fn use_defaults():
    # Uses the default value for `exp`
    var z = my_pow(3)
    print(z)

# Optional arguments
# An optional argument is one that includes a default value, such as the exp argument here:

fn my_pow2(base: Int, exp: Int = 2) -> Int:
    return base ** exp

fn use_keywords():
    # Uses keyword argument names (with order reversed)
    var z = my_pow2(exp=3, base=2)
    print(z)

# You can also use keyword arguments when calling a function. Keyword arguments are specified using the format+
# argument_name = argument_value

fn sum(*values: Int) -> Int:
  var sum: Int = 0
  for value in values:
    sum = sum + value
  return sum

# Variadic arguments
# Variadic arguments let a function accept a variable number of arguments. To define a function that takes a variadic argument, use the variadic argument syntax
# *argument_name
fn add(x: Int, y: Int) -> Int:
    return x + y

fn add(x: String, y: String) -> String:
    return x + y

# If a def function does not specify argument types, then it can accept any data type and decide how to handle each type internally. This is nice when you want expressive APIs that just work by accepting arbitrary inputs, so there's usually no need to write function overloads for a def function.

# On the other hand, all fn functions must specify argument types, so if you want a function to work with different data types, you need to implement separate versions of the function that each specify different argument types. This is called "overloading" a function.
