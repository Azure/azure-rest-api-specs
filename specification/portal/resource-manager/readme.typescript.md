## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-portal"
  output-folder: "$(typescript-sdks-folder)/sdk/portal/arm-portal"
  clear-output-folder: true
  payload-flattening-threshold: 1
  generate-metadata: true
```
