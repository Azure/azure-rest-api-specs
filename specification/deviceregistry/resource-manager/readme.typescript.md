## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
title: DeviceRegistryManagementClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-deviceregistry"
  output-folder: "$(typescript-sdks-folder)/sdk/deviceregistry/arm-deviceregistry"
  generate-metadata: true

```
