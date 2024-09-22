# You can declare variables with the var keyword. Or, if your code is in a def function, you can omit the var (in an fn function, you must include the var keyword).

# def do_math(x):
#     var y = x + x
#     y = y * y
#     print(y)

# def add_one(x):
#     var y: Int = 1
#     print(x + y)

# def main():
#     do_math(2)
#     add_one(2)

# Explicit type declaration
var a = 5
var b: Float64 = 3.14

# Implicit type declaration
# c = 5
# d = 3.14

# Both types of variables are strongly-typed: the variable receives a type when it's created, and the type never changes. You can't assign a variable a value of a different type:
# count = 8 # count is type Int
# count = "Nine?" # Error: can't implicitly convert 'StringLiteral' to 'Int'

# Implicit conversions from other types
var temperature: Float64 = 99

# def main():
#     print(temperature)

# Implicit-declared variables are scoped at function level
# name = String("Sam")
# user_id = 0

# Explicit-declared variables
var name = String("Sam")
# var value: Float64 # Unassigned can be out of global variables

# Type annotations
# var name: Type = value
# var name: String = get_name()

var name1: String = "Sam"
var name2 = String("Sam")

fn my_function(x: Int):
    var z: Float32 # Only create but not assign
    if x != 0:
        z = 1.0
    else:
        z = foo()
    print(z)

fn foo() -> Float32:
    return 3.14

# var z: Float32
#var y = z # Error: use of uninitialized value 'z'

# Conversions
var number: Float64 = 1
var number2 = Float64(1)

fn take_float(value: Float64):
    print(value)

fn pass_integer():
    var value: Int = 1
    take_float(value)

def lexical_scopes():
    var num = 1
    var dig = 1
    if num == 1:
        print("num:", num)  # Reads the outer-scope "num"
        var num = 2         # Creates new inner-scope "num"
        print("num:", num)  # Reads the inner-scope "num"
        dig = 2             # Updates the outer-scope "dig"
    print("num:", num)      # Reads the outer-scope "num"
    print("dig:", dig)      # Reads the outer-scope "dig"

def main():
    # lexical_scopes()
    function_scopes()

# Variables declared with var are bound by lexical scoping. This means that nested code blocks can read and modify variables defined in an outer scope. But an outer scope cannot read variables defined in an inner scope at all.
def function_scopes():
    num = 1
    if num == 1:
        print(num)   # Reads the function-scope "num"
        num = 2      # Updates the function-scope variable
        print(num)   # Reads the function-scope "num"
    print(num)       # Reads the function-scope "num"
