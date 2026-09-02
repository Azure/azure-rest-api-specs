## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: "@azure/arm-quantum"
  output-folder: "$(typescript-sdks-folder)/sdk/quantum/arm-quantum"
  payload-flattening-threshold: 1
  generate-metadata: true
  generate-license-txt: true
  generate-package-json: false
  generate-readme-md: false
```
