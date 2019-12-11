## Node.js

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-privatedns"
  output-folder: "$(typescript-sdks-folder)/sdk/privatedns/arm-privatedns"
  clear-output-folder: true
  generate-metadata: true
```
