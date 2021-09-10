## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-kubernetesconfiguration"
  output-folder: "$(typescript-sdks-folder)/sdk/kubernetesconfiguration/arm-kubernetesconfiguration"
  clear-output-folder: true
  override-client-name: SourceControlConfigurationClient
  generate-metadata: true
```
