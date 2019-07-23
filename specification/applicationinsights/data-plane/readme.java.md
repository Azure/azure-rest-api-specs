## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: false
  namespace: com.microsoft.azure.applicationinsights.query
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/applicationinsights/data-plane
  regenerate-manager: true
  generate-interface: false
directive:
  - from: swagger-document
    where: $.definitions.table.properties.rows.items.items.type
    transform: $ = "object"
```
