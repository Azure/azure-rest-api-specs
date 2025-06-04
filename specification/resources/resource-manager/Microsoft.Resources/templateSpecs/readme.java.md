## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.resources.templatespecs
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/templatespecs
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
```
