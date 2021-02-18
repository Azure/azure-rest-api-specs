## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-storagecache"
  payload-flattening-threshold: 2
  output-folder: "$(typescript-sdks-folder)/sdk/storagecache/arm-storagecache"
  clear-output-folder: true
  generate-metadata: true
```
