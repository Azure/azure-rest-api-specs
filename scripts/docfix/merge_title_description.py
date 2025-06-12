#!/usr/bin/env python3
"""
Swagger Title-Description Merger Tool

This tool processes Swagger (OpenAPI v2.0) documents to merge 'title' and 'description' fields.
The title is merged into the description with the format: '<oldTitle>. <oldDescription>'.
A period is added to the title if it doesn't already end with one.
"""

import json
import sys
import os
import argparse
import copy
from typing import Dict, Any, Union


def add_period_if_needed(text: str) -> str:
    """Add a period to the end of text if it doesn't already end with one."""
    if not text:
        return text
    
    text = text.strip()
    if not text.endswith('.'):
        text += '.'
    return text


def merge_title_description(obj: Union[Dict[str, Any], list, str, int, float, bool, None]) -> Union[Dict[str, Any], list, str, int, float, bool, None]:
    """
    Recursively traverse the object and merge title and description fields.
    
    Args:
        obj: The object to process (can be dict, list, or primitive type)
        
    Returns:
        The processed object with title fields merged into descriptions
    """
    if isinstance(obj, dict):
        # Create a copy to avoid modifying the original during iteration
        result = {}
        
        # Check if both title and description exist at this level
        title = obj.get('title')
        description = obj.get('description')
        
        # Process all key-value pairs
        for key, value in obj.items():
            if key == 'title':
                # Skip title fields - they will be merged into description
                continue
            elif key == 'description' and title:
                # Merge title into description
                title_with_period = add_period_if_needed(str(title))
                if description:
                    result[key] = f"{title_with_period} {description}"
                else:
                    result[key] = title_with_period
            else:
                # Recursively process the value
                result[key] = merge_title_description(value)
        
        # If there was a title but no description, create a description from the title
        if title and 'description' not in obj:
            result['description'] = add_period_if_needed(str(title))
            
        return result
        
    elif isinstance(obj, list):
        # Recursively process list elements
        return [merge_title_description(item) for item in obj]
    
    else:
        # Primitive types (str, int, float, bool, None) - return as is
        return obj


def process_swagger_file(filename: str) -> None:
    """
    Process a Swagger file to merge title and description fields.
    
    Args:
        filename: Path to the Swagger JSON file
    """
    try:
        # Read the input file
        with open(filename, 'r', encoding='utf-8') as file:
            swagger_doc = json.load(file)
        
        print(f"Processing Swagger document: {filename}")
        
        if swagger_doc['definitions'] is None:
            print("Warning: 'definitions' field is None, skipping processing.")
            return

        processed_doc = copy.deepcopy(swagger_doc)

        # Process the document
        processed_defs = merge_title_description(swagger_doc['definitions'])
        processed_doc['definitions'] = processed_defs

        # Write the processed document back to the file
        with open(filename, 'w', encoding='utf-8') as file:
            json.dump(processed_doc, file, indent=2, ensure_ascii=False)
            file.write('\n')  # Ensure the file ends with a newline
        
        print(f"Successfully processed and updated: {filename}")
        
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON in file '{filename}': {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error processing file '{filename}': {e}", file=sys.stderr)
        sys.exit(1)


def main():
    """Main function to handle command line arguments and process the file."""
    parser = argparse.ArgumentParser(
        description='Merge title fields into description fields in Swagger (OpenAPI v2.0) documents.',
        epilog='The tool merges title and description fields with format: "<title>. <description>". '
               'A period is added to the title if it doesn\'t already end with one. '
               'All title fields are removed after merging.',
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    
    parser.add_argument(
        '--file',
        dest='swagger_file',
        required=True,
        help='Path to the Swagger JSON file to process'
    )
    
    args = parser.parse_args()
    
    if not os.path.exists(args.swagger_file):
        print(f"Error: File '{args.swagger_file}' does not exist.", file=sys.stderr)
        sys.exit(1)
    
    process_swagger_file(args.swagger_file)


if __name__ == "__main__":
    main()
