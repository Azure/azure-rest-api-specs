## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
title: AzureMachineLearningServicesManagementClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-machinelearning"
  output-folder: "$(typescript-sdks-folder)/sdk/machinelearning/arm-machinelearning"
  generate-metadata: true
```
