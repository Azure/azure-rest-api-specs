## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-hdinsightcontainers
  output-folder: $(node-sdks-folder)/lib/services/hdInsightContainersManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```

## Tag: package-hdinsightcontainers-2023-06-preview and Node.js

These settings apply only when `--tag=package-hdinsightcontainers-2023-06-preview --nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(tag) == 'package-hdinsightonaks-2023-06-preview' && $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-hdinsightcontainers
  output-folder: $(node-sdks-folder)/lib/services/hdInsightContainersManagement
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: true
```
