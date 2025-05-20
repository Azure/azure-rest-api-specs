## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
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

These settings apply only when `--tag=package-2025-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-04' && $(java)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.fluxconfiguration.v2025_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2025_04_01
  regenerate-manager: true
  generate-interface: true
  rename-model: FluxConfigOperationStatusClientImpl:OperationStatusClientImpl,FluxConfigurationClientBuilder:FluxConfigClientBuilder,FluxConfigOperationStatusImpl:OperationStatusImpl,FluxConfigurationClientImpl:FluxConfigClientImpl,FluxConfigurationsClientImpl:FluxConfigsClientImpl,FluxConfigurationPatchProperties:FluxConfigPatchProperties
```
