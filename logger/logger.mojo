from python import Python, PythonObject

struct Logger:
    # Add log levels as constants
    alias LOG_DEBUG = 0
    alias LOG_INFO = 1
    alias LOG_WARN = 2
    alias LOG_ERROR = 3

    var py: Python
    var builtins: PythonObject
    var datetime: PythonObject
    var json: PythonObject # Add json module
    var logs: PythonObject
    var log_file: PythonObject
    var current_level: Int

    # ANSI Colors as class constants
    alias RESET = "\x1b[0m"
    alias RED = "\x1b[31m"
    alias GREEN = "\x1b[32m"
    alias YELLOW = "\x1b[33m"
    alias CYAN = "\x1b[36m"
    alias WHITE = "\x1b[37m"

    var use_json: Bool

    var keywords: List[String] 
    var use_regex_filter: Bool
    var regex_pattern: PythonObject  # Store compiled regex

    fn __init__(
        inout self, log_level: Int = 0, log_file_path: String = "", use_json: Bool = False,
        keywords: List[String] = List[String](), regex_filter: String = ""
    ) raises:
        self.py = Python()
        self.builtins = self.py.import_module("builtins")
        self.datetime = self.py.import_module("datetime")
        self.json = self.py.import_module("json") # Import json module
        self.logs = self.py.list()
        self.current_level = log_level
        self.use_json = use_json

        self.regex_pattern = None

        # Initialize log file if path provided
        if log_file_path != "":
            self.log_file = self.builtins.open(log_file_path, "a")
        else:
            self.log_file = None

        self.keywords = keywords
        self.use_regex_filter = regex_filter != ""
        if self.use_regex_filter:
            re_module = self.py.import_module("re")
            self.regex_pattern = re_module.compile(regex_filter)

    fn get_timestamp(self) raises -> String:
        var now = self.datetime.datetime.now()
        return String(now.strftime("%Y-%m-%d %H:%M:%S").__str__())
    
    fn should_log(self, message: String, level_num: Int) raises -> Bool:
        if level_num < self.current_level:
            return False

        if self.use_regex_filter:
            if self.regex_pattern is not None and not self.regex_pattern.search(message): # <--- Check for None
                return False

        else:  # Keyword filtering (if no regex)
            if len(self.keywords) > 0:
                found = False
                for keyword in self.keywords:
                    if String(keyword[]) in message:
                        found = True
                        break
                if not found:
                    return False
        return True

    fn log_message(self, level: String, message: String, level_num: Int) raises:
        if not self.should_log(message, level_num): # Call the filtering function
            return
        # Check if we should log this message based on level
        if level_num < self.current_level:
            return
        var timestamp = self.get_timestamp()
        # Pick color based on level
        var color = self.WHITE
        if level == "INFO":
            color = self.GREEN
        elif level == "WARN":
            color = self.YELLOW
        elif level == "ERROR":
            color = self.RED
        elif level == "DEBUG":
            color = self.CYAN
        
        # Create a Python dictionary
        var log_record = self.py.dict()
        log_record["level"] = level
        log_record["timestamp"] = timestamp
        log_record["message"] = message
        
        var log_line: String
        var plain_log: String
        if self.use_json:
            log_line = String(self.json.dumps(log_record).__str__())
            plain_log = log_line
        else:
            var format_str = "{}[{}] {} - {}{}"
            var py_format = self.builtins.str(format_str)
            log_line = String(
                py_format.format(
                    color.__str__(),
                    level.__str__(),
                    timestamp.__str__(),
                    message.__str__(),
                    self.RESET.__str__(),
                ).__str__()
            )
            # Plain text version for file
            plain_log = "[" + level + "] " + timestamp + " - " + message
        
        var py_log = self.builtins.str(log_line)
        self.logs.append(py_log)
        print(log_line)
        # Write to file if enabled
        if self.log_file is not None:
            self.log_file.write(plain_log + "\n")
            self.log_file.flush()

    fn info(self, msg: String) raises:
        self.log_message("INFO", msg, self.LOG_INFO)

    fn warn(self, msg: String) raises:
        self.log_message("WARN", msg, self.LOG_WARN)

    fn error(self, msg: String) raises:
        self.log_message("ERROR", msg, self.LOG_ERROR)

    fn debug(self, msg: String) raises:
        self.log_message("DEBUG", msg, self.LOG_DEBUG)

    fn report_all(self) raises:
        print("\n===== LOG REPORT =====")
        for entry in self.logs:
            print(entry.__str__())

    fn set_log_level(self, level: Int):
        """Set minimum log level to display"""
        self.current_level = level

    fn close(self) raises:
        """Close the log file if it's open"""
        if self.log_file is not None:
            self.log_file.close()
