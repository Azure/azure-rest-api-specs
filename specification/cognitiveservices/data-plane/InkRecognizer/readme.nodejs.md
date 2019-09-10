## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdk-folder=<path to root folder of your azure-sdk-for-node clone>`.

```yaml $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-inkrecognizer
  output-folder: $(node-sdks-folder)/lib/services/cognitiveServicesInkRecognizer
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```
