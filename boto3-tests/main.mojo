from python import Python

fn main() raises:
    var py = Python()
    
    # Import required modules
    var langchain_aws = py.import_module("langchain_aws")
    var os = py.import_module("os")
    var dotenv = py.import_module("dotenv")
    var typing = py.import_module("typing")

     # Now you can access the types like this:
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
    
    # Debug prints to verify credentials
    print("AWS Access Key:", aws_access_key)
    print("AWS Region:", aws_region)
    
    # Create Bedrock client
    var llm = langchain_aws.ChatBedrockConverse()
    
    # Prepare the message
    var messages = py.list()
    messages.append(py.evaluate("('system', 'You are a helpful assistant')"))
    messages.append(py.evaluate("('human', 'HI')"))
    # Invoke the model
    var response = llm.invoke(messages)
    print("Response:", response)
