## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-entitysearch"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/cognitiveservices-entitysearch"
  override-client-name: EntitySearchAPIClient
  azure-arm: false
  generate-metadata: true
```
