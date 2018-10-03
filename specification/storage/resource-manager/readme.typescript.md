## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-storage"
  payload-flattening-threshold: 2
  override-client-name: StorageManagementClient
  generate-metadata: true
  generate-readme-md: false
  api-versions:
    - 2018-03-01-preview
    - "2018-02-01"
    - "2017-10-01"
    - "2016-01-01"
```

``` yaml $(typescript) && $(multiapi)
batch:
  - tag: package-2016-01
    api-version: "2016-01-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-storage-2016-01-01
  - tag: package-2017-10
    api-version: "2017-10-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-storage-2017-10-01
  - tag: package-2018-02
    api-version: "2018-02-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-storage-2018-02-01
  - tag: package-2018-03
    api-version: 2018-03-01-preview
    output-folder: $(typescript-sdks-folder)/packages/arm-storage-2018-03-01-preview
  - multiapi-latest: true
    output-folder: $(typescript-sdks-folder)/packages/arm-storage
```
