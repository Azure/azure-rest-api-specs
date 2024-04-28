## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: networkFunctionDefinition.json
    where: $.definitions.HelmUpgradeOptions.properties.wait
    transform: >
      $["x-ms-client-name"] = "waitOption"
  - from: networkFunctionDefinition.json
    where: $.definitions.HelmInstallOptions.properties.wait
    transform: >
      $["x-ms-client-name"] = "waitOption"
```
