# You can build high-level abstractions for types (or "objects") as a struct.

# A struct in Mojo is similar to a class in Python: they both support methods, fields, operator overloading, decorators for metaprogramming, and so on. However, Mojo structs are completely static—they are bound at compile-time, so they do not allow dynamic dispatch or any runtime changes to the structure. (Mojo will also support Python-style classes in the future.)

struct MyPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second

    fn dump(self):
        print(self.first, self.second)

fn use_my_pair():
    var mine = MyPair(2,4)
    mine.dump()

fn main():
    use_my_pair()
