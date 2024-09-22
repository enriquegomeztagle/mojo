# In Mojo, a parameter is a compile-time variable that becomes a runtime constant, and it's declared in square brackets on a function or struct. Parameters allow for compile-time metaprogramming, which means you can generate or modify code at compile time.

# Many other languages use "parameter" and "argument" interchangeably, so be aware that when we say things like "parameter" and "parametric function," we're talking about these compile-time parameters. Whereas, a function "argument" is a runtime value that's declared in parentheses.

# Parameterization is a complex topic that's covered in much more detail in the Metaprogramming section, but we want to break the ice just a little bit here. To get you started, let's look at a parametric function:

fn repeat[count: Int](msg: String):
    for _ in range(count):
        print(msg)

fn call_repeat():
    repeat[3]("hello")

fn main():
    call_repeat()
