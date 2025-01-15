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
    var log_file: PythonObject  # For file output
    var current_level: Int      # For log filtering
    
    # ANSI Colors as class constants
    alias RESET = "\x1b[0m"
    alias RED = "\x1b[31m"
    alias GREEN = "\x1b[32m"
    alias YELLOW = "\x1b[33m"
    alias CYAN = "\x1b[36m"
    alias WHITE = "\x1b[37m"

    fn __init__(inout self, log_level: Int = 0, log_file_path: String = "") raises:
        self.py = Python()
        self.builtins = self.py.import_module("builtins")
        self.datetime = self.py.import_module("datetime")
        self.logs = self.py.list()
        self.current_level = log_level
        
        # Initialize log file if path provided
        if log_file_path != "":
            self.log_file = self.builtins.open(log_file_path, "a")
        else:
            self.log_file = None

    fn get_timestamp(self) raises -> String:
        var now = self.datetime.datetime.now()
        return String(now.strftime("%Y-%m-%d %H:%M:%S").__str__())

    fn log_message(self, level: String, message: String, level_num: Int) raises:
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

        var format_str = "{}[{}] {} - {}{}"
        var py_format = self.builtins.str(format_str)
        var log_line = String(py_format.format(
            color.__str__(),
            level.__str__(),
            timestamp.__str__(),
            message.__str__(),
            self.RESET.__str__()
        ).__str__())

        # Plain text version for file
        var plain_log = "[" + level + "] " + timestamp + " - " + message

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

    fn clear_logs(self):
        """Clear the in-memory log history"""
        self.logs = self.py.list()

    fn set_log_level(self, level: Int):
        """Set minimum log level to display"""
        self.current_level = level

    fn close(self) raises:
        """Close the log file if it's open"""
        if self.log_file is not None:
            self.log_file.close()
