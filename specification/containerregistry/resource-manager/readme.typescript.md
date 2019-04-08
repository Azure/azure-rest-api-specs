## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
input-file:
  - Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json
typescript:
  azure-arm: true
  package-name: "@azure/arm-containerregistry"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-containerregistry"
  generate-metadata: true
```
