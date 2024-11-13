## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-kubernetesconfiguration/privatelinkscopes"
  output-folder: "$(typescript-sdks-folder)/sdk/kubernetesconfiguration/arm-kubernetesconfiguration"
  override-client-name: PrivateLinkScopesClient
  generate-metadata: true
```
