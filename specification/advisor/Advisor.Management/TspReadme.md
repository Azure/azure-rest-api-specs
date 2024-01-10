

``` yaml

library-name: Advisor
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/db6d33733cd1eb939b863a6cdbcb9de12ac002e1/specification/advisor/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

tag: package-2020-01

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


list-exception:
  - /{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}

override-operation-name:
  Configurations_ListBySubscription: GetConfigurations
  Configurations_ListByResourceGroup: GetConfigurations
  Configurations_CreateInResourceGroup: CreateConfiguration
  Configurations_CreateInSubscription: CreateConfiguration

directive:
  - from: advisor.json
    where: $.paths..parameters[?(@.name === 'resourceUri')]
    transform: >
      $['x-ms-skip-url-encoding'] = true;

```
