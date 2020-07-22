## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
<<<<<<< HEAD
  package-version: 0.1.0
  azure-arm: true
  package-name: "@azure/arm-avs"
  override-client-name: AvsClient
  output-folder: "$(typescript-sdks-folder)/sdk/avs/arm-avs"
  payload-flattening-threshold: 1
  generate-metadata: true
```
=======
  package-version: 0.3.0
  azure-arm: true
  package-name: "@azure/arm-vmware"
  output-folder: "$(typescript-sdks-folder)/sdk/vmware/arm-vmware"
  payload-flattening-threshold: 1
  generate-metadata: true
```
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
