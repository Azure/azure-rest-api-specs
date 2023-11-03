import json
from pprint import pprint
import re

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

results = {}
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
            source_file = data['source'][0]['document']
            pt1, pt2 = extract_service_and_provider(source_file)
            service = f"{pt1}/{pt2}"
            if service == "None/None":
                test = "best"
            item = results.get(service, None) or { code: { "level": level, "count": 0 } }
            if code not in item:
                item[code] = { "level": level, "count": 0 }
            item[code]["count"] += 1
            if item[code]["level"] != level:
                raise ValueError("Level mismatch")
            results[service] = item
    except:
        pass

# pprint errors using double quotes around keys
with open("pyscript/results.json", "w") as f:
    f.write(json.dumps(results, indent=4, sort_keys=True))
