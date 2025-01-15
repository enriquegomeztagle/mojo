from python import Python

fn main() raises:
    # Initialize Python runtime
    var py = Python()
    
    # Print Python path to debug
    var python_path = py.eval("import sys; sys.executable")
    print("Python path:", python_path)
    
    try:
        # Import boto3
        var boto3 = py.import_module("boto3")
        print("Successfully imported boto3")
    except:
        print("Failed to import boto3")
        var sys_path = py.eval("import sys; sys.path")
        print("Python sys.path:", sys_path)
