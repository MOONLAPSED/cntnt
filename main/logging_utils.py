import logging
import os

def init_logging(log_directory, log_file_path):
    """
    Initialize the logging system.

    Args:
    - log_directory: The path to the log directory.
    - log_file_path: The path to the log file.

    Returns:
    - logger: The configured logger object.
    """
    
    # Create the log directory if it doesn't exist
    if not os.path.exists(log_directory):
        os.makedirs(log_directory)

    # Create a logger
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    # Create a file handler and set its level to DEBUG
    file_handler = logging.FileHandler(log_file_path)
    file_handler.setLevel(logging.DEBUG)

    # Create a console handler and set its level to INFO
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)

    # Create a formatter with your desired format
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(module)s - %(message)s')

    # Set the formatter for both handlers
    file_handler.setFormatter(formatter)
    console_handler.setFormatter(formatter)

    # Add the handlers to the logger
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    # Log a message to indicate successful initialization
    logger.info('Logging system initialized successfully')

    return logger

"""
import logging, os, sys, argparse
from logging_utils import init_logging  # Check and create the log directory
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
log_directory = 'logs'
log_file_path = os.path.join(log_directory, 'app.log')
logger = init_logging(log_directory, log_file_path)  # Initialize logging using logging_utils module
logger = logging.getLogger()  # Configure the logger
logger.setLevel(logging.DEBUG)
file_handler = logging.FileHandler('app.log')  # Create a file handler
file_handler.setLevel(logging.DEBUG)
console_handler = logging.StreamHandler()  # Create a console (stdout) handler
console_handler.setLevel(logging.INFO)  # You can set the desired logging level for stdout
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(module)s - %(message)s')  # Create a formatter
file_handler.setFormatter(formatter)  # Set the formatter for the handlers
console_handler.setFormatter(formatter)  # Add the handlers to the logger
logger.addHandler(file_handler)
logger.addHandler(console_handler)  # Now, logger.info() and other log functions will log to both the file and stdout
"""