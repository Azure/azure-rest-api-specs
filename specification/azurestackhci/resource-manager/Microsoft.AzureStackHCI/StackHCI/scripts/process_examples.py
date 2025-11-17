import json
import os
import shutil
from pathlib import Path
from typing import Dict, List, Tuple

# Define paths
BASE_PATH = Path(r"C:\pb\specs\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\StackHCI")
PREVIEW_PATH = BASE_PATH / "preview" / "2025-11-01-preview"
PREVIEW_EXAMPLES_PATH = PREVIEW_PATH / "examples"
TARGET_EXAMPLES_PATH = BASE_PATH / "examples" / "2025-11-01-preview"

def extract_examples_from_json(json_file_path: Path) -> Dict[str, List[Tuple[str, str]]]:
    """
    Extract x-ms-examples from a JSON file.
    Returns a dictionary with operationId as key and list of (fileName, title) as value.
    """
    result = {}
    
    try:
        with open(json_file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Navigate through paths
        paths = data.get('paths', {})
        
        for path_key, path_data in paths.items():
            # Check each HTTP method (get, post, put, delete, patch, etc.)
            for method, method_data in path_data.items():
                if isinstance(method_data, dict) and 'operationId' in method_data:
                    operation_id = method_data['operationId']
                    x_ms_examples = method_data.get('x-ms-examples', {})
                    
                    if x_ms_examples:
                        if operation_id not in result:
                            result[operation_id] = []
                        
                        for title, ref_data in x_ms_examples.items():
                            if isinstance(ref_data, dict) and '$ref' in ref_data:
                                ref_path = ref_data['$ref']
                                # Extract filename from path like "./examples/UploadCertificate.json"
                                file_name = ref_path.split('/')[-1]
                                result[operation_id].append((file_name, title))
    
    except Exception as e:
        print(f"Error processing {json_file_path}: {e}")
    
    return result

def process_all_json_files() -> Dict[str, List[Tuple[str, str]]]:
    """
    Process all JSON files in the preview directory.
    """
    all_examples = {}
    
    # Get all JSON files in the preview directory (excluding hci.json as it's likely a combined file)
    json_files = [f for f in PREVIEW_PATH.glob('*.json') if f.name != 'hci.json' and f.name != 'hciCommon.json']
    
    print(f"Found {len(json_files)} JSON files to process:")
    for json_file in json_files:
        print(f"  - {json_file.name}")
    
    print("\nProcessing files...\n")
    
    for json_file in json_files:
        examples = extract_examples_from_json(json_file)
        
        for operation_id, example_list in examples.items():
            if operation_id not in all_examples:
                all_examples[operation_id] = []
            all_examples[operation_id].extend(example_list)
    
    return all_examples

def add_metadata_to_json(file_path: Path, title: str, operation_id: str):
    """
    Add title and operationId to the JSON file right after the opening brace.
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Create a new ordered dict with title and operationId first
        new_data = {
            "title": title,
            "operationId": operation_id
        }
        
        # Add the rest of the data
        new_data.update(data)
        
        # Write back to file with proper formatting
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(new_data, f, indent=2)
        
        print(f"  ✓ Added metadata to {file_path.name}")
        return True
    
    except Exception as e:
        print(f"  ✗ Error adding metadata to {file_path.name}: {e}")
        return False

def copy_missing_examples(examples_dict: Dict[str, List[Tuple[str, str]]]):
    """
    Copy missing example files from preview/examples to examples directory.
    """
    # Ensure target directory exists
    TARGET_EXAMPLES_PATH.mkdir(parents=True, exist_ok=True)
    
    print(f"\nChecking for missing examples...\n")
    
    copied_count = 0
    skipped_count = 0
    error_count = 0
    
    for operation_id, example_list in examples_dict.items():
        for file_name, title in example_list:
            target_file = TARGET_EXAMPLES_PATH / file_name
            source_file = PREVIEW_EXAMPLES_PATH / file_name
            
            if target_file.exists():
                print(f"⊘ Skipping {file_name} (already exists in target)")
                skipped_count += 1
            elif not source_file.exists():
                print(f"✗ Error: Source file {file_name} not found in {PREVIEW_EXAMPLES_PATH}")
                error_count += 1
            else:
                try:
                    # Copy the file
                    shutil.copy2(source_file, target_file)
                    print(f"✓ Copied {file_name}")
                    
                    # Add metadata
                    add_metadata_to_json(target_file, title, operation_id)
                    copied_count += 1
                    
                except Exception as e:
                    print(f"✗ Error copying {file_name}: {e}")
                    error_count += 1
    
    print(f"\n{'='*60}")
    print(f"Summary:")
    print(f"  Copied and updated: {copied_count} files")
    print(f"  Skipped (already exist): {skipped_count} files")
    print(f"  Errors: {error_count} files")
    print(f"{'='*60}")

def main():
    print("="*60)
    print("Processing x-ms-examples from JSON files")
    print("="*60)
    print()
    
    # Extract all examples
    examples_dict = process_all_json_files()
    
    print(f"\nFound {len(examples_dict)} operations with examples:")
    for operation_id, example_list in sorted(examples_dict.items()):
        print(f"\n{operation_id}:")
        for file_name, title in example_list:
            print(f"  - {file_name} ('{title}')")
    
    # Copy missing examples and add metadata
    copy_missing_examples(examples_dict)

if __name__ == "__main__":
    main()
