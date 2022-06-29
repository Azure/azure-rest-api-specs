## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 0
  package-name: "@azure/arm-databoxedge"
  output-folder: "$(typescript-sdks-folder)/sdk/databoxedge/arm-databoxedge"
  clear-output-folder: true
  generate-metadata: true
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile-content=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-databoxedge-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/databoxedge/arm-databoxedge-profile-2020-09-01-hybrid"
  clear-output-folder: true
  azure-arm: true
  generate-metadata: true
  batch:
    - tag: profile-hybrid-2020-09-01
```
