## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-authorization"
  payload-flattening-threshold: 1
  generate-metadata: true
  api-versions:
    - 2018-09-01-preview
    - 2018-01-01-preview
    - 2017-10-01-preview
    - "2015-07-01"
```

``` yaml $(typescript) && $(multiapi)
batch:
  - tag: package-2015-07
    api-version: "2015-07-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-authorization-2015-07-01
  - tag: package-2017-10-01-preview
    api-version: 2017-10-01-preview
    output-folder: $(typescript-sdks-folder)/packages/arm-authorization-2017-10-01-preview
  - tag: package-2018-01-01-preview
    api-version: 2018-01-01-preview
    output-folder: $(typescript-sdks-folder)/packages/arm-authorization-2018-01-01-preview
  - tag: package-2018-09-01-preview
    api-version: 2018-09-01-preview
    output-folder: $(typescript-sdks-folder)/packages/arm-authorization-2018-09-01-preview
  - multiapi-latest: true
    output-folder: $(typescript-sdks-folder)/packages/arm-authorization
```