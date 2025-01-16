from logger import Logger

fn main() raises:
    var keywords = List[String]()
    keywords.append("atch")

    var logger = Logger(log_level=Logger.LOG_DEBUG,
    keywords=keywords
    # , regex_filter=r"warning|special"
    )

    logger.debug("This is a debug message (should not be logged unless level is DEBUG).")
    logger.info("This is an important info message (keyword match).")
    logger.warn("This is a warning message (regex match).")
    logger.error("This is an error message.")
    logger.info("This is another info message (no match).")
    logger.warn("This is a special warning (regex match).")
    logger.info("Unimportant message")

    logger.report_all()

    # Test JSON logging
    var json_logger = Logger(log_level=Logger.LOG_INFO, use_json=True)
    json_logger.info("This is a JSON formatted log message.")
    json_logger.warn("Another JSON warning.")
    json_logger.report_all()

    # Test file logging
    var file_logger = Logger(log_level=Logger.LOG_DEBUG, log_file_path="app.log")
    file_logger.debug("This debug message goes to the file.")
    file_logger.info("Info to file")
    file_logger.close()

