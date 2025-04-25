
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

### Tag: package-deployments-2023-11 and java

These settings apply only when `--tag=package-deployments-2023-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-deployments-2023-11' && $(java)
java:
  namespace: com.microsoft.azure.management.deployments.bicep.v2023_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/deployments/mgmt-v2023_11_01
  regenerate-manager: true
  generate-interface: true
```
