## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

### Tag: package-2024-11 and java

These settings apply only when `--tag=package-2024-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-11' && $(java)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.extensions.v2024_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2024_11_01
  regenerate-manager: true
  generate-interface: true
```