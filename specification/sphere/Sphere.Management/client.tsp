import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.AzureSphere, "AzureSphereMgmtClient", "python");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Backward-compat client names for C# (ApiCompat)
@@clientName(Microsoft.AzureSphere.Catalog, "SphereCatalog", "csharp");
@@clientName(Microsoft.AzureSphere.Certificate, "SphereCertificate", "csharp");
@@clientName(Microsoft.AzureSphere.Deployment, "SphereDeployment", "csharp");
@@clientName(Microsoft.AzureSphere.Device, "SphereDevice", "csharp");
@@clientName(Microsoft.AzureSphere.DeviceGroup, "SphereDeviceGroup", "csharp");
@@clientName(Microsoft.AzureSphere.Image, "SphereImage", "csharp");
@@clientName(Microsoft.AzureSphere.Product, "SphereProduct", "csharp");

@@clientName(Microsoft.AzureSphere.AllowCrashDumpCollection, "SphereAllowCrashDumpCollectionStatus", "csharp");
@@clientName(Microsoft.AzureSphere.CapabilityType, "SphereCapabilityType", "csharp");
@@clientName(Microsoft.AzureSphere.CertificateStatus, "SphereCertificateStatus", "csharp");
@@clientName(Microsoft.AzureSphere.CertificateProperties, "SphereCertificateProperties", "csharp");
@@clientName(Microsoft.AzureSphere.CertificateChainResponse, "SphereCertificateChainResult", "csharp");
@@clientName(Microsoft.AzureSphere.DeviceInsight, "SphereDeviceInsight", "csharp");
@@clientName(Microsoft.AzureSphere.OSFeedType, "SphereOSFeedType", "csharp");
@@clientName(Microsoft.AzureSphere.ImageType, "SphereImageType", "csharp");
@@clientName(Microsoft.AzureSphere.ProvisioningState, "SphereProvisioningState", "csharp");
@@clientName(Microsoft.AzureSphere.UpdatePolicy, "SphereUpdatePolicy", "csharp");

@@clientName(Microsoft.AzureSphere.CountDevicesResponse, "CountDevicesResult", "csharp");
@@clientName(Microsoft.AzureSphere.CountElementsResponse, "CountElementsResult", "csharp");
@@clientName(Microsoft.AzureSphere.ClaimDevicesRequest, "ClaimSphereDevicesContent", "csharp");
@@clientName(Microsoft.AzureSphere.GenerateCapabilityImageRequest, "GenerateCapabilityImageContent", "csharp");
@@clientName(Microsoft.AzureSphere.ListDeviceGroupsRequest, "ListSphereDeviceGroupsContent", "csharp");
@@clientName(Microsoft.AzureSphere.ProofOfPossessionNonceRequest, "ProofOfPossessionNonceContent", "csharp");
