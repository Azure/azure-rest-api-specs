import json
import os
import re
from sys import argv

import yaml


examples_dir = argv[1]
examples_file = "gthomas/examples.yaml"


def json_cleanse(x, removal):
    if isinstance(x, dict):
        return {k: json_cleanse(v, removal) for k, v in x.items() if k not in removal}
    elif isinstance(x, list):
        return [json_cleanse(v, removal) for v in x]
    else:
        return x


def json_assign(x, replacements: dict):
    if isinstance(x, dict):
        new_dict = {k: json_assign(v, replacements) for k, v in x.items()}
        for k, v in replacements.items():
            if k in new_dict:
                new_dict[k] = v
        return new_dict
    elif isinstance(x, list):
        return [json_assign(v, replacements) for v in x]
    else:
        return x


# Load Yaml
with open(examples_file, "r") as stream:
    examples = yaml.safe_load(stream)

removal = examples["remove"]
specifics = examples["specifics"]
examples = examples["examples"]
# print(examples)

# list files in examples_dir
files = os.listdir(examples_dir)

print("Files in examples_dir:")
print(str.join("\n", files))
# iterate over files
for file in files:
    if "MinimumSet" in file:
        os.remove(os.path.join(examples_dir, file))
        continue
    elif "MaximumSet" in file:
        new_filename = file.replace("_MaximumSet_Gen", "")
        os.rename(
            os.path.join(examples_dir, file),
            os.path.join(examples_dir, new_filename),
        )
        file = new_filename
    else:
        pass

    # if file in ["RealtimeDeid.json", "DeleteJob.json", "GetJob.json", "ListJobs.json"]:
    #     continue

    # load file
    with open(os.path.join(examples_dir, file), "r") as stream:
        file_content = stream.read()

    try:
        file_content_json = json.loads(file_content)
    except Exception as e:
        print("\nERROR IN JSON PARSE")
        print(e)
        print(file_content)
        exit(1)

    file_content_json = json_assign(file_content_json, examples)
    # file_content = re.sub(f'"{k}": "[^,\\n]+"', f'"{k}": "{v}"', file_content)
    # file_content = re.sub(f'"{k}": [^,"\\n]+', f'"{k}": {v}', file_content)

    if file.split(".")[0] in removal.keys():
        file_removal = removal[file.split(".")[0]]
        file_content_json = json_cleanse(file_content_json, file_removal)

    if file.split(".")[0] in specifics.keys():
        file_specifics = specifics[file.split(".")[0]]
        file_content_json = json_assign(file_content_json, file_specifics)

    #
    # replace file content with example
    with open(os.path.join(examples_dir, file), "w") as stream:
        stream.write(json.dumps(file_content_json, indent=2))
