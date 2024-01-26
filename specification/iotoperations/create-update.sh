#!/bin/bash

# This is a simple script
echo "Hello, world!" # Print a greeting
echo "Today is $(date)" # Print the current date

#cd IoTOperationsOrchestrator.Management/
npx tsp compile IoTOperationsOrchestrator.Management/.
npx tsp compile IoTOperationsMQ.Management/.
npx tsp compile IoTOperationsDataProcessor.Management/.

oav generate-examples resource-manager/Microsoft.IoTOperationsOrchestrator/preview/2023-10-04-preview/openapi.json -p

oav generate-examples resource-manager/Microsoft.IoTOperationsMQ/preview/2023-10-04-preview/iotoperationsmq.json -p

oav generate-examples resource-manager/Microsoft.IoTOperationsDataProcessor/preview/2023-10-04-preview/openapi.json -p


cp -r resource-manager/Microsoft.IoTOperationsOrchestrator/preview/2023-10-04-preview/examples IoTOperationsOrchestrator.Management/

cp -r resource-manager/Microsoft.IoTOperationsDataProcessor/preview/2023-10-04-preview/examples IoTOperationsDataProcessor.Management/

cp -r resource-manager/Microsoft.IoTOperationsMQ/preview/2023-10-04-preview/examples IoTOperationsMQ.Management/

npx tsp compile IoTOperationsOrchestrator.Management/.
npx tsp compile IoTOperationsMQ.Management/.
npx tsp compile IoTOperationsDataProcessor.Management/.