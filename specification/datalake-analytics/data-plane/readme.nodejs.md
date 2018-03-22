## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-datalake-analytics
  batch:
    - output-folder: $(node-sdks-folder)/lib/services/dataLake.Analytics/lib/catalog
      tag: package-catalog
    - output-folder: $(node-sdks-folder)/lib/services/dataLake.Analytics/lib/job
      tag: package-job
```
