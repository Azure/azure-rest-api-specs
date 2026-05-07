import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.RedHatOpenShift,
  "AzureRedHatOpenShiftClient",
  "javascript,python"
);

@@clientName(Microsoft.RedHatOpenShift.APIServerProfile,
  "ApiServerProfile",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.EffectiveOutboundIP,
  "EffectiveOutboundIp",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.PreconfiguredNSG,
  "PreconfiguredNsg",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.NetworkProfile.preconfiguredNSG,
  "preconfiguredNsg",
  "java"
);

// ---- C# rename mappings (preserve names from previous AutoRest-based SDK) ----
@@clientName(Microsoft.RedHatOpenShift, "RedHatOpenShiftManagementClient", "csharp");

@@clientName(Microsoft.RedHatOpenShift.APIServerProfile, "OpenShiftApiServerProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.ProvisioningState, "OpenShiftClusterProvisioningState", "csharp");
@@clientName(Microsoft.RedHatOpenShift.Visibility, "OpenShiftVisibility", "csharp");
@@clientName(Microsoft.RedHatOpenShift.NetworkProfile, "OpenShiftNetworkProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.ClusterProfile, "OpenShiftClusterProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.MasterProfile, "OpenShiftMasterProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.WorkerProfile, "OpenShiftWorkerProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.IngressProfile, "OpenShiftIngressProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.LoadBalancerProfile, "OpenShiftLoadBalancerProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.ServicePrincipalProfile, "OpenShiftServicePrincipalProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.OutboundType, "OpenShiftOutboundType", "csharp");
@@clientName(Microsoft.RedHatOpenShift.OutboundType.Loadbalancer, "LoadBalancer", "csharp");
@@clientName(Microsoft.RedHatOpenShift.EncryptionAtHost, "OpenShiftEncryptionAtHost", "csharp");
@@clientName(Microsoft.RedHatOpenShift.FipsValidatedModules, "OpenShiftFipsValidatedModules", "csharp");
@@clientName(Microsoft.RedHatOpenShift.PreconfiguredNSG, "OpenShiftPreconfiguredNsg", "csharp");
@@clientName(Microsoft.RedHatOpenShift.PlatformWorkloadIdentity, "OpenShiftPlatformWorkloadIdentity", "csharp");
@@clientName(Microsoft.RedHatOpenShift.PlatformWorkloadIdentityProfile, "OpenShiftPlatformWorkloadIdentityProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.PlatformWorkloadIdentityRole, "OpenShiftPlatformWorkloadIdentityRole", "csharp");
@@clientName(Microsoft.RedHatOpenShift.ConsoleProfile, "OpenShiftConsoleProfile", "csharp");
@@clientName(Microsoft.RedHatOpenShift.ManagedOutboundIPs, "OpenShiftManagedOutboundIPs", "csharp");

// Property casing fixes for C#
@@clientName(Microsoft.RedHatOpenShift.OpenShiftClusterProperties.apiserverProfile,
  "apiServerProfile",
  "csharp"
);
@@clientName(Microsoft.RedHatOpenShift.NetworkProfile.preconfiguredNSG,
  "preconfiguredNsg",
  "csharp"
);

// arm-id formatted properties (mirrors autorest format-by-name-rules)
@@alternateType(Microsoft.RedHatOpenShift.MasterProfile.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.MasterProfile.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.WorkerProfile.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.WorkerProfile.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.ClusterProfile.resourceGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.PlatformWorkloadIdentity.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.PlatformWorkloadIdentityRole.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.RedHatOpenShift.EffectiveOutboundIP.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
