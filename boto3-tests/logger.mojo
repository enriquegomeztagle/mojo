from python import Python

struct Logger:
    var py: Python
    var builtins: PythonObject
    var datetime: PythonObject
    var logs: PythonObject
    
    # ANSI Colors as class constants
    alias RESET = "\x1b[0m"
    alias RED = "\x1b[31m"
    alias GREEN = "\x1b[32m"
    alias YELLOW = "\x1b[33m"
    alias CYAN = "\x1b[36m"
    alias WHITE = "\x1b[37m"

    fn __init__(inout self):
        self.py = Python()
        self.builtins = self.py.import_module("builtins")
        self.datetime = self.py.import_module("datetime")
        self.logs = self.py.list()

    fn get_timestamp(self) -> String:
        var now = self.datetime.datetime.now()
        return String(now.strftime("%Y-%m-%d %H:%M:%S").__str__())

    fn log_message(self, level: String, message: String):
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

        var py_log = self.builtins.str(log_line)
        self.logs.append(py_log)
        print(log_line)

    fn info(self, msg: String):
        self.log_message("INFO", msg)

    fn warn(self, msg: String):
        self.log_message("WARN", msg)

    fn error(self, msg: String):
        self.log_message("ERROR", msg)

    fn debug(self, msg: String):
        self.log_message("DEBUG", msg)

    fn report_all(self):
        print("\n===== LOG REPORT =====")
        for entry in self.logs:
            print(entry.__str__())
