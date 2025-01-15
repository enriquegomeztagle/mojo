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

    Messages = List[Tuple[str, str]]
    
    # Load environment variables
    dotenv.load_dotenv()
    
    # Create Bedrock client
    var llm = langchain_aws.ChatBedrockConverse()
    
    # Prepare the message
    # messages = [("system", "You are a helpful assistant"), ("human", "HI")]
    # Invoke the model
    # var response = llm.invoke(messages)
    # print("Response:", response)
