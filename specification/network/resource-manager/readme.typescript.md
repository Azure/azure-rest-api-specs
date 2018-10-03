## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-network"
  generate-metadata: true
  api-versions:
    - "2018-07-01"
    - "2018-06-01"
    - "2018-04-01"
    - "2018-02-01"
    - "2018-01-01"
    - "2017-11-01"
    - "2017-10-01"
    - "2017-08-01"
    - "2017-06-01"
    - "2017-03-01"
    - "2016-12-01"
    - "2016-09-01"
```

``` yaml $(typescript) && $(multiapi)
batch:
  - tag: package-2018-07
    api-version: "2018-07-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2018-07-01
  - tag: package-2018-06
    api-version: "2018-06-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2018-06-01
  - tag: package-2018-04
    api-version: "2018-04-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2018-04-01
  - tag: package-2018-02
    api-version: "2018-02-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2018-02-01
  - tag: package-2018-01
    api-version: "2018-01-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2018-01-01
  - tag: package-2017-11
    api-version: "2017-11-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-11-01
  - tag: package-2017-10
    api-version: "2017-10-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-10-01
  - tag: package-2017-09
    api-version: "2017-09-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-09-01
  - tag: package-2017-08
    api-version: "2017-08-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-08-01
  - tag: package-2017-06
    api-version: "2017-06-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-06-01
  - tag: package-2017-03
    api-version: "2017-03-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2017-03-01
  - tag: package-2016-12
    api-version: "2016-12-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2016-12-01
  - tag: package-2016-09
    api-version: "2016-09-01"
    output-folder: $(typescript-sdks-folder)/packages/arm-network-2016-09-01
  - multiapi-latest: true
    output-folder: $(typescript-sdks-folder)/packages/arm-network
```
