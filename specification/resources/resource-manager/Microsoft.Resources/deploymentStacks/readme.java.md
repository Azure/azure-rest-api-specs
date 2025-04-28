## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

### Tag: package-2024-03 and java

These settings apply only when `--tag=package-2024-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.deployments.deploymentstacks
  output-folder: $(azure-libraries-for-java-folder)/sdk/deployments/deploymentstacks
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
```
