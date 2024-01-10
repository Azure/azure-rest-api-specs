

``` yaml

library-name: ManagedServiceIdentities
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/1e790cfc5ee4e7ff98f99dd19a3174c4dd58432b/specification/msi/resource-manager/readme.md
tag: package-2023-01-31
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
  Identity: UserAssignedIdentity
  AzureResource: IdentityAssociatedResourceData
  FederatedIdentityCredential.properties.issuer: IssuerUri

generate-arm-resource-extensions:
  - /{scope}/providers/Microsoft.ManagedIdentity/identities/default
```
