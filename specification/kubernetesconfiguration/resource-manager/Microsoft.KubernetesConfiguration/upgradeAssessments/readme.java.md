## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

### Tag: package-2026-06-preview and java

These settings apply only when `--tag=package-2026-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2026-06-preview' && $(java)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.upgradeassessments.v2026_06_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2026_06_15_preview
  regenerate-manager: true
  generate-interface: true
```