
## NodeJS
These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to the root directory of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-loganalytics
  output-folder: $(node-sdks-folder)/lib/services/loganalytics
  override-client-name: LogAnalyticsClient
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false
```