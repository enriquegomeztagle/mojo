from python import Python

fn use_numpy() raises:
    var np = Python.import_module("numpy")
    var ar = np.arange(15).reshape(3, 5)
    print(ar)
    print(ar.shape)

fn main():
    try:
        use_numpy()
    except Exception:
        print("Error: Failed to import numpy")
