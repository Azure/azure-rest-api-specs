## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(tag) == 'release_2021-09-05' && $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-speaker-verification"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-speaker-verification"
  azure-arm: false
  generate-metadata: true
```

``` yaml $(tag) == 'verification_v2_0_preview' && $(typescript)
typescript:
  package-name: "@azure/cognitiveservices-speaker-verification"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-speaker-verification"
  azure-arm: false
  generate-metadata: true
```
