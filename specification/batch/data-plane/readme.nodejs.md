## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-batch
  output-folder: $(node-sdks-folder)/lib/services/batch/lib
  payload-flattening-threshold: 1
```
