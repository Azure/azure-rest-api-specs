## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
client-flattened-annotation-target: disabled
directive:
  - from: arcSettings.json
    where: $.definitions.ArcSetting.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
  - from: clusters.json
    where: $.definitions.Cluster.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
  - from: extensions.json
    where: $.definitions.Extension.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
```
