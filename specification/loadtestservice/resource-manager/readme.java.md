## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
property-include-always: EncryptionPropertiesIdentity.resourceId
directive:
  from: loadtestservice.json
  where: "$.definitions.LoadTestResourceUpdate"
  transform: >
    $["x-ms-client-name"] = "LoadTestResourcePatchRequestBody";
```
