import json
from pprint import pprint
import re

filter_code = "MissingTypeObject"

def extract_service_and_provider(url):
    pattern = r"specification/(.*?)/(data-plane|resource-manager)/(.*?)/"
    match = re.search(pattern, url)
    if match:
        return match.group(1), match.group(3)
    else:
        return None, None

with open('pyscript/log.txt', 'r') as f:
    lines = f.readlines()

for i in range(len(lines)):
    lines[i] = lines[i][29:]

for line in lines:
    try:
        data = json.loads(line)
        if type(data) is str:
            continue

        # check that the object has all the required keys
        requiredKeys = ['pluginName', 'extensionName', 'level', 'message', 'code', 'details', 'source']
        if all(key in data for key in requiredKeys):
            level = data['level']
            code = data['code']
            if code != filter_code:
                continue
            source_file = data['source'][0]['document']
            path = data['details']['jsonpath']
            pt1, pt2 = extract_service_and_provider(source_file)
            service = f"{pt1}/{pt2}"
            print(f"Service: {service}, Code: {code}, Path: {path}")
    except Exception as e:
        pass
