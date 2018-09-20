## Node.js

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: arm-dns
  output-folder: $(typescript-sdks-folder)/packages/arm-dns
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
