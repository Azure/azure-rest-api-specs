## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-hybridnetwork"
  output-folder: "$(typescript-sdks-folder)/sdk/hybridnetwork/arm-hybridnetwork"
  payload-flattening-threshold: 1
  generate-metadata: true

directive:
  - rename-operation:
      from: ProxyArtifact_Get
      to: ProxyArtifact_ListVersions 

```
