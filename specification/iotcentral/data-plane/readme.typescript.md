## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "azure-iotcentral"
  package-version: 2022-05-31
  output-folder: "$(typescript-sdks-folder)/packages/iotcentral"
  payload-flattening-threshold: 1
  generate-metadata: true
```