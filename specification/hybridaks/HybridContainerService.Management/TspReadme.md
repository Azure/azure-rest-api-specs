

``` yaml

library-name: HybridContainerService
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/844b06b77ca841a151a6aa2a459f126e277f3c77/specification/hybridaks/resource-manager/readme.md
# tag: package-preview-2022-09
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

rename-mapping:
  ProvisionedClustersResponse: ProvisionedCluster


prepend-rp-prefix:
  - AgentPool
  - VirtualNetworks
```
