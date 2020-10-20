## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/bing-autosuggest"
  output-folder: "$(typescript-sdks-folder)/sdk/bing/bing-autosuggest"
  azure-arm: false
  generate-metadata: true
```
