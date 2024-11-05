## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: imagebuilder.json
    where: $.definitions.ImageTemplateProperties.properties.validate
    transform: >
      $["x-ms-client-name"] = "validation";
    reason: property name validate collides with built-in method name
```