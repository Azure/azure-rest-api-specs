## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
title: CustomLocationsManagementClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-extendedlocation"
  output-folder: "$(typescript-sdks-folder)/sdk/extendedlocation/arm-extendedlocation"
  payload-flattening-threshold: 1
  generate-metadata: true
```
