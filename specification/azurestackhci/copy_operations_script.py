import os
import shutil
from pathlib import Path

def get_all_files(directory):
    """Get all files in directory (excluding empty folders)"""
    files = []
    for root, dirs, filenames in os.walk(directory):
        for filename in filenames:
            files.append(os.path.join(root, filename))
    return files

def extract_api_version(file_path, operations_base):
    """Extract API version from file path"""
    # Get relative path from operations directory
    rel_path = os.path.relpath(file_path, operations_base)
    parts = Path(rel_path).parts
    
    # Look for version pattern (e.g., 2024-11-01-preview or 2024-04-01)
    for part in parts:
        # Check if part looks like a version
        if '-' in part and any(char.isdigit() for char in part):
            # Ensure it has preview or is a date-like pattern
            if 'preview' in part or part.count('-') >= 2:
                return part
    return None

def copy_file_if_target_exists(source_file, api_version, operations_base, base_dir):
    """Copy file to StackHCI or StackHCIVM if target path exists. Returns count of copies made."""
    # Get relative path from operations base
    rel_path = os.path.relpath(source_file, operations_base)
    
    # Get the part after the API version folder
    parts = Path(rel_path).parts
    try:
        version_index = parts.index(api_version)
        # Get filename and any subdirectories after version
        remaining_path = Path(*parts[version_index + 1:]) if len(parts) > version_index + 1 else None
    except (ValueError, IndexError):
        remaining_path = Path(parts[-1])  # Just the filename
    
    # Determine if it's a preview version
    stability = 'preview' if 'preview' in api_version else 'stable'
    
    # Try StackHCI path
    stackhci_base = os.path.join(base_dir, 'resource-manager', 'Microsoft.AzureStackHCI', 'StackHCI', stability, api_version)
    # Try StackHCIVM path
    stackhcivm_base = os.path.join(base_dir, 'resource-manager', 'Microsoft.AzureStackHCI', 'StackHCIVM', stability, api_version)
    
    copy_count = 0
    
    for target_base, target_name in [(stackhci_base, 'StackHCI'), (stackhcivm_base, 'StackHCIVM')]:
        if os.path.exists(target_base):
            target_file = os.path.join(target_base, str(remaining_path)) if remaining_path else os.path.join(target_base, os.path.basename(source_file))
            
            # Create target directory if needed
            target_dir = os.path.dirname(target_file)
            if not os.path.exists(target_dir):
                print(f"Target directory does not exist, skipping: {target_dir}")
                continue
            
            try:
                shutil.copy2(source_file, target_file)
                print(f"✓ Copied to {target_name}: {source_file} -> {target_file}")
                copy_count += 1
            except Exception as e:
                print(f"✗ Error copying to {target_name}: {e}")
        else:
            print(f"Target base does not exist: {target_base}")
    
    if copy_count == 0:
        print(f"No valid target found for: {source_file}")
    
    return copy_count

def main():
    # Base directory
    base_dir = r'C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci'
    operations_dir = os.path.join(base_dir, 'resource-manager', 'Microsoft.AzureStackHCI', 'operations')
    
    print(f"Scanning operations directory: {operations_dir}\n")
    
    # Get all files
    all_files = get_all_files(operations_dir)
    print(f"Found {len(all_files)} files\n")
    
    # Track files with no valid target and copy statistics
    no_target_files = []
    files_copied = 0
    files_with_targets = 0
    
    # Process each file
    for file_path in all_files:
        print(f"\nProcessing: {file_path}")
        
        # Extract API version
        api_version = extract_api_version(file_path, operations_dir)
        if not api_version:
            print(f"Could not extract API version from path")
            continue
        
        print(f"API Version: {api_version}")
        
        # Try to copy file
        result = copy_file_if_target_exists(file_path, api_version, operations_dir, base_dir)
        if result:
            files_with_targets += 1
            files_copied += result  # result is the number of copies made
        else:
            no_target_files.append(file_path)
    
    print("\n=== Script completed ===")
    print(f"\nStatistics:")
    print(f"Total files processed: {len(all_files)}")
    print(f"Files with valid targets: {files_with_targets}")
    print(f"Total copies made: {files_copied}")
    print(f"Files with no valid target: {len(no_target_files)}")
    
    # Print files with no valid target
    if no_target_files:
        print("\n")
        for file_path in no_target_files:
            print(file_path)

if __name__ == "__main__":
    main()
