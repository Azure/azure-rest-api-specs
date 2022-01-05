## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-machinelearning
  output-folder: $(node-sdks-folder)/lib/services/machinelearning
  generate-license-txt: false
  generate-package-json: false
  generate-readme-md: false
batch:
  - package-commitmentPlans: true
    source-code-folder-path: lib/commitmentPlan
  - package-webservices: true
    source-code-folder-path: lib/webservices
  - package-workspaces: true
    source-code-folder-path: lib/workspaces
```
