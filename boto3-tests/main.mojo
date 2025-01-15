from python import Python

fn main() raises:
    # Initialize Python runtime
    var py = Python()
    
    # Print Python path to debug - using print() inside the Python eval
    py.eval("import sys; print('Python executable:', sys.executable)")
    
    try:
        # Import boto3
        var boto3 = py.import_module("boto3")
        print("Successfully imported boto3")
    except:
        print("Failed to import boto3")
        # Print sys.path directly from Python
        py.eval("import sys; print('Python sys.path:', sys.path)")
