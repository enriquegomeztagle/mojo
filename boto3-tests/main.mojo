from python import Python

fn main() raises:
    var py = Python()
    
    # Import required modules
    var os = py.import_module("os")
    var dotenv = py.import_module("dotenv")
    var typing = py.import_module("typing")
    var boto3 = py.import_module("boto3")
    var ChatBedrockConverse = py.import_module("langchain_aws").ChatBedrockConverse
    
    var Optional = typing.Optional
    var Dict = typing.Dict
    var List = typing.List
    var Tuple = typing.Tuple
    var Any = typing.Any
    
    # Load environment variables
    dotenv.load_dotenv()
    
    # Check AWS credentials
    var aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
    var aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
    var aws_region = os.getenv("AWS_DEFAULT_REGION")
    var model_id = os.getenv("BEDROCK_MODEL_ID")
    
    # Create Bedrock client with explicit model name
    var bedrock_runtime = boto3.client(
        service_name="bedrock-runtime",
        region_name=aws_region
    )

    llm = ChatBedrockConverse(
        model_id=model_id,
        temperature=0,
        max_tokens=None,
        client=bedrock_runtime,
    )
    messages = "HI"
    # Invoke the model
    var response = llm.invoke(messages)
    print("Response:", response.content)
