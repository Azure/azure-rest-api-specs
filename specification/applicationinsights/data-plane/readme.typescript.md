
## TypeScript
These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
directive:
  - reason: Remove Events_GetOdataMetadata from Node SDK due to XML issues.
    remove-operation: Events_GetOdataMetadata
typescript:
  package-name: "@azure/applicationinsights-query"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/applicationinsights-query"
  generate-metadata: true
```