from python import Python

fn main() raises:
    var py = Python()
    
    # Import required modules
    var langchain_aws = py.import_module("langchain_aws")
    var os = py.import_module("os")
    var dotenv = py.import_module("dotenv")
    
    # Load environment variables
    dotenv.load_dotenv()
    
    # Create Bedrock client
    var llm = langchain_aws.ChatBedrockConverse()
    
    # Prepare the message
    var messages = [
        {"role": "user", "content": "Hello, how are you?"}
    ]
    
    # Invoke the model
    var response = llm.invoke(messages)
    print("Response:", response)
