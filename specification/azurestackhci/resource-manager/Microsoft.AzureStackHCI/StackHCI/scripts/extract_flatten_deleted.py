#!/usr/bin/env python3
"""
Script to extract all definition names where x-ms-client-flatten__deleted appears.
This helps identify which definitions had the x-ms-client-flatten property removed.
"""

import json
import sys
from pathlib import Path


def find_flatten_deleted(obj, path="", results=None):
    """
    Recursively search for x-ms-client-flatten__deleted in the JSON structure.
    
    Args:
        obj: Current object/dict being examined
        path: Current path in the JSON structure
        results: List to store found definition names
    
    Returns:
        List of definition names with x-ms-client-flatten__deleted
    """
    if results is None:
        results = []
    
    if isinstance(obj, dict):
        # Check if this level has x-ms-client-flatten__deleted
        if "x-ms-client-flatten__deleted" in obj:
            # Extract definition name from path
            # Path format: definitions.DefinitionName.properties...
            parts = path.split('.')
            if len(parts) >= 2 and parts[0] == "definitions":
                definition_name = parts[1]
                if definition_name not in results:
                    results.append(definition_name)
        
        # Recurse into nested objects
        for key, value in obj.items():
            new_path = f"{path}.{key}" if path else key
            find_flatten_deleted(value, new_path, results)
    
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            new_path = f"{path}[{i}]"
            find_flatten_deleted(item, new_path, results)
    
    return results


def main():
    # Determine the diff.json file path
    script_dir = Path(__file__).parent
    diff_file = script_dir.parent / "diffOutput" / "diff.json"
    
    if not diff_file.exists():
        print(f"Error: diff.json not found at {diff_file}", file=sys.stderr)
        sys.exit(1)
    
    # Load the diff.json file
    try:
        with open(diff_file, 'r', encoding='utf-8') as f:
            diff_data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"Error: Failed to parse JSON: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: Failed to read file: {e}", file=sys.stderr)
        sys.exit(1)
    
    # Find all definitions with x-ms-client-flatten__deleted
    results = find_flatten_deleted(diff_data.get("definitions", {}), "definitions")
    
    # Sort results alphabetically
    results.sort()
    
    # Output results
    print("Definitions with x-ms-client-flatten__deleted:")
    print("=" * 60)
    
    if results:
        for i, definition_name in enumerate(results, 1):
            print(f"{i:2d}. {definition_name}")
        print("=" * 60)
        print(f"Total: {len(results)} definition(s) found")
    else:
        print("No definitions found with x-ms-client-flatten__deleted")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
