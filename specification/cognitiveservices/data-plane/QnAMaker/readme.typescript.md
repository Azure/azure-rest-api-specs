## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'release_4_0' && $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-qnamaker"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-qnamaker"
  azure-arm: false
  generate-metadata: true
```

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'release_5_0_preview.1' && $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-qnamaker"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-qnamaker/preview"
  azure-arm: false
  generate-metadata: true
```
