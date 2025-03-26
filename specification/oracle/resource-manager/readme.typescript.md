## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
title: OracleDatabaseManagementClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-oracledatabase"
  output-folder: "$(typescript-sdks-folder)/sdk/oracledatabase/arm-oracledatabase"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
```
