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
    var logs: PythonObject
    var log_file: PythonObject
    var current_level: Int
    var log_to_console: Bool
    var log_to_file: Bool
    var log_format: String
    var log_filters: PythonObject
    var log_counts: PythonObject
    var last_log: String
    var last_log_count: Int
    var log_context: PythonObject
    var log_encryption_key: String

    # ANSI Colors as class constants
    alias RESET = "\x1b[0m"
    alias RED = "\x1b[31m"
    alias GREEN = "\x1b[32m"
    alias YELLOW = "\x1b[33m"
    alias CYAN = "\x1b[36m"
    alias WHITE = "\x1b[37m"

    fn __init__(
        inout self,
        log_level: String = "DEBUG",
        log_file_path: String = "",
        log_to_console: Bool = True,
        log_to_file: Bool = False,
        log_format: String = "[{level}] {timestamp} - {message}",
        log_filters: PythonObject = None,
        log_context: PythonObject = None,
        log_encryption_key: String = ""
    ) raises:
        self.py = Python()
        self.builtins = self.py.import_module("builtins")
        self.datetime = self.py.import_module("datetime")
        self.logs = self.py.list()
        self.current_level = self.get_log_level(log_level)
        self.log_to_console = log_to_console
        self.log_to_file = log_to_file
        self.log_format = log_format
        self.log_filters = log_filters if log_filters is not None else self.py.list()
        self.log_counts = self.py.dict()
        self.last_log = ""
        self.last_log_count = 0
        self.log_context = log_context if log_context is not None else self.py.dict()
        self.log_encryption_key = log_encryption_key

        # Initialize log file if path provided
        if log_file_path != "":
            self.log_file = self.builtins.open(log_file_path, "a")
        else:
            self.log_file = None

    fn get_log_level(self, level: String) -> Int:
        if level == "DEBUG":
            return self.LOG_DEBUG
        elif level == "INFO":
            return self.LOG_INFO
        elif level == "WARN":
            return self.LOG_WARN
        elif level == "ERROR":
            return self.LOG_ERROR
        else:
            return self.LOG_DEBUG

    fn get_timestamp(self) raises -> String:
        var now = self.datetime.datetime.now()
        return String(now.strftime("%Y-%m-%d %H:%M:%S").__str__())

    fn log_message(self, level: String, message: String, level_num: Int) raises:
        # Check if we should log this message based on level
        if level_num < self.current_level:
            return

        # Check if we should log this message based on filters
        if self.log_filters.length() > 0:
            var should_log = False
            for filter in self.log_filters:
                if filter in message:
                    should_log = True
                    break
            if not should_log:
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

        var format_str = self.log_format
        format_str = format_str.replace("{level}", level)
        format_str = format_str.replace("{timestamp}", timestamp)
        format_str = format_str.replace("{message}", message)
        for key, value in self.log_context.items():
            format_str = format_str.replace("{" + key + "}", value)

        var log_line = String(format_str.__str__())

        # Encrypt sensitive information if key provided
        if self.log_encryption_key != "":
            log_line = self.encrypt_log(log_line)

        # Plain text version for file
        var plain_log = "[" + level + "] " + timestamp + " - " + message

        var py_log = self.builtins.str(log_line)
        self.logs.append(py_log)

        # Log to console if enabled
        if self.log_to_console:
            print(log_line)

        # Write to file if enabled
        if self.log_file is not None and self.log_to_file:
            self.log_file.write(plain_log + "\n")
            self.log_file.flush()

        # Update log counts
        if level in self.log_counts:
            self.log_counts[level] += 1
        else:
            self.log_counts[level] = 1

        # Implement log throttling
        if log_line == self.last_log:
            self.last_log_count += 1
            if self.last_log_count > 5:
                return
        else:
            self.last_log = log_line
            self.last_log_count = 1

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

    fn set_log_level(self, level: String):
        """Set minimum log level to display"""
        self.current_level = self.get_log_level(level)

    fn close(self) raises:
        """Close the log file if it's open"""
        if self.log_file is not None:
            self.log_file.close()

    fn encrypt_log(self, log_line: String) -> String:
        # Implement log encryption using the provided key
        # This is a placeholder for the actual encryption logic
        return log_line

    fn rotate_log_file(self, max_size: Int) raises:
        """Rotate the log file if it exceeds the maximum size"""
        if self.log_file is not None:
            var file_size = self.builtins.os.path.getsize(self.log_file.name)
            if file_size > max_size:
                self.log_file.close()
                var new_log_file_path = self.log_file.name + ".1"
                self.builtins.os.rename(self.log_file.name, new_log_file_path)
                self.log_file = self.builtins.open(self.log_file.name, "a")
