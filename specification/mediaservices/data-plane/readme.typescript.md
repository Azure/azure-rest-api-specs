## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/azure-media-edge-lva-client"
  output-folder: "$(typescript-sdks-folder)/sdk/mediaservices/azure-media-edge-lva-client"
  clear-output-folder: true
  generate-metadata: true
```
