## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-migrationassessment"
  output-folder: "$(typescript-sdks-folder)/sdk/migrate/arm-migrationassessment"
  generate-metadata: true
```
