import json
from pprint import pprint

with open('pyscript/log.txt', 'r') as f:
    lines = f.readlines()

for i in range(len(lines)):
    lines[i] = lines[i][29:]

errors = {}
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
            if code not in errors:
                errors[code] = {"level": level, "count": 1}
            else:
                errors[code]["count"] += 1
                if errors[code]["level"] != level:
                    raise ValueError("Level mismatch")
    except:
        pass

# pprint errors using double quotes around keys
print(json.dumps(errors, indent=4, sort_keys=True))
