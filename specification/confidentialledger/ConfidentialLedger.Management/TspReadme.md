

``` yaml

library-name: ConfidentialLedger
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/756495dd7e0e2f5181039def47a8c85ff0787b66/specification/confidentialledger/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

override-operation-name:
  CheckNameAvailability: CheckConfidentialLedgerNameAvailability

format-by-name-rules:
  'tenantId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'
  'principalId': 'uuid'


prepend-rp-prefix:
  - DeploymentType
  - LanguageRuntime
  - RunningState
  - MemberIdentityCertificate

rename-mapping:
  CheckNameAvailabilityRequest: ConfidentialLedgerNameAvailabilityContent
  CheckNameAvailabilityRequest.type: -|resource-type
  CheckNameAvailabilityResponse: ConfidentialLedgerNameAvailabilityResult
  CheckNameAvailabilityResponse.nameAvailable: IsNameAvailable
  CheckNameAvailabilityReason: ConfidentialLedgerNameUnavailableReason
  LedgerProperties: ConfidentialLedgerProperties
  LedgerRoleName: ConfidentialLedgerRoleName
  LedgerType: ConfidentialLedgerType
  ProvisioningState: ConfidentialLedgerProvisioningState

```
