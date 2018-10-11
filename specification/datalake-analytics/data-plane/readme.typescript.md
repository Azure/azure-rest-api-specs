These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
batch:
  - package-catalog: true
  - package-job: true
typescript:
  azure-arm: true
  package-name: "@azure/arm-datalake-analytics"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/arm-datalake-analytics"
  generate-metadata: true
```

``` yaml $(nodejs) && $(tag) == 'package-catalog'
nodejs:
  source-code-folder-path: lib/catalog
```

``` yaml $(nodejs) && $(tag) == 'package-job'
nodejs:
  source-code-folder-path: lib/job
```
