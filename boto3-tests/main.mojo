from python import Python

fn main() raises:
    var py = Python()
    var boto3 = py.import_module("boto3")
    
    # Create S3 client
    var s3_client = boto3.client("s3")
    
    # Get list of buckets
    var response = s3_client.list_buckets()
    var buckets = response["Buckets"]
    
    print('Buckets containing "alsea":')
    # Iterate through buckets and filter
    for bucket in buckets:
        var bucket_name = bucket["Name"]
        if "alsea" in bucket_name.lower():
            print("- ", bucket_name)
