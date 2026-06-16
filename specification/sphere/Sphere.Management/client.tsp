import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureSphere;

@@clientName(Microsoft.AzureSphere, "AzureSphereMgmtClient", "python");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(CatalogProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(ImageProperties.uri, url, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Certificate.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Deployment.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Device.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceGroup.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Product.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Device.properties,
  "csharp"
);

// Client name mappings
@@clientName(Catalog, "SphereCatalog", "csharp");
@@clientName(ProvisioningState, "SphereProvisioningState", "csharp");
@@clientName(Certificate, "SphereCertificate", "csharp");
@@clientName(CertificateStatus, "SphereCertificateStatus", "csharp");
@@clientName(CertificateProperties, "SphereCertificateProperties", "csharp");
@@clientName(Deployment, "SphereDeployment", "csharp");
@@clientName(Device, "SphereDevice", "csharp");
@@clientName(DeviceGroup, "SphereDeviceGroup", "csharp");
@@clientName(Image, "SphereImage", "csharp");
@@clientName(Product, "SphereProduct", "csharp");
@@clientName(AllowCrashDumpCollection,
  "SphereAllowCrashDumpCollectionStatus",
  "csharp"
);
@@clientName(CapabilityType, "SphereCapabilityType", "csharp");
@@clientName(CertificateChainResponse,
  "SphereCertificateChainResult",
  "csharp"
);
@@clientName(CountDeviceResponse, "CountDeviceResult", "csharp");
@@clientName(CountElementsResponse, "CountElementsResult", "csharp");
@@clientName(DeviceInsight, "SphereDeviceInsight", "csharp");
@@clientName(ImageType, "SphereImageType", "csharp");
@@clientName(OSFeedType, "SphereOSFeedType", "csharp");
@@clientName(UpdatePolicy, "SphereUpdatePolicy", "csharp");
@@clientName(ClaimDevicesRequest, "ClaimSphereDevicesContent", "csharp");
@@clientName(ListDeviceGroupsRequest,
  "ListSphereDeviceGroupsContent",
  "csharp"
);
@@clientName(CountDevicesResponse, "CountDevicesResult", "csharp");
@@clientName(ProofOfPossessionNonceRequest,
  "ProofOfPossessionNonceContent",
  "csharp"
);
@@clientName(GenerateCapabilityImageRequest,
  "GenerateCapabilityImageContent",
  "csharp"
);

@@clientName(DeviceProperties.lastOsUpdateUtc, "lastOSUpdateUtc", "csharp");
@@clientName(DeviceProperties.lastInstalledOsVersion,
  "lastInstalledOSVersion",
  "csharp"
);
@@clientName(DeviceProperties.lastAvailableOsVersion,
  "lastAvailableOSVersion",
  "csharp"
);
@@clientName(DeviceGroupProperties.osFeedType, "OSFeedType", "csharp");
@@clientName(DeviceGroupUpdateProperties.osFeedType, "OSFeedType", "csharp");
@@clientName(UpdatePolicy.No3rdPartyAppUpdates,
  "No3RdPartyAppUpdates",
  "csharp"
);
