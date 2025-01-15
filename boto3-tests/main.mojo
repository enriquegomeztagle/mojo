from python import Python

fn main() raises:
    var py = Python()
    
    # Import required modules
    var os = py.import_module("os")
    var dotenv = py.import_module("dotenv")
    var typing = py.import_module("typing")
    var bedrock = py.import_module("langchain_community.chat_models.bedrock")
    var messages_module = py.import_module("langchain_core.messages")

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
    
    # Create Bedrock client with explicit model name
    var llm = bedrock.BedrockChat(
        model_id="anthropic.claude-v2",
        region_name=aws_region,
        credentials_profile_name=None,
        model_kwargs={"temperature": 0.7, "max_tokens": 500}
    )
    
    # Prepare the message
    var messages = py.list()
    var SystemMessage = messages_module.SystemMessage
    var HumanMessage = messages_module.HumanMessage
    
    messages.append(SystemMessage(content="You are a helpful assistant"))
    messages.append(HumanMessage(content="HI"))
    # Invoke the model
    var response = llm.invoke(messages)
    print("Response:", response)
