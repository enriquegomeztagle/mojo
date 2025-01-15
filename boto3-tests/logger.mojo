from python import Python

def main():
    # -----------------------------------------
    # 1) Acquire Python builtins and modules
    # -----------------------------------------
    var py = Python()
    var builtins = py.import_module("builtins")
    var datetime = py.import_module("datetime")

    # Python list to store log entries
    var logs = py.list()

    # -----------------------------------------
    # 2) Define all ANSI color codes as String
    # -----------------------------------------
    var RESET = "\x1b[0m"
    var RED   = "\x1b[31m"
    var GREEN = "\x1b[32m"
    var YELLOW= "\x1b[33m"
    var CYAN  = "\x1b[36m"
    var WHITE = "\x1b[37m"

    # -----------------------------------------
    # 3) Helper to get current time as String
    # -----------------------------------------
    def get_timestamp() -> String:
        var now = datetime.datetime.now()
        return String(now.strftime("%Y-%m-%d %H:%M:%S").__str__())

    # -----------------------------------------
    # 4) Core log function
    # -----------------------------------------
    def log_message(level: String, message: String):
        var timestamp = get_timestamp()

        # Pick a color based on level
        var color = WHITE
        if level == "INFO":
            color = GREEN
        elif level == "WARN":
            color = YELLOW
        elif level == "ERROR":
            color = RED
        elif level == "DEBUG":
            color = CYAN

        # Use Python's string formatting
        var format_str = "{}[{}] {} - {}{}"
        var py_format = builtins.str(format_str)
        var log_line = String(py_format.format(
            color.__str__(),
            level.__str__(),
            timestamp.__str__(),
            message.__str__(),
            RESET.__str__()
        ).__str__())

        # Convert to Python string for storage
        var py_log = builtins.str(log_line)
        logs.append(py_log)

        # Print using Mojo's print
        print(log_line)

    # -----------------------------------------
    # 5) Shortcut functions for each level
    # -----------------------------------------
    def info(msg: String):
        log_message("INFO", msg)

    def warn(msg: String):
        log_message("WARN", msg)

    def error(msg: String):
        log_message("ERROR", msg)

    def debug(msg: String):
        log_message("DEBUG", msg)

    # -----------------------------------------
    # 6) Report all logs
    # -----------------------------------------
    def report_all():
        print("\n===== LOG REPORT =====")
        for entry in logs:
            print(entry.__str__())

    # -----------------------------------------
    # 7) Demo usage
    # -----------------------------------------
    info("System booting up...")
    warn("Disk space is running low.")
    error("Failed to read configuration file.")
    debug("Initialization variables loaded.")

    report_all()
