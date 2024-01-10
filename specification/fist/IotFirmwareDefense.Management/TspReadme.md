

``` yaml
library-name: IotFirmwareDefense
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/97a3d07807c5e7f23e0f47f532d0555ff2aa5d5d/specification/fist/resource-manager/readme.md
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
  GenerateUploadUrlRequest: UploadUrlRequest
  Models.Status: AnalysisStatus
  Component: SbomComponent
  Workspace: FirmwareWorkspace
  Cve: FirmwareCve

```
