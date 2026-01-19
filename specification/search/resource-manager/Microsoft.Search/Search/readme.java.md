## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
enable-sync-stack: false
remove-inner: CheckNameAvailabilityOutput
directive:
  - from: search.json
    where-operation: Services_Update
    transform: >
      $["x-ms-long-running-operation"] = true;
    reason: Swagger bug. PATCH is LRO.
  - from: search.json
    where: $.definitions.SearchServiceProperties.properties.publicNetworkAccess
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change. Also, service will return "Disabled"/"Enabled",instead of "disabled"/"enabled" defined in Swagger. Making it sealed enum will mitigate this.
  - from: search.json
    where: $.definitions.SharedPrivateLinkResourceProperties.properties.status
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: search.json
    where: $.definitions.SharedPrivateLinkResourceProperties.properties.provisioningState
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: search.json
    where: $.definitions.Identity.properties.type
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: search.json
    where: $.definitions.Sku.properties.name
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
```
