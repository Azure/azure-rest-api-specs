## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-datalake-analytics
  package-version: 3.0.0-preview
  output-folder: $(node-sdks-folder)/lib/services/dataLake.Analytics
  generate-license-txt: false
  generate-package-json: false
  generate-readme-md: false
  batch:
    - tag: package-catalog
    - tag: package-job
```

``` yaml $(nodejs) && $(tag) == 'package-catalog'
nodejs:
  source-code-folder-path: lib/catalog
```

``` yaml $(nodejs) && $(tag) == 'package-job'
nodejs:
  source-code-folder-path: lib/job
```