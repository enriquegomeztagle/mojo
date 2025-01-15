from python import Python
from logger import Logger

fn main() raises:
    # Initialize logger with file output and INFO level
    var logger = Logger(
        log_level=Logger.LOG_INFO,  # Only show INFO and above
        log_file_path="app.log"     # Save logs to app.log
    )

    try:

    var py = Python()

    # --- Import required Python modules ---
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

    logger.info("Loading environment variables using dotenv.")

    # --- Load environment variables ---
    dotenv.load_dotenv()

    logger.info("Retrieving AWS credentials from environment variables.")

    # --- Check AWS credentials ---
    var aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
    var aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
    var aws_region = os.getenv("AWS_DEFAULT_REGION")
    var model_id = os.getenv("BEDROCK_MODEL_ID")

    logger.info("AWS Region is " + String(aws_region.__str__()))
    logger.info("Model ID is " + String(model_id.__str__()))

    # --- Create Bedrock client with explicit model name ---
    logger.info("Creating Bedrock client with model: " + String(model_id.__str__()))
    var bedrock_runtime = boto3.client(
        service_name="bedrock-runtime",
        region_name=aws_region
    )

    logger.info("Initializing ChatBedrockConverse with temperature=0, max_tokens=None")
    var llm = ChatBedrockConverse(
        model_id=model_id,
        temperature=0,
        max_tokens=None,
        client=bedrock_runtime,
    )

    var messages = "HI"
    logger.info("Invoking the model with message: " + messages)

    # --- Invoke the model ---
    var response = llm.invoke(messages)

    logger.info("Model responded with content. Printing response.")
    print("Response:", response.content)
    
    finally:
        # Make sure to close the log file
        logger.close()
