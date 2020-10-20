## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/Bing-websearch"
  output-folder: "$(typescript-sdks-folder)/sdk/Bing/Bing-websearch"
  azure-arm: false
  generate-metadata: true
```
