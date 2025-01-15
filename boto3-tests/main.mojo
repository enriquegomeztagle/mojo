from python import Python

fn main() raises:
    # Initialize Python runtime
    var py = Python()
    
    # Print Python path to debug - force flush output
    print(py.eval("import sys; print(sys.executable, flush=True)"))
    
    try:
        # Import boto3
        var boto3 = py.import_module("boto3")
    except:
        print("Failed to import boto3")
        print("Python path:", py.eval("import sys; ' '.join(sys.path)"))
