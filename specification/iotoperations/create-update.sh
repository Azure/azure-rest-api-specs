#!/bin/bash

# This is a simple script
echo "Hello, world!" # Print a greeting
echo "Today is $(date)" # Print the current date

#cd IoTOperationsOrchestrator.Management/
npx tsp compile IoTOperationsOrchestrator.Management/.
npx tsp compile IoTOperationsMQ.Management/.
npx tsp compile IoTOperationsDataProcessor.Management/.

#cd ../IoTOperationsOrchestrator.Management/

oav generate-examples resource-manager/Microsoft.IoTOperationsOrchestrator/preview/2023-10-04-preview/openapi.json -p

oav generate-examples resource-manager/Microsoft.IoTOperationsMQ/preview/2023-10-04-preview/iotoperationsmq.json -p

oav generate-examples resource-manager/Microsoft.IoTOperationsDataProcessor/preview/2023-10-04-preview/openapi.json -p

# Specify the root directory where the files are located
root_directory="/path/to/root_directory"

# Delete files ending with "_MinimumSet_Gen.json" in the root_directory and its subdirectories
# find -type f -name "*_MinimumSet_Gen.json" -exec rm {} \;

echo "Files with _MinimumSet_Gen.json suffix deleted"

cp resource-manager/Microsoft.IoTOperationsOrchestrator/preview/2023-10-04-preview/examples IoTOperationsOrchestrator.Management/

cp resource-manager/Microsoft.IoTOperationsDataProcessor/preview/2023-10-04-preview/examples IoTOperationsDataProcessor.Management/

cp resource-manager/Microsoft.IoTOperationsMQ/preview/2023-10-04-preview/examples IoTOperationsMQ.Management/

npx tsp compile IoTOperationsOrchestrator.Management/.
npx tsp compile IoTOperationsMQ.Management/.
npx tsp compile IoTOperationsDataProcessor.Management/.