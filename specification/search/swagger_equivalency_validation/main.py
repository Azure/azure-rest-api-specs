#!/usr/bin/env python3
"""
Main entry point for Swagger Equivalency Validation Tool

Simple script to run swagger validation.
"""

import sys
from colorama import init, Fore, Style
from validator import SwaggerValidator

# Initialize colorama
init()


def main():
    """Main entry point for validation."""
    # Check for custom config
    config_file = 'config.yaml'
    if '--config' in sys.argv:
        try:
            config_index = sys.argv.index('--config')
            config_file = sys.argv[config_index + 1]
        except (IndexError, ValueError):
            print(f"{Fore.RED}Error: --config requires a file path{Style.RESET_ALL}")
            sys.exit(1)

    try:
        validator = SwaggerValidator(config_file)
        exit_code = validator.validate()

        if exit_code == 0:
            print(f"{Fore.GREEN}Validation completed successfully!{Style.RESET_ALL}")
        else:
            print(f"{Fore.RED}Validation completed with differences!{Style.RESET_ALL}")

        sys.exit(exit_code)

    except Exception as e:
        print(f"{Fore.RED}Error: {e}{Style.RESET_ALL}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()