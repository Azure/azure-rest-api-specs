## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
- from: datafactory.json
  where: $.definitions.LinkedServiceReference.properties.type["x-ms-enum"]
  transform: $["modelAsString"] = false
```
