## TypeScript HybridCompute

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true

directive:
  - remove-operation:
    - Machines_Reconnect
```

``` yaml $(typescript) && !$(profile-content)
  package-name: "@azure/arm-hybridcompute"
  output-folder: "$(typescript-sdks-folder)/sdk/hybridcompute/arm-hybridcompute"
```
