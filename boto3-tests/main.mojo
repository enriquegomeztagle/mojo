from python import Python

fn main() raises:
    var py = Python()
    var boto3 = py.import_module("boto3")
    
    # Create S3 client
    var s3_client = boto3.client("s3")
    
    # Get list of buckets
    var response = s3_client.list_buckets()
    
    # Filter and print buckets containing 'alsea'
    py.eval("""
buckets = boto3.client('s3').list_buckets()['Buckets']
alsea_buckets = [bucket['Name'] for bucket in buckets if 'alsea' in bucket['Name'].lower()]
print('Buckets containing "alsea":')
for bucket in alsea_buckets:
    print(f'- {bucket}')
""")
