#!/usr/bin/env python3
"""
Script to collect all example reference file paths from StackHCI JSON files
and append the source path to each reference
"""

import json
import os
from pathlib import Path
from typing import List, Dict
import csv
from datetime import datetime

# Define paths to scan
PREVIEW_PATH = "resource-manager/Microsoft.AzureStackHCI/StackHCI/preview"
STABLE_PATH = "resource-manager/Microsoft.AzureStackHCI/StackHCI/stable"

PREVIEW_PATH = "resource-manager/Microsoft.AzureStackHCI/StackHCIVM/preview"
STABLE_PATH = "resource-manager/Microsoft.AzureStackHCI/StackHCIVM/stable"


# Store all collected results
results: List[Dict] = []


def process_json_files(root_path: str, path_type: str) -> None:
    """Process all JSON files in the given directory recursively."""
    root = Path(root_path)
    
    if not root.exists():
        print(f"❌ Path does not exist: {root_path}")
        return
    
    # Get all JSON files recursively
    json_files = list(root.rglob("*.json"))
    
    for json_file in json_files:
        print(f"Processing: {json_file}")
        
        try:
            # Read and parse JSON
            with open(json_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            source_dir = json_file.parent
            source_file = str(json_file)
            
            # Extract x-ms-examples from paths section
            if 'paths' in data and isinstance(data['paths'], dict):
                for path_key, path_obj in data['paths'].items():
                    if not isinstance(path_obj, dict):
                        continue
                    
                    # Check each HTTP method in the path
                    for method, method_obj in path_obj.items():
                        if not isinstance(method_obj, dict):
                            continue
                        
                        # Check if x-ms-examples exists
                        if 'x-ms-examples' in method_obj:
                            examples = method_obj['x-ms-examples']
                            if not isinstance(examples, dict):
                                continue
                            
                            for example_name, example in examples.items():
                                if not isinstance(example, dict):
                                    continue
                                
                                # Check if $ref exists
                                if '$ref' in example:
                                    ref_path = example['$ref']
                                    
                                    # Resolve the reference path relative to source file
                                    full_ref_path = (source_dir / ref_path).resolve()
                                    
                                    # Create result object
                                    result = {
                                        'SourceFile': source_file,
                                        'ExampleName': example_name,
                                        'ReferencePath': ref_path,
                                        'FullPath': str(full_ref_path),
                                        'PathType': path_type,
                                        'HttpMethod': method.upper(),
                                        'ApiPath': path_key
                                    }
                                    
                                    results.append(result)
                                    print(f"  ✓ Found: {example_name} -> {ref_path}")
        
        except json.JSONDecodeError as e:
            print(f"  ❌ JSON decode error: {e}")
        except Exception as e:
            print(f"  ❌ Error processing file: {e}")


def main():
    """Main function to process directories and generate reports."""
    print("\n" + "=" * 80)
    print("Azure Stack HCI Example Reference Path Collector")
    print("=" * 80 + "\n")
    
    print("Scanning PREVIEW directory...")
    print(f"Path: {PREVIEW_PATH}\n")
    process_json_files(PREVIEW_PATH, "Preview")
    
    print("\nScanning STABLE directory...")
    print(f"Path: {STABLE_PATH}\n")
    process_json_files(STABLE_PATH, "Stable")
    
    # Display summary
    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total example references found: {len(results)}")
    preview_count = len([r for r in results if r['PathType'] == 'Preview'])
    stable_count = len([r for r in results if r['PathType'] == 'Stable'])
    print(f"Preview references: {preview_count}")
    print(f"Stable references: {stable_count}")
    
    if not results:
        print("\n⚠️  No example references found!")
        return
    
    # Export to CSV
    csv_path = "example-paths-report-vm.csv"
    with open(csv_path, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['SourceFile', 'ExampleName', 'ReferencePath', 'FullPath', 
                     'PathType', 'HttpMethod', 'ApiPath']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(results)
    print(f"\n✓ Detailed report exported to: {csv_path}")
    
    # Export to text file with formatted output
    txt_path = "example-paths-report-vm.txt"
    with open(txt_path, 'w', encoding='utf-8') as f:
        f.write("Azure Stack HCI Example Reference Paths Report\n")
        f.write("=" * 80 + "\n")
        f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"Total References: {len(results)}\n")
        f.write("\n" + "=" * 80 + "\n\n")
        
        # Sort by PathType and SourceFile
        sorted_results = sorted(results, key=lambda x: (x['PathType'], x['SourceFile']))
        
        for result in sorted_results:
            f.write(f"Source File: {result['SourceFile']}\n")
            f.write(f"Example Name: {result['ExampleName']}\n")
            f.write(f"Reference Path: {result['ReferencePath']}\n")
            f.write(f"Full Resolved Path: {result['FullPath']}\n")
            f.write(f"Type: {result['PathType']}\n")
            f.write(f"HTTP Method: {result['HttpMethod']}\n")
            f.write(f"API Path: {result['ApiPath']}\n")
            f.write("-" * 80 + "\n\n")
    
    print(f"✓ Formatted report exported to: {txt_path}")
    
    # Export just the full paths to a simple list
    paths_only_file = "example-paths-list.txt"
    unique_paths = sorted(set(r['FullPath'] for r in results))
    with open(paths_only_file, 'w', encoding='utf-8') as f:
        for path in unique_paths:
            f.write(f"{path}\n")
    print(f"✓ Simple path list exported to: {paths_only_file}")
    
    # Export just the reference paths in sorted order
    ref_paths_file = "example-reference-paths-sorted-vm.txt"
    unique_ref_paths = sorted(set(r['ReferencePath'] for r in results))
    with open(ref_paths_file, 'w', encoding='utf-8') as f:
        for ref_path in unique_ref_paths:
            f.write(f"{ref_path}\n")
    print(f"✓ Reference paths list exported to: {ref_paths_file}")
    
    print("\n✅ Script completed successfully!\n")


if __name__ == "__main__":
    main()
