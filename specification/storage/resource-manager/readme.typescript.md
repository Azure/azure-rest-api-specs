## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--js-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-storage"
  payload-flattening-threshold: 2
  override-client-name: StorageManagementClient
  generate-metadata: true
  api-versions:
    - "2016-01-01"
    - "2017-10-01"
    - "2018-02-01"
    - 2018-03-01-preview
```

``` yaml $(typescript) && $(default-api-version) == '2018-02-01'
typescript:
  output-folder: $(js-sdks-folder)/packages/arm-storage/lib
```

``` yaml $(typescript) && $(tag) == 'package-2016-01'
typescript:
  output-folder: $(js-sdks-folder)/packages/arm-storage/2016-01-01/lib
```

``` yaml $(typescript) && $(tag) == 'package-2017-10'
typescript:
  output-folder: $(js-sdks-folder)/packages/arm-storage/2017-10-01/lib
```

``` yaml $(typescript) && $(tag) == 'package-2018-02'
typescript:
  output-folder: $(js-sdks-folder)/packages/arm-storage/2018-02-01/lib
```

``` yaml $(typescript) && $(tag) == 'package-2018-03'
typescript:
  output-folder: $(js-sdks-folder)/packages/arm-storage/2018-03-01-preview/lib
```

``` yaml $(typescript) && $(multiapi)
batch:
  - tag: package-2016-01
  - tag: package-2017-10
  - tag: package-2018-02
  - tag: package-2018-03
  - default-api-version: "2018-02-01"
```
