# Go into each tsp file and grab the model names

import json
import pathlib
import os

PATH = os.environ["PATH_TO_AZURE_SPEC_REPO"]

file_names = [
    "ApiManagement",
    "AppConfiguration",
    "AzureCommunicationServices",
    "ContainerRegistry",
    "ContainerService",
    "DataBox",
    "EventGrid",
    "EventHub",
    "HealthcareApis",
    "IotHub",
    "KeyVault",
    "MachineLearningServices",
    "Maps",
    "MediaServices",
    "PolicyInsights",
    "RedisCache",
    "Resources",
    "ServiceBus",
    "SignalRService",
    "Storage",
    "Web",
    "ResourceNotifications",
]

model_names = []
enum_names = []
for file_name in file_names:
    name =f"{PATH}/azure-rest-api-specs/specification/eventgrid/Azure.Messaging.EventGrid/"+file_name+".tsp"
    with open(name, "r") as user_file:
        file_lines = user_file.readlines()
        for line in file_lines:
            if "model " in line and not "@doc" in line:
                name = line.split("model ")[1].split()[0]
                model_names.append("Microsoft.EventGrid." + name)
            if "enum" in line and not "@doc" in line:
                name = line.split("enum ")[1].split()[0]
                enum_names.append("Microsoft.EventGrid." + name)



# For each model_name add @@include to it
include_statement = "@@usage("
model_names_with_include = [include_statement + model_name + ", Usage.input | Usage.output);" for model_name in model_names]    

access_statement = "@@access("
model_names_with_access = [access_statement + model_name + ", Access.public);" for model_name in model_names]   

# For each enum_name add @@include to it
include_statement = "@@usage("
enum_names_with_include = [include_statement + enum_name + ", Usage.input | Usage.output);" for enum_name in enum_names]    

access_statement = "@@access("
enum_names_with_access = [access_statement + enum_name + ", Access.public);" for enum_name in enum_names]  

print("// Models")
for i in range(len(model_names_with_access)):
    print(model_names_with_include[i])
    print(model_names_with_access[i])
print("// Enums")

for i in range(len(enum_names_with_access)):
    print(enum_names_with_include[i])
    print(enum_names_with_access[i])
