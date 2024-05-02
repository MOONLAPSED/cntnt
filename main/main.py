#! /usr/bin/env python3
import os
import argparse
import logging
import sys  # https://docs.python.org/3/library/sys.html#sys.path
from logging_utils import init_logging  # Check and create the log directory
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
log_directory = 'logs'
log_file_path = os.path.join(log_directory, 'app.log')
# Initialize logging using logging_utils module
logger = init_logging(log_directory, log_file_path)
# Check if the 'dammit' module is available
try:
    import dammit
except ModuleNotFoundError:
    logger.error("Error: 'dammit' module not found. You can install it with 'pip install dammit'.")
    exit()
if hasattr(dammit, 'chat') and callable(getattr(dammit, 'chat')):
    logger.info("Found 'chat' function in the 'dammit' module.")
    pass
else:
    logger.error("Error: 'chat' function not found in the 'dammit' module.")
    exit()
# Unix debug section
if not os.name == 'nt':
    logger.info(f"[__file__==] {__file__}")
    logger.info(f"[__name__==] {__name__}")
    logger.info(f"[sys.path==] {sys.path}")
    logger.info(f"cntnt by printzn MIT License init in the current working directory: {os.getcwd()}")
    path = os.getenv("PATH")
    path_directories = path.split(os.pathsep)
    python3_paths = []
    for directory in path_directories:
        python3_executable = os.path.join(directory, 'python3')
        if os.path.isfile(python3_executable):
            python3_paths.append(python3_executable)
            logger.info(f"Found Python 3 executable: {python3_executable}")
    logger.info(f"[select from available python3_paths==] {python3_paths}")
    print("Select a Python 3 executable:")
    for idx, python3_path in enumerate(python3_paths, start=1):
        print(f"{idx}. {python3_path}")
    try:
        choice = int(input("Enter the number of the Python 3 executable: "))
        if 1 <= choice <= len(python3_paths):
            selected_python3 = python3_paths[choice - 1]
            print(f"You selected: {selected_python3}")
        else:
            print("Invalid choice. Please enter a valid number.")
    except ValueError:
        print("Invalid input. Please enter a valid number.")

prompt = []


def main():
    try:
        global prompt
        parser = argparse.ArgumentParser(description='cntnt by printzn MIT License')
        parser.add_argument('prompt', nargs='*', help='Enter the prompt here')
        args = parser.parse_args()
        prompt.extend(args.prompt)
    except Exception as e:
        logging.error(f"An error occurred: {e}")


if __name__ == "__main__":
    main()
    dammit.chat(prompt)
    if hasattr(dammit, 'chat') and callable(getattr(dammit, 'chat')):
        dammit.chat(prompt)
    else:
        print("Error: 'chat' function not found in the 'dammit' module.")
        exit()


else:
    sys.stdout.write(f"\033[1;33m[__file__==]\033[0m {__file__}\n")
    logger.info(f"[__file__==] {__file__}")
    sys.stdout.write(f"\033[1;33m[__name__==]\033[0m {__name__}\n")
    logger.info(f"[__name__==] {__name__}")
    sys.stdout.write(f"\033[1;33m[sys.path==]\033[0m {sys.path}\n")
    logger.info(f"[sys.path==] {sys.path}")
    sys.stdout.write(f"cntnt by printzn MIT License FAILED init in current working directory: {os.getcwd()}")
    logger.info(f"cntnt by printzn MIT License FAILED init in the current working directory: {os.getcwd()}")
    exit()
