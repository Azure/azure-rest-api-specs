## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-customvision-prediction
  output-folder: $(node-sdks-folder)/lib/services/customVision/prediction
  override-client-name: PredictionAPIClient
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
