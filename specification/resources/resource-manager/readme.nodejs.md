## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-resource
  batch:
  - tag: package-features
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/feature
  - tag: package-locks
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/lock
  - tag: package-policy
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/policy
  - tag: package-resources
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/resource
  - tag: package-subscriptions
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/subscription
  - tag: package-links
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/link
  - tag: package-management
    output-folder: $(node-sdks-folder)/lib/services/resourceManagement/lib/link
```
