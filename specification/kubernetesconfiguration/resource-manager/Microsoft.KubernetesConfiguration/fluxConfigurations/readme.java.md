## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
title: FluxConfigClient
rename-operation-group: FluxConfigOperationStatus:OperationStatus,FluxConfigurations:FluxConfigs
rename-model: FluxConfigurationPatchProperties:FluxConfigPatchProperties
directive:
  - from: fluxconfiguration.json
    where: $.definitions.KustomizationDefinition.properties.wait
    transform: >
      $["x-ms-client-name"] = "enableWait"
  - from: fluxconfiguration.json
    where: $.definitions.KustomizationPatchDefinition.properties.wait
    transform: >
      $["x-ms-client-name"] = "enableWait"
```
