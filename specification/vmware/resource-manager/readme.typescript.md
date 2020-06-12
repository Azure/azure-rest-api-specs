## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  package-version: 0.1.0
  azure-arm: true
  package-name: "@azure/arm-vmware"
  output-folder: "$(typescript-sdks-folder)/sdk/vmware/arm-vmware"
  payload-flattening-threshold: 1
  generate-metadata: true
```
