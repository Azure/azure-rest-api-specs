#!/usr/bin/env python3
"""
Parser for resource-manager/Microsoft.AzureStackHCI/StackHCIVM/readme.md
Extracts all file paths from the YAML configuration blocks and checks which ones don't exist.
"""

import re
import os
from pathlib import Path
from typing import List, Set, Tuple

def parse_readme_file_paths(readme_path: str) -> List[str]:
    """
    Parse the readme.md file and extract all file paths from input-file sections.
    
    Args:
        readme_path: Path to the readme.md file
        
    Returns:
        List of file paths found in the readme.md file
    """
    with open(readme_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all YAML code blocks (handles both ```yaml and ``` yaml formats)
    yaml_blocks = re.findall(r'```\s*ya?ml.*?\n(.*?)```', content, re.DOTALL)
    
    file_paths: Set[str] = set()
    
    for block in yaml_blocks:
        # Find all lines that start with '  - ' after 'input-file:' 
        # These are the file paths in the YAML list
        lines = block.split('\n')
        in_input_file_section = False
        
        for line in lines:
            # Check if we're entering an input-file section
            if 'input-file:' in line:
                in_input_file_section = True
                continue
            
            # If we're in the input-file section and find a list item
            if in_input_file_section:
                # Check if line starts with list indicator (  - )
                match = re.match(r'\s*-\s+(.+)', line)
                if match:
                    file_path = match.group(1).strip()
                    file_paths.add(file_path)
                elif line.strip() and not line.startswith(' '):
                    # Exit the input-file section if we hit a non-indented line
                    in_input_file_section = False
    
    # Filter to keep only actual file paths (must end with .json)
    file_paths = {fp for fp in file_paths if fp.endswith('.json')}
    
    return sorted(file_paths)

def check_file_existence(file_paths: List[str], readme_dir: str) -> Tuple[List[str], List[str]]:
    """
    Check which file paths exist and which don't.
    
    Args:
        file_paths: List of file paths to check (relative to readme.md location)
        readme_dir: Directory where readme.md is located
        
    Returns:
        Tuple of (existing_files, missing_files)
    """
    existing_files = []
    missing_files = []
    
    for file_path in file_paths:
        # Form the full path relative to the readme.md directory
        full_path = os.path.join(readme_dir, file_path)
        
        if os.path.exists(full_path):
            existing_files.append(file_path)
        else:
            missing_files.append(file_path)
    
    return existing_files, missing_files

def main():
    """Main function to parse and display file paths."""
    readme_path = 'resource-manager/Microsoft.AzureStackHCI/StackHCIVM/readme.md'
    
    print(f"Parsing file: {readme_path}")
    print("-" * 80)
    
    # Get the directory where readme.md is located
    readme_dir = os.path.dirname(readme_path)
    print(f"Base directory: {readme_dir}")
    print("-" * 80)
    
    file_paths = parse_readme_file_paths(readme_path)
    
    print(f"\nFound {len(file_paths)} unique file paths:\n")
    
    # Check which files exist (paths are relative to readme.md location)
    existing_files, missing_files = check_file_existence(file_paths, readme_dir)
    
    print(f"Existing files: {len(existing_files)}")
    print(f"Missing files: {len(missing_files)}")
    print("\n" + "=" * 80)
    
    if missing_files:
        print("\nMISSING FILES:")
        print("-" * 80)
        for file_path in sorted(missing_files):
            print(f"  ❌ {file_path}")
    else:
        print("\n✅ All files exist!")
    
    if existing_files:
        print("\n" + "=" * 80)
        print("\nEXISTING FILES:")
        print("-" * 80)
        for file_path in sorted(existing_files):
            print(f"  ✅ {file_path}")
    
    # Print unique filenames
    print("\n" + "=" * 80)
    print("Unique filenames:\n")
    
    unique_filenames = set()
    for file_path in file_paths:
        filename = file_path.split('/')[-1]
        unique_filenames.add(filename)
    
    for filename in sorted(unique_filenames):
        print(f"  {filename}")
    
    print(f"\nTotal unique filenames: {len(unique_filenames)}")
    print(f"Total files referenced: {len(file_paths)}")
    print(f"Files that exist: {len(existing_files)}")
    print(f"Files that are missing: {len(missing_files)}")

if __name__ == '__main__':
    main()
