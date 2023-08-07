## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-videosearch
  output-folder: $(node-sdks-folder)/lib/services/videoSearch
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```
