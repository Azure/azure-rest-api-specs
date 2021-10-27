## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
input-file:
  - Microsoft.ContainerRegistry/preview/2021-08-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
typescript:
  azure-arm: true
  package-name: "@azure/arm-containerregistry"
  output-folder: "$(typescript-sdks-folder)/sdk/containerregistry/arm-containerregistry"
  clear-output-folder: true
  generate-metadata: true
```
