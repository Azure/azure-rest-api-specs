## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-contentmoderator
  package-version: 3.0.0
  output-folder: $(node-sdks-folder)/lib/services/contentModerator
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```
