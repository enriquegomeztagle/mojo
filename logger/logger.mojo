from python import Python, PythonObject
import os
import gzip
import shutil
import json
import xml.etree.ElementTree as ET
from cryptography.fernet import Fernet
from datetime import datetime, timedelta

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
    var log_rotation_interval: String
    var log_archive_path: String
    var log_compression: Bool
    var log_throttle_interval: Int
    var last_log_time: PythonObject
    var log_anonymization_fields: PythonObject
    var log_masking_fields: PythonObject

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
        log_encryption_key: String = "",
        log_rotation_interval: String = "daily",
        log_archive_path: String = "",
        log_compression: Bool = False,
        log_throttle_interval: Int = 60,
        log_anonymization_fields: PythonObject = None,
        log_masking_fields: PythonObject = None
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
        self.log_rotation_interval = log_rotation_interval
        self.log_archive_path = log_archive_path
        self.log_compression = log_compression
        self.log_throttle_interval = log_throttle_interval
        self.last_log_time = None
        self.log_anonymization_fields = log_anonymization_fields if log_anonymization_fields is not None else self.py.list()
        self.log_masking_fields = log_masking_fields if log_masking_fields is not None else self.py.list()

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
        var now = self.datetime.datetime.now()
        if self.last_log_time is not None:
            var time_diff = now - self.last_log_time
            if time_diff.total_seconds() < self.log_throttle_interval:
                return
        self.last_log_time = now

        # Rotate log file if needed
        self.rotate_log_file()

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
        var cipher_suite = Fernet(self.log_encryption_key)
        var encrypted_log = cipher_suite.encrypt(log_line.encode())
        return encrypted_log.decode()

    fn decrypt_log(self, encrypted_log: String) -> String:
        # Implement log decryption using the provided key
        var cipher_suite = Fernet(self.log_encryption_key)
        var decrypted_log = cipher_suite.decrypt(encrypted_log.encode())
        return decrypted_log.decode()

    fn rotate_log_file(self) raises:
        """Rotate the log file based on time interval"""
        if self.log_file is not None:
            var now = self.datetime.datetime.now()
            var log_file_name = self.log_file.name
            var log_file_date = self.builtins.os.path.getmtime(log_file_name)
            var log_file_date = self.datetime.datetime.fromtimestamp(log_file_date)

            var interval = None
            if self.log_rotation_interval == "daily":
                interval = timedelta(days=1)
            elif self.log_rotation_interval == "weekly":
                interval = timedelta(weeks=1)
            elif self.log_rotation_interval == "monthly":
                interval = timedelta(days=30)

            if interval is not None and now - log_file_date >= interval:
                self.log_file.close()
                var new_log_file_path = log_file_name + "." + now.strftime("%Y-%m-%d")
                self.builtins.os.rename(log_file_name, new_log_file_path)

                if self.log_compression:
                    self.compress_log_file(new_log_file_path)

                if self.log_archive_path != "":
                    self.archive_log_file(new_log_file_path)

                self.log_file = self.builtins.open(log_file_name, "a")

    fn compress_log_file(self, log_file_path: String) raises:
        """Compress the log file"""
        with gzip.open(log_file_path + ".gz", "wb") as f_out:
            with open(log_file_path, "rb") as f_in:
                shutil.copyfileobj(f_in, f_out)
        self.builtins.os.remove(log_file_path)

    fn archive_log_file(self, log_file_path: String) raises:
        """Archive the log file to a different location"""
        var archive_file_path = self.log_archive_path + "/" + self.builtins.os.path.basename(log_file_path)
        shutil.move(log_file_path, archive_file_path)

    fn search_logs(self, query: String) -> PythonObject:
        """Search for specific log entries"""
        var results = self.py.list()
        for entry in self.logs:
            if query in entry:
                results.append(entry)
        return results

    fn generate_log_statistics(self) -> PythonObject:
        """Generate statistics on log entries"""
        var stats = self.py.dict()
        for level, count in self.log_counts.items():
            stats[level] = count
        return stats

    fn anonymize_log(self, log_line: String) -> String:
        """Anonymize sensitive information in log messages"""
        for field in self.log_anonymization_fields:
            log_line = log_line.replace(field, "ANONYMIZED")
        return log_line

    fn mask_log(self, log_line: String) -> String:
        """Mask sensitive information in log messages"""
        for field in self.log_masking_fields:
            log_line = log_line.replace(field, "MASKED")
        return log_line

    fn format_log_json(self, log_line: String) -> String:
        """Format log message as JSON"""
        var log_dict = self.py.dict()
        log_dict["level"] = log_line.split("]")[0][1:]
        log_dict["timestamp"] = log_line.split("]")[1].split("-")[0].strip()
        log_dict["message"] = log_line.split("-")[1].strip()
        return json.dumps(log_dict)

    fn format_log_xml(self, log_line: String) -> String:
        """Format log message as XML"""
        var log_xml = ET.Element("log")
        ET.SubElement(log_xml, "level").text = log_line.split("]")[0][1:]
        ET.SubElement(log_xml, "timestamp").text = log_line.split("]")[1].split("-")[0].strip()
        ET.SubElement(log_xml, "message").text = log_line.split("-")[1].strip()
        return ET.tostring(log_xml, encoding="unicode")
