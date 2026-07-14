## JavaScript

These settings apply only when `--javascript` is specified on the command line.
Please also specify `--javascript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(javascript)
javascript:
  azure-arm: true
  package-name: "@azure/arm-migrate"
  output-folder: "$(javascript-sdks-folder)/sdk/migrate/arm-migrate"
  generate-metadata: true
```
