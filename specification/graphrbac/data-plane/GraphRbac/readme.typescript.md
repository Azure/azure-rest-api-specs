## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/graph"
  output-folder: "$(typescript-sdks-folder)/sdk/graphrbac/graph"
  payload-flattening-threshold: 1
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```
