## Node.js

These settings apply only when `--nodejs --tag=release_4_0` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(tag) == 'release_4_0' && $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-qnamaker
  output-folder: $(node-sdks-folder)/lib/services/cognitiveServicesQnAMaker
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```

These settings apply only when `--nodejs --tag=release_5_0-preview.1` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(tag) == 'release_5_0_preview.1' && $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-qnamaker-preview
  output-folder: $(node-sdks-folder)/lib/services/cognitiveServicesQnAMaker/preview
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
