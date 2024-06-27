#!/usr/bin/env python3

import pathlib


# Run script from `specifications/ai` folder
def compare_folders(folder1, folder2):
    # Convert to Path objects for easier manipulation
    folder1_path = pathlib.Path(folder1)
    folder2_path = pathlib.Path(folder2)

    # Get sets of .json file names in each folder
    files_in_folder1 = {file.name for file in folder1_path.glob("*.json")}
    files_in_folder2 = {file.name for file in folder2_path.glob("*.json")}

    # Find differences
    missing_in_folder1 = files_in_folder2 - files_in_folder1
    missing_in_folder2 = files_in_folder1 - files_in_folder2

    # Print results
    print(f"Files in '{folder2}' missing in '{folder1}':")
    for file in sorted(missing_in_folder1):
        print(f"- {file}")

    print(f"\nFiles in '{folder1}' missing in '{folder2}':")
    for file in sorted(missing_in_folder2):
        print(f"- {file}")


# Define folder pairs to compare
folder_pairs = [
    (
        "OpenAI.Assistants/examples/2024-02-15-preview",
        "data-plane/OpenAI.Assistants/OpenApiV2/preview/2024-02-15-preview/examples",
    ),
    (
        "OpenAI.Assistants/examples/2024-05-01-preview",
        "data-plane/OpenAI.Assistants/OpenApiV2/preview/2024-05-01-preview/examples",
    ),
]

# Compare each pair of folders
for folder1, folder2 in folder_pairs:
    print(f"Comparing '{folder1}' and '{folder2}':")
    compare_folders(folder1, folder2)
    print("\n" + "-" * 50 + "\n")
