## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-netapp"
  payload-flattening-threshold: 2
  output-folder: "$(typescript-sdks-folder)/sdk/netapp/arm-netapp"
  generate-metadata: true

directive:
- from: swagger-document
  where: $.definitions.replicationObject.properties.replicationSchedule
  transform: >
    $['x-ms-enum'] = {
        "name": "ReplicationSchedule",
        "modelAsString": true,
        "values": [
          {
              "value": "_10minutely",
              "name": "TenMinutely"
          },
          {
              "value": "hourly",
              "name": "Hourly"
          },
          {
              "value": "daily",
              "name": "Daily"
          }
        ]
      };

- from: swagger-document
  where: $.definitions.replication.properties.replicationSchedule
  transform: >
    $['x-ms-enum'] = {
        "name": "ReplicationSchedule",
        "modelAsString": true,
        "values": [
          {
              "value": "_10minutely",
              "name": "TenMinutely"
          },
          {
              "value": "hourly",
              "name": "Hourly"
          },
          {
              "value": "daily",
              "name": "Daily"
          }
        ]
      };
```