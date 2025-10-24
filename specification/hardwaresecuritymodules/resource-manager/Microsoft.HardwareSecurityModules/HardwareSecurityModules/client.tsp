import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HardwareSecurityModules;
using Azure.Core;

@@clientName(Microsoft.HardwareSecurityModules,
  "HardwareSecurityModulesMgmtClient",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkResourceProperties,
  "CloudHsmClusterPrivateLinkResourceProperties",
  "csharp"
);
@@usage(Azure.ResourceManager.CommonTypes.PrivateLinkResourceProperties,
  Usage.input,
  "csharp"
);

@@clientName(CloudHsmClusters.cloudHsmClusterBackupStatusGet,
  "GetCloudHsmClusterBackupStatus",
  "csharp"
);

@@clientName(CloudHsmClusters.cloudHsmClusterRestoreStatusGet,
  "GetCloudHsmClusterRestoreStatus",
  "csharp"
);

@@clientName(ActivationState, "SecurityDomainActivationState", "csharp");
@@clientName(BackupRequestProperties, "CloudHsmClusterBackupContent", "csharp");
@@clientName(BackupResult, "CloudHsmClusterBackupResult", "csharp");
@@clientName(BackupResultProperties,
  "CloudHsmClusterBackupResultProperties",
  "csharp"
);
@@clientName(EndpointDetail, "DedicatedHsmEndpointDetail", "csharp");
@@clientName(EndpointDependency, "DedicatedHsmEndpointDependency", "csharp");
@@clientName(JsonWebKeyType, "DedicatedHsmJsonWebKeyType", "csharp");
@@clientName(NetworkInterface, "DedicatedHsmNetworkInterface", "csharp");
@@clientName(NetworkProfile, "DedicatedHsmNetworkProfile", "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "DedicatedHsmEgressEndpoint",
  "csharp"
);
@@clientName(OutboundEnvironmentEndpointCollection,
  "DedicatedHsmEgressEndpointListResult",
  "csharp"
);

@@clientName(PrivateEndpointConnection,
  "CloudHsmClusterPrivateEndpointConnection",
  "csharp"
);

@@clientName(PrivateEndpointConnectionProperties,
  "CloudHsmClusterPrivateEndpointConnectionProperties",
  "csharp"
);

@@clientName(PrivateEndpointConnectionProvisioningState,
  "CloudHsmClusterPrivateEndpointConnectionProvisioningState",
  "csharp"
);

@@clientName(PrivateEndpointServiceConnectionStatus,
  "CloudHsmClusterPrivateEndpointServiceConnectionStatus",
  "csharp"
);

@@clientName(ProvisioningState, "CloudHsmClusterProvisioningState", "csharp");
@@clientName(PublicNetworkAccess,
  "CloudHsmClusterPublicNetworkAccess",
  "csharp"
);
@@clientName(Sku, "DedicatedHsmSku", "csharp");
@@clientName(SkuName, "DedicatedHsmSkuName", "csharp");
@@clientName(RestoreRequestProperties,
  "CloudHsmClusterRestoreContent",
  "csharp"
);
@@clientName(RestoreResult, "CloudHsmClusterRestoreResult", "csharp");
@@clientName(SkuName.`SafeNet Luna Network HSM A790`,
  "SafeNetLunaNetworkHsmA790",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK1_CPS60,
  "PayShield10KLmk1Cps60",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK1_CPS250,
  "PayShield10KLmk1Cps250",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK1_CPS2500,
  "PayShield10KLmk1Cps2500",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK2_CPS60,
  "PayShield10KLmk2Cps60",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK2_CPS250,
  "PayShield10KLmk2Cps250",
  "csharp"
);
@@clientName(SkuName.payShield10K_LMK2_CPS2500,
  "PayShield10KLmk2Cps2500",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkServiceConnectionState,
  "CloudHsmClusterPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointServiceConnectionStatus,
  "CloudHsmClusterPrivateEndpointServiceConnectionStatus",
  "csharp"
);
@@clientName(CloudHsmClusterPatchParameters, "DedicatedHsmPatch", "csharp");
@@alternateType(PrivateEndpointConnection.etag, eTag, "csharp");
@@usage(Azure.ResourceManager.PrivateLinkResource, Usage.input, "csharp");
@@clientName(Azure.ResourceManager.PrivateLinkResource,
  "CloudHsmClusterPrivateLinkData",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "connectionState ",
  "csharp"
);
