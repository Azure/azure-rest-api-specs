## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.azure.digitaltwins.core
  implementation-subpackage: implementation
  models-subpackage: implementation.models
  custom-types-subpackage: models
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-digitaltwins-core
```