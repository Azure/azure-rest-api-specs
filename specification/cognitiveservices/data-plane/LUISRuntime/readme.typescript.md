## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-luis-runtime"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-luis-runtime"
  azure-arm: false
  generate-metadata: true
  test: true
  test-dependencies: "nock@10.0.0"
```
