#!/usr/bin/env python3

import json
import pathlib

# Function to convert snake case to Pascal case
def snake_to_pascal(name):
    # Split the name by underscores, capitalize each word, then join them together
    return ''.join(word.title() for word in name.split('_'))

# Define the base path as the current directory
base_path = pathlib.Path('.')
# Define the versions of the JSON files to process
versions = ['2024-02-15-preview', '2024-05-01-preview']

# Loop over each version
for version in versions:
    # Loop over each JSON file in the current version directory
    for json_file in (base_path / version).glob('*.json'):
        print(f"Processing file: {json_file}")  # Print the file being processed
        try:
            # Open the JSON file and load its contents
            with json_file.open() as f:
                data = json.load(f)

            # Convert the file name (without extension) from snake case to Pascal case
            operation_id = snake_to_pascal(json_file.stem)
            # Add the operation ID to the JSON data
            data['operationId'] = operation_id

            # Open the JSON file again (in write mode this time) and write the updated data
            with json_file.open('w') as f:
                json.dump(data, f, indent=2)
        except Exception as e:
            print(f"Error processing file {json_file}: {e}")  # Print any errors that occurls
