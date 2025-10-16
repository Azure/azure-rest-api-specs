#!/usr/bin/env python3
"""
Parser for resource-manager/Microsoft.AzureStackHCI/StackHCI/readme.md
Extracts all file paths from the YAML configuration blocks.
"""

import re
from pathlib import Path
from typing import List, Set


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


def main():
    """Main function to parse and display file paths."""
    readme_path = 'resource-manager/Microsoft.AzureStackHCI/StackHCI/readme.md'
    
    print(f"Parsing file: {readme_path}")
    print("-" * 80)
    
    file_paths = parse_readme_file_paths(readme_path)
    
    print(f"\nFound {len(file_paths)} unique file paths:\n")
    
    # Sort by filename (last part of the path)
    sorted_by_name = sorted(file_paths, key=lambda x: x.split('/')[-1].lower())
    
    for file_path in sorted_by_name:
        print(file_path)
    
    # Group by directory (keep logic but don't print)
    from collections import defaultdict
    grouped = defaultdict(list)
    
    for file_path in file_paths:
        # Extract directory from path
        if '/' in file_path:
            directory = '/'.join(file_path.split('/')[:-1])
        else:
            directory = '.'
        grouped[directory].append(file_path)
    
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


if __name__ == '__main__':
    main()