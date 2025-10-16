import os
import shutil

# Read the file containing paths
with open('stackHCIOperations-path.md', 'r') as f:
    paths = f.read().strip().split('\n')

# Check each path and collect missing files and alternatives used
missing_files = []
alternative_used = []

for path in paths:
    # Normalize the path for the current OS
    normalized_path = path.replace('C:/pvt/azure-rest-api-specs-pr/specification/azurestackhci/', '')
    normalized_path = normalized_path.replace('/', os.sep)
    
    if not os.path.exists(normalized_path):
        # If file not found, try replacing StackHCI with StackHCIVM
        alternative_path = normalized_path.replace(
            os.path.join('resource-manager', 'Microsoft.AzureStackHCI', 'StackHCI'),
            os.path.join('resource-manager', 'Microsoft.AzureStackHCI', 'StackHCIVM')
        )
        
        if os.path.exists(alternative_path):
            os.makedirs(os.path.dirname(normalized_path), exist_ok=True)
            shutil.copy2(alternative_path, normalized_path)
            alternative_used.append(alternative_path)
        else:
            missing_files.append(normalized_path)

print("----MISSED FILES----")

# Print missing files
for missing_file in missing_files:
    print(missing_file)

print("----ALTERNATIVE USED----")

# Print alternative paths used
for alt_file in alternative_used:
    print(alt_file)
