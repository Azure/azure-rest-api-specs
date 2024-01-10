

``` yaml

library-name: AppComplianceAutomation
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/da15318e582f0cd1ea01e7a2556190c98aa1578f/specification/appcomplianceautomation/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  AssessmentResource: AssessmentResourceContent

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```
