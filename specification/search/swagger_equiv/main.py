#!/usr/bin/env python3
"""
Main entry point for Swagger Equivalency Validation Tool

Simple script to run swagger validation.
"""

import sys
import argparse
from colorama import init, Fore, Style
from validator import SwaggerValidator

# Initialize colorama
init()


def main():
    """Main entry point for validation."""
    parser = argparse.ArgumentParser(description='Swagger Equivalency Validator')
    parser.add_argument('--disable-norm', action='store_true',
                       help='Skip normalization and use existing intermediate files (tsp-search.json, hand-search.json)')
    parser.add_argument('--config', type=str, default='config.yaml',
                       help='Path to configuration file (default: config.yaml)')

    args = parser.parse_args()

    try:
        validator = SwaggerValidator(args.config)
        exit_code = validator.validate(skip_normalization=args.disable_norm)

        if exit_code == 0:
            print(f"{Fore.GREEN}✓ Validation completed successfully!{Style.RESET_ALL}")
        else:
            print(f"{Fore.RED}✗ Validation completed with differences!{Style.RESET_ALL}")

        sys.exit(exit_code)

    except Exception as e:
        print(f"{Fore.RED}Error: {e}{Style.RESET_ALL}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()