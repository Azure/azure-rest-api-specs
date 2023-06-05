# Go into the TypespecEventGrid.json file and find the definitions section
# Separate the defintions into individual files based on the starting name of the defintion 
# i.e ApiManagement..ApiManagementApiCreatedEventData goes into ApiManagement.json

# get to the directory where the TypespecEventGrid.json file is located
import json
import pathlib

# Clear out the swaggers folder
path_to_clear = pathlib.Path("./swaggers")
for file_to_rem in path_to_clear.glob("*.json"):
    file_to_rem.unlink()    

with open("../data-plane/Microsoft.EventGrid/stable/2018-01-01/TypespecEventGrid.json") as user_file:
    fileContent = json.load(user_file)

file_names = []
for definition_name, definition_body in fileContent["definitions"].items():
    try:
        if "Azure.Core" in definition_name:
            pass
        else:
            name = definition_name.split('.')[0]
            event = definition_name.split('.')[1]
            old_name = name

            with open(f'swaggers\\{name}.json', 'a') as f:
                if file_names.count(name) == 0:
                    file_names.append(name)
                    f.write('{\n"swagger": "2.0",\n"info": {\n"version": "2018-01-01",\n')
                    f.write(f'"title": "Schema of {name} events published to Azure Event Grid",\n')
                    f.write(f'"description": "Describes the schema of the {name} events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent."\n')
                    f.write("},\n")
                    f.write('"paths": {},\n"definitions": {\n')
                f.write('"'+event+'"' + " : ")
                json.dump(definition_body,f)
                f.write(",\n")
    except:
        pass


        

    
for file_name in file_names:
    with open(f'swaggers\\{file_name}.json', 'a') as f:
        f.write("}")