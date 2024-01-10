

``` yaml

library-name: Confluent
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/80065490402157d0df0dd37ab347c651b22eb576/specification/confluent/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


prepend-rp-prefix:
  - ProvisionState
  - UserDetail
  - OfferDetail
  - SaaSOfferStatus

rename-mapping:
  OrganizationResource: ConfluentOrganization
  OrganizationResource.properties.organizationId: -|uuid
  OrganizationResourceListResult: ConfluentOrganizationListResult
  ConfluentAgreementResource: ConfluentAgreement
  ConfluentAgreementResource.properties.accepted: IsAccepted
  ConfluentAgreementResource.properties.retrieveDatetime: RetrieveOn
  OrganizationResourceUpdate: ConfluentOrganizationPatch
  ConfluentAgreementResourceListResponse: ConfluentAgreementListResult

override-operation-name:
  Validations_ValidateOrganization: ValidateOrganization
directive:
  - remove-operation: OrganizationOperations_List
```
