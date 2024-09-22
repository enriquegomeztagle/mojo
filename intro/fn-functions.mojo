fn greet(name: String) -> String:
    var greeting = "Hello, " + name + "!"
    return greeting


# Here's everything to know about fn:

# Arguments must specify a type (except for the self argument in struct methods).

# Return values must specify a type, unless the function doesn't return a value.

# If you don't specify a return type, it defaults to None (meaning no return value).

# By default, arguments are received as an immutable reference (values are read-only, using the borrowed argument convention).

# This prevents accidental mutations, and permits the use of non-copyable types as arguments.

# If you want a local copy, you can simply assign the value to a local variable. Or, you can get a mutable reference to the value by declaring the inout argument convention).

# If the function raises an exception, it must be explicitly declared with the raises keyword. (A def function does not need to declare exceptions.)

# By enforcing these type checks, using the fn function helps avoid a variety of runtime errors.
