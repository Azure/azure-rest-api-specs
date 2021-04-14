## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "azure-maps-rest"
  output-folder: "$(typescript-sdks-folder)/sdk/maps/azure-maps-rest"
  namespace: "atlas.service"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true
```
