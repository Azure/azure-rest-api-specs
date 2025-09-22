## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdk-folder=<path to root folder of your azure-sdk-for-node clone>`.

```yaml $(nodejs)
nodejs:
  azure-arm: true
  payload-flattening-threshold: 1
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
  package-name: customproviders
  output-folder: $(node-sdk-folder)/customproviders/Generated
```
