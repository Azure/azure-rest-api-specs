## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true
batch:
  - package-commitmentPlans: true
    package-name: "@azure/arm-commitmentplans"
    output-folder: $(typescript-sdks-folder)/sdk/machinelearning/arm-commitmentplans
  - package-webservices: true
    package-name: "@azure/arm-webservices"
    output-folder: $(typescript-sdks-folder)/sdk/machinelearning/arm-webservices
  - package-workspaces: true
    package-name: "@azure/arm-workspaces"
    output-folder: $(typescript-sdks-folder)/sdk/machinelearning/arm-workspaces
```
