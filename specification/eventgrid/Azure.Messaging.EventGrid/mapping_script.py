

# Go into the TypespecEventGrid.json file and find the definitions section
# Separate the defintions into individual files based on the starting name of the defintion 
# i.e ApiManagement..ApiManagementApiCreatedEventData goes into ApiManagement.json

# get to the directory where the TypespecEventGrid.json file is located
import os
PATH = os.environ['PATH']

import json
with open("..\\data-plane\\Microsoft.EventGrid\\stable\\2018-01-01\\TypespecEventGrid.json") as user_file:
    fileContent = json.load(user_file)

file_names = []
for definition_name, definition_body in fileContent["definitions"].items():
    try:
        if "Azure.Core" in definition_name:
            name = 'Azure.Core'
            event = definition_name.split('.')[2]
            old_name = name
        else:
            name = definition_name.split('.')[0]
            event = definition_name.split('.')[1]
            old_name = name
    except:
        name = old_name
    with open(f'swaggers\\{name}.json', 'a') as f:
        body = {event: definition_body}
        json.dump(body, f)
        f.write(",\n")