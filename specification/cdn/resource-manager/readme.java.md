## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
rename-model: CdnEndpoint:EndpointResource
enable-sync-stack: false

directive:
  - from: swagger-document
    where: $.definitions.DeliveryRuleAction.properties.name
    transform: >
      $['x-ms-enum'] = {
        "name": "DeliveryRuleActionValue",
        "modelAsString": true
      };
```