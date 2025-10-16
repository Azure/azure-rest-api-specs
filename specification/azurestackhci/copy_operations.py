import os
import shutil
from pathlib import Path

def process_and_move_files(input_file):
    """
    Read file paths from input_file, remove '../operations' from paths,
    and move files to the new location.
    """
    # Read the input file
    with open(input_file, 'r') as f:
        file_paths = [line.strip() for line in f if line.strip()]
    
    copied_count = 0
    skipped_count = 0
    error_count = 0
    skipped_files = []
    
    print(f"Processing {len(file_paths)} files...\n")
    
    for source_path in file_paths:
        try:
            # Remove '../operations' from the path
            target_path = source_path.replace('/../operations', '')
            
            # Convert to Path objects for better handling
            source = Path(source_path)
            target = Path(target_path)
            
            # Check if source file exists
            if not source.exists():
                print(f"⚠️  Source file not found: {source}")
                skipped_files.append(str(source))
                skipped_count += 1
                continue
            
            # Create target directory if it doesn't exist
            target.parent.mkdir(parents=True, exist_ok=True)
            
            # Move the file
            shutil.move(str(source), str(target))
            print(f"✓ Moved: {source.name}")
            print(f"  From: {source}")
            print(f"  To:   {target}\n")
            copied_count += 1
            
        except Exception as e:
            print(f"✗ Error processing {source_path}")
            print(f"  Error: {str(e)}\n")
            error_count += 1
    
    # Print summary
    print("=" * 70)
    print("SUMMARY:")
    print(f"  Files moved successfully: {copied_count}")
    print(f"  Files skipped (not found): {skipped_count}")
    print(f"  Errors encountered: {error_count}")
    print(f"  Total files processed: {len(file_paths)}")
    print("=" * 70)
    
    # Print skipped files list if any
    if skipped_files:
        print("\nSKIPPED FILES:")
        for file in skipped_files:
            print(f"{file}")

if __name__ == "__main__":
    input_file = "operationsToCopy.md"
    
    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found!")
        exit(1)
    
    print(f"Reading file paths from: {input_file}\n")
    process_and_move_files(input_file)
