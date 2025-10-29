#!/bin/bash

############################################################################################################
#                                                                                                          #
# Run this script in the /specifications/iotoperations directory to generate the specs and the examples.   #
#                                                                                                          #
############################################################################################################
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
pushd "$script_dir/../.." || {
    echo "Could not change to the script directory. Exiting..."
    exit 1
}

# echo "Deleting the examples in the resource-manager directory and the management directory..."
# rm -r resource-manager/Microsoft.IoTOperations/preview/2024-08-15-preview/examples

echo "Generating the specs and the examples!"

# Compile all the typespecs the iotoperations directory
echo "Compiling the typespecs in the iotoperations directory..."

# Generate examples for all the openapi specs
# echo "Generating examples for all the openapi specs..."
# oav generate-examples resource-manager/Microsoft.IoTOperations/preview/2024-08-15-preview/iotoperations.json --max -p

# Search each example file and replace the default string with resource-name123

#####################################################################
#
# Don't make any changes to examples for now through this script.
#
#####################################################################
# for file in resource-manager/Microsoft.IoTOperations/preview/2024-08-15-preview/examples/*.json; do
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp ^[a-z0-9][a-z0-9-]*[a-z0-9]$" then "resource-name123" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp ^[0-9]+[KMGTPE]$" then "500M" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp ^https://.*$" then "https://www.example.com" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp .+\\..+\\.kusto\\.windows\\.net" then "<cluster>.<region>.kusto.windows.net" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp .+\\.blob\\.core\\.windows\\.net" then "<account>.blob.core.windows.net" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "string" and . == "Replace this value with a string matching RegExp .+\\.fabric\\.microsoft\\.com" then "https://<host>.fabric.microsoft.com" else . end)' $file > temp.json && mv temp.json $file
# done

# for file in resource-manager/Microsoft.IoTOperations/preview/2024-08-15-preview/examples/*.json; do

#     # The following Jq commands replace ids with properly formatted ARM Ids
#     operationId=$(jq -r '.operationId' $file)
#     if [[ $operationId == Instance* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("Instance") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == BrokerAuthentication* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("BrokerAuthentication") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/brokers/resource-name123/authentications/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == BrokerAuthorization* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("BrokerAuthorization") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/brokers/resource-name123/authorizations/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == BrokerListener* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("BrokerListener") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/brokers/resource-name123/listeners/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == Broker* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("Broker") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/brokers/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == DataflowProfile* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("DataflowProfile") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/dataflowProfiles/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == DataflowEndpoint* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("DataflowEndpoint") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/dataflowEndpoints/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     elif [[ $operationId == Dataflow* ]]; then
#         jq --arg operationId "$operationId" 'walk(if type == "object" and .id? then if $operationId | startswith("Dataflow") then .id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup123/providers/Microsoft.IoTOperations/instances/resource-name123/dataflowProfiles/resource-name123/dataflows/resource-name123" else . end else . end)' $file > temp.json && mv temp.json $file
#     fi

#     # The following Jq command chops down numbers that are greater than 10000 to 10000, the OAV generate examples tool will not respect the min/max value required by typespec
#     jq 'walk(if type == "number" then . % 10000 else . end)' $file > temp.json && mv temp.json $file

#     # Set spanChannelCapacity to correct value for minimum.
#     jq 'walk(if type == "object" and .spanChannelCapacity? then .spanChannelCapacity = 1000 else . end)' $file > temp.json && mv temp.json $file

#     # Replace description strings with some Lorem Ipsum text.
#     jq 'walk(if type == "object" and .description? then .description = "Lorem ipsum odor amet, consectetuer adipiscing elit." else . end)' $file > temp.json && mv temp.json $file

#     # Replace identity strings with GUIDs.
#     jq 'walk(if type == "object" and .principalId? then .principalId = "4a6e4195-75b8-4685-aa0c-0b5704779327" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "object" and .tenantId? then .tenantId = "ed060aa2-71ff-4d3f-99c4-a9138356fdec" else . end)' $file > temp.json && mv temp.json $file
#     jq 'walk(if type == "object" and .clientId? then .clientId = "fb90f267-8872-431a-a76a-a1cec5d3c4d2" else . end)' $file > temp.json && mv temp.json $file
# done

# Copy the examples to the management directory
# echo "Copying the examples to the management directory..."
# cp -r resource-manager/Microsoft.IoTOperations/preview/2024-08-15-preview/examples/. IoTOperations.Management/examples/2024-08-15-preview/

# Recompile the typespecs in the management directory
# echo "Recompiling the typespecs in the management directory..."
npx tsp compile IoTOperations.Management/.
npx tsv IoTOperations.Management/.

# Prettier
# echo "Running prettier..."
# npx prettier --write **/*.json

echo "Completed generating the specs and the examples!"
echo "Done!"