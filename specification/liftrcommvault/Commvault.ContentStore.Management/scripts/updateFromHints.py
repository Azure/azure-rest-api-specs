import json
from json.decoder import JSONDecodeError
import os
import traceback
import sys
import logging

# expects path to example files folder and path to hints file


# check if the command line arguments are correct
if len(sys.argv) != 3:
    print("Usage: python updateFromHints.py <exampleFilesFolder> <hintsFile>")
    sys.exit(1)

# get the paths to the example files folder and hints file
exampleFilesFolder = sys.argv[1]
hintsFile = sys.argv[2]

# check if the example files folder exists
if not os.path.exists(exampleFilesFolder):
    print(f"Example files folder {exampleFilesFolder} does not exist")
    sys.exit(1)

# check if the hints file exists, if missing create an empty hints file
if not os.path.exists(hintsFile):
    print(f"Hints file {hintsFile} does not exist")
    with open(hintsFile, "w") as file:
        file.write("{}")
        print(f"Created empty hints file {hintsFile}")

# read the hints file and load the json
with open(hintsFile, "r") as file:
    try:
        hints = json.load(file)
    except JSONDecodeError as e:
        print(f"Error reading hints file {hintsFile}: {e}")
        sys.exit(1)


# function to get the value of a key from the hints file
def getValue(key):
    # if the key exists in the hints file, return the value
    if key in hints:
        return hints[key]
    # split the key by "." and check if any of the subkeys exist in the hints file
    path = key
    splits = path.split('.')
    for i in range(len(splits)):
        nPath = ".".join(splits[:i+1])
        # print("forward", nPath)
        if nPath in hints:
            return hints[nPath]
    # check if any of the subkeys in reverse order exist in the hints file
    for i in range(len(splits)-1):
        nPath = "." + ".".join(splits[len(splits)-1-i:])
        # print("backward", nPath)
        if nPath in hints:
            return hints[nPath]
    return None

newHints = {}

# walks the json object and updates the values from the hints file
def walker(obj, key=''):
    logging.debug(f'{key} {obj}')
    value = getValue(key)
    if value:
        return value
    if isinstance(obj, dict):
        for k, v in obj.items():
            obj[k] = walker(v, key + '.' + k)
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            obj[i] = walker(v, key + '.' + str(i))
    else:
        # Add the key to the newHints file
        newHints[key] = obj
    return obj

# for each file in the example files folder load the json and update the values
for file in os.listdir(exampleFilesFolder):
    if file.endswith(".json"):
        with open(os.path.join(exampleFilesFolder, file), "r") as f:
            try:
                data = json.load(f)
                # get file name without extension
                filename = os.path.splitext(file)[0]
                data=walker(data, filename)
                with open(os.path.join(exampleFilesFolder, file), "w") as f:
                    json.dump(data, f, indent=2)
            except JSONDecodeError as e:
                print(f"Error reading file {file}: {e}")
            except Exception as e:
                print(f"Error updating file {file}: {e}")
                traceback.print_exc()

# write the new hints to the hints file
hints["NewHints"] = newHints
with open(hintsFile, "w") as file:
    json.dump(hints, file, indent=2)