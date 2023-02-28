## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-managedsc"
  output-folder: "$(typescript-sdks-folder)/sdk/managedsc/arm-managedsc"
  clear-output-folder: true
  generate-metadata: true
```
