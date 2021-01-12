## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
batch:
    - package-access-control: true
      package-name: "@azure/synapse-accesscontrol"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-accesscontrol
      clear-output-folder: true
    - package-artifacts: true
      package-name: "@azure/synapse-artifacts"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-artifacts
      clear-output-folder: true
    - package-spark: true
      package-name: "@azure/synapse-spark"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-spark
      clear-output-folder: true
```
