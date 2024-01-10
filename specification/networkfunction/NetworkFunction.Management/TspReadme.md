

``` yaml

library-name: NetworkFunction
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/fa7609844bc20b126037dfb180ef7155c2174f7b/specification/networkfunction/resource-manager/readme.md
tag: package-2022-11-01
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - remove-operation: NetworkFunction_ListOperations
  - from: swagger-document
    where: $.definitions
    transform: >
      $.SystemData.properties.lastModifiedAt = {
          'type': 'string',
          'format': 'date-time',
          'description': 'The timestamp of resource last modification (UTC)'
        };
      $.ProvisioningState['x-ms-enum']['name'] = 'CollectorProvisioningState';
      $.IngestionSourcesPropertiesFormat.properties.sourceType['x-ms-enum']['name'] = 'IngestionSourceType';
      $.EmissionPolicyDestination.properties.destinationType['x-ms-enum']['name'] = 'EmissionDestinationType';

```
