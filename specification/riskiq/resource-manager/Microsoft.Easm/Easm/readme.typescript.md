## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
title: EasmMgmtClient
typescript:
  azure-arm: true
  package-name: "@azure/arm-defendereasm"
  output-folder: "$(typescript-sdks-folder)/sdk/defendereasm/arm-defendereasm"
  generate-metadata: true
```
