
## TypeScript
These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  package-name: "@azure/loganalytics"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/loganalytics"
  override-client-name: LogAnalyticsClient
  generate-metadata: true
```