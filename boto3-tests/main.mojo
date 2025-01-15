from python import Python
from logger import get_logger

fn main() raises:
    # Get logger functions
    var info, warn, error, debug, report_all = get_logger()

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

    info("Loading environment variables using dotenv.")

    # --- Load environment variables ---
    dotenv.load_dotenv()

    info("Retrieving AWS credentials from environment variables.")

    # --- Check AWS credentials ---
    var aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
    var aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
    var aws_region = os.getenv("AWS_DEFAULT_REGION")
    var model_id = os.getenv("BEDROCK_MODEL_ID")

    info("AWS Region is " + String(aws_region.__str__()))
    info("Model ID is " + String(model_id.__str__()))

    # --- Create Bedrock client with explicit model name ---
    info("Creating Bedrock client with model: " + String(model_id.__str__()))
    var bedrock_runtime = boto3.client(
        service_name="bedrock-runtime",
        region_name=aws_region
    )

    info("Initializing ChatBedrockConverse with temperature=0, max_tokens=None")
    var llm = ChatBedrockConverse(
        model_id=model_id,
        temperature=0,
        max_tokens=None,
        client=bedrock_runtime,
    )

    var messages = "HI"
    info("Invoking the model with message: " + messages)

    # --- Invoke the model ---
    var response = llm.invoke(messages)

    info("Model responded with content. Printing response.")
    print("Response:", response.content)
