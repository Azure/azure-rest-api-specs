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

### Tag: package-2024-11 and java

These settings apply only when `--tag=package-2024-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-11' && $(java)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.fluxconfiguration.v2024_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2024_11_01
  regenerate-manager: true
  generate-interface: true
```
