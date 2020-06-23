## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/keyvault"
  output-folder: "$(typescript-sdks-folder)/sdk/keyvault/keyvault"
  generate-license-txt: true
  generate-package-json: false
  generate-readme-md: false
```
