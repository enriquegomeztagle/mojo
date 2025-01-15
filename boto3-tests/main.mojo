from python import Python

fn main() raises:
    # Initialize Python runtime
    var py = Python()
    
    # Print Python path to debug
    print(py.eval("import sys; sys.executable"))
    
    # Import boto3
    var boto3 = py.import_module("boto3")
