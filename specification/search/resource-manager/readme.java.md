## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
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
    reason: Handle breaking change.
```
