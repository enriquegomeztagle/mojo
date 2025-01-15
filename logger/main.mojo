from logger import Logger


fn main() raises:
    var logger = Logger(
        log_level=Logger.LOG_INFO,
        log_file_path="app.log",
    )

    try:
        logger.info("This is an info message")
        logger.warn("This is a warning message")
        logger.error("This is an error message")
        logger.debug("This is a debug message")
    finally:
        logger.report_all()
        logger.close()
