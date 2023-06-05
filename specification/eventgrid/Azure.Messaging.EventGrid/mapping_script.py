

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
        if file_names.count(name) == 0:
            file_names.append(name)
            f.write("{\n")
            f.write('"swagger": "2.0",\n')
            f.write('"info": {\n')
            f.write('"version": "2018-01-01",\n')
            f.write(f'"title": "Schema of {name} events published to Azure Event Grid",\n')
            f.write(f'"description": "Describes the schema of the {name} events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent."\n')
            f.write("},\n")
            f.write('"paths": {},\n')
            f.write('"definitions": {\n')
        f.write('"'+event+'"' + " : ")
        json.dump(definition_body,f)
        f.write(",\n")
        

    
for file_name in file_names:
    with open(f'swaggers\\{file_name}.json', 'a') as f:
        f.write("}")