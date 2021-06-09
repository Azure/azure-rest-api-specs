## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-m365securityandcompliance"
  output-folder: "$(typescript-sdks-folder)/sdk/m365securityandcompliance/arm-m365securityandcompliance"
  clear-output-folder: true
  generate-metadata: true
```
