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
    "Web"
]

model_names = []
for file_name in file_names:
    name =f"{PATH}/azure-rest-api-specs/specification/eventgrid/Azure.Messaging.EventGrid/SystemEvents/"+file_name+".tsp"
    with open(name, "r") as user_file:
        file_lines = user_file.readlines()
        for line in file_lines:
            if "model " in line and not "@doc" in line:
                name = line.split("model ")[1].split()[0]
                model_names.append("EventGrid." + name)



# For each model_name add @@include to it
include_statement = "@@include("
model_names_with_include = [include_statement + model_name + ")" for model_name in model_names]    

for model in model_names_with_include:
    print(model)