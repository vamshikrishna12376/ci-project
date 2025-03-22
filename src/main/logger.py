"""
Centralized logging module for the application
"""
import os
import json
import logging
import logging.config
import datetime
from functools import wraps
import traceback

# Define log levels
LOG_LEVEL = os.environ.get('LOG_LEVEL', 'INFO').upper()

# Define log format
LOG_FORMAT = '%(asctime)s [%(levelname)s] [%(name)s] [%(module)s:%(lineno)d] [trace_id=%(trace_id)s] - %(message)s'

# Configure logging
logging.config.dictConfig({
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': LOG_FORMAT,
            'datefmt': '%Y-%m-%d %H:%M:%S',
        },
        'json': {
            'class': 'src.main.logger.JsonFormatter',
        },
    },
    'filters': {
        'trace_id_filter': {
            '()': 'src.main.logger.TraceIdFilter',
        },
    },
    'handlers': {
        'console': {
            'level': LOG_LEVEL,
            'class': 'logging.StreamHandler',
            'formatter': 'standard',
            'filters': ['trace_id_filter'],
        },
        'file': {
            'level': LOG_LEVEL,
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': 'logs/application.log',
            'maxBytes': 10485760,  # 10MB
            'backupCount': 10,
            'formatter': 'standard',
            'filters': ['trace_id_filter'],
        },
        'json_file': {
            'level': LOG_LEVEL,
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': 'logs/application.json',
            'maxBytes': 10485760,  # 10MB
            'backupCount': 10,
            'formatter': 'json',
            'filters': ['trace_id_filter'],
        },
    },
    'loggers': {
        '': {
            'handlers': ['console', 'file', 'json_file'],
            'level': LOG_LEVEL,
            'propagate': True,
        },
    }
})

class TraceIdFilter(logging.Filter):
    """
    Filter that adds a trace_id to log records
    """
    def __init__(self, name=''):
        super().__init__(name)
        self.trace_id = None
    
    def filter(self, record):
        if not hasattr(record, 'trace_id'):
            record.trace_id = getattr(self, 'trace_id', 'N/A')
        return True

class JsonFormatter(logging.Formatter):
    """
    Formatter that outputs JSON strings after parsing the log record
    """
    def format(self, record):
        log_data = {
            'timestamp': datetime.datetime.now().isoformat(),
            'level': record.levelname,
            'name': record.name,
            'module': record.module,
            'line': record.lineno,
            'trace_id': getattr(record, 'trace_id', 'N/A'),
            'message': record.getMessage(),
        }
        
        if hasattr(record, 'request_id'):
            log_data['request_id'] = record.request_id
            
        if record.exc_info:
            log_data['exception'] = self.formatException(record.exc_info)
            
        return json.dumps(log_data)

def get_logger(name):
    """
    Get a logger with the specified name
    """
    return logging.getLogger(name)

def log_function_call(logger):
    """
    Decorator to log function calls
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            logger.debug(f"Calling {func.__name__} with args={args}, kwargs={kwargs}")
            try:
                result = func(*args, **kwargs)
                logger.debug(f"{func.__name__} returned {result}")
                return result
            except Exception as e:
                logger.error(f"Exception in {func.__name__}: {str(e)}")
                logger.error(traceback.format_exc())
                raise
        return wrapper
    return decorator