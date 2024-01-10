

``` yaml

library-name: HybridConnectivity
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/3c162c839b8fe17544d9a3be8383a835dd42eb28/specification/hybridconnectivity/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - rename-model:
      from: EndpointAccessResource
      to: TargetResourceEndpointAccess
  - from: swagger-document
    where: $.definitions.EndpointProperties.properties.type
    transform: >
      $["x-ms-client-name"] = "EndpointType";
      $["x-ms-enum"]["name"] = "EndpointType"
  - from: swagger-document
    where: $.parameters.ResourceUriParameter
    transform: >
      $["x-ms-client-name"] = "scope"

```
