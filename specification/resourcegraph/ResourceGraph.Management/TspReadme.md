

``` yaml

library-name: ResourceGraph
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/e686ed79e9b0bbc10355fd8d7ba36d1a07e4ba28/specification/resourcegraph/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  ErrorDetails: FacetErrorDetails
  QueryRequest: ResourceQueryContent
  QueryRequestOptions: ResourceQueryRequestOptions
  QueryResponse: ResourceQueryResult
  DateTimeInterval.start: StartOn
  DateTimeInterval.end: EndOn

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

override-operation-name:
  Resources: GetResources
  ResourcesHistory: GetResourceHistory


```
