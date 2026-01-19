## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
### Directive renaming fields with camelCasing to prevent SDK generation errors
directive:
  - from: computeschedule.json
    where: "$.definitions.OperationErrorDetails.properties.timeStamp"
    transform: >
        $["x-ms-client-name"] = "errorDetailsTimestamp";
  - from: computeschedule.json
    where: "$.definitions.Schedule.properties.timeZone"
    transform: >
        $["x-ms-client-name"] = "scheduleTimezone";
  - from: computeschedule.json
    where: "$.definitions.ResourceOperationDetails.properties.timeZone"
    transform: >
        $["x-ms-client-name"] = "operationTimezone";
  - from: computeschedule.json
    where: "$.definitions.Schedule.properties.deadLine"
    transform: >
        $["x-ms-client-name"] = "scheduleDeadline";
```