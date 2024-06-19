# Go into the SystemEvents.json file and find the definitions section
# Separate the definitions into individual files based on the starting name of the definition 
# i.e ApiManagement..ApiManagementApiCreatedEventData goes into ApiManagement.json

import json
import pathlib
import os

user_path = os.environ['USER_PATH']

prefix_list = [
    "ApiCenter",
    "ApiManagement",
    "AppConfiguration",
    "AVS",
    "Cache",
    "Communication",
    "ContainerRegistry",
    "ContainerService",
    "DataBox",
    "Devices",
    "EventGrid",
    "EventHub",
    "HealthcareApis",
    "KeyVault",
    "ML",
    "Maps",
    "Media",
    "PolicyInsights",
    "ResourceNotifications",
    "Resources",
    "ServiceBus",
    "SignalRService",
    "Storage",
    "Web",
]

with open(user_path) as user_file:
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

            with open(f'{name}.json', 'a') as f:
                if file_names.count(name) == 0:
                    file_names.append(name)
                    f.write('{\n"swagger": "2.0",\n"info": {\n"version": "2024-01-01",\n')
                    f.write(f'"title": "Schema of {name} events published to Azure Event Grid",\n')
                    f.write(f'"description": "Describes the schema of the {name} events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent."\n')
                    f.write("},\n")
                    f.write('"paths": {},\n"definitions": {\n')
                f.write('"'+event+'"' + " : ")

                # Fix the $ref
                try:
                    if definition_body["allOf"]:
                        definition_body["allOf"][0]["$ref"] = "#/definitions/"+definition_body["allOf"][0]["$ref"].split('.')[1]
                except:
                    pass

                # print(definition_body)

                json.dump(definition_body,f)
                f.write(",")
    except:
        pass


        

    
for file_name in file_names:
    with open(f'{file_name}.json', 'rb+') as f:
        f.seek(0,2)                 # end of file
        size=f.tell()               # the size...
        f.truncate(size-1)
    with open(f'{file_name}.json', 'a') as f:
        f.write("}\n")
        f.write("}")