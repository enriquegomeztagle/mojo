# Mojo functions can be declared with either fn or def.

# The fn declaration enforces type-checking and memory-safe behaviors (Rust style), while def allows no type declarations and dynamic behaviors (Python style).

def greet(name):
    return "Hello, " + name + "!"

fn greet2(name: String) -> String:
    return "Hello, " + name + "!"

def main():
    print(greet("world"))
    print(greet2("world"))
