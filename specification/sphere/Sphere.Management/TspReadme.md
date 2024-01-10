

``` yaml
library-name: Sphere
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/a89f3906ba60257ae28a2eed756a1ee4ca72ed51/specification/sphere/resource-manager/readme.md
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
  Catalog: SphereCatalog
  ProvisioningState: SphereProvisioningState
  Certificate: SphereCertificate
  CertificateStatus: SphereCertificateStatus
  CertificateProperties: SphereCertificateProperties
  Deployment: SphereDeployment
  Device: SphereDevice
  DeviceGroup: SphereDeviceGroup
  Image: SphereImage
  Product: SphereProduct
  AllowCrashDumpCollection: SphereAllowCrashDumpCollectionStatus
  CapabilityType: SphereCapabilityType
  CertificateChainResponse: SphereCertificateChainResult
  CountDeviceResponse: CountDeviceResult
  CountElementsResponse: CountElementsResult
  DeviceInsight: SphereDeviceInsight
  ImageType: SphereImageType
  OSFeedType: SphereOSFeedType
  UpdatePolicy: SphereUpdatePolicy
  ClaimDevicesRequest: ClaimSphereDevicesContent
  ListDeviceGroupsRequest: ListSphereDeviceGroupsContent

```
