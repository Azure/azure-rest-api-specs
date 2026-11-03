import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.RedHatOpenShift;

@@clientName(
  Microsoft.RedHatOpenShift,
  "AzureRedHatOpenShiftClient",
  "javascript,python"
);

@@clientName(APIServerProfile, "ApiServerProfile", "java");
@@clientName(EffectiveOutboundIP, "EffectiveOutboundIp", "java");
@@clientName(PreconfiguredNSG, "PreconfiguredNsg", "java");
@@clientName(NetworkProfile.preconfiguredNSG, "preconfiguredNsg", "java");

//@@clientName(Microsoft.RedHatOpenShift, "RedHatOpenShiftManagementClient", "csharp");
@@clientName(APIServerProfile, "OpenShiftApiServerProfile", "csharp");
@@clientName(ProvisioningState, "OpenShiftClusterProvisioningState", "csharp");
@@clientName(Visibility, "OpenShiftVisibility", "csharp");
@@clientName(NetworkProfile, "OpenShiftNetworkProfile", "csharp");
@@clientName(ClusterProfile, "OpenShiftClusterProfile", "csharp");
@@clientName(MasterProfile, "OpenShiftMasterProfile", "csharp");
@@clientName(WorkerProfile, "OpenShiftWorkerProfile", "csharp");
@@clientName(IngressProfile, "OpenShiftIngressProfile", "csharp");
@@clientName(LoadBalancerProfile, "OpenShiftLoadBalancerProfile", "csharp");
@@clientName(
  ServicePrincipalProfile,
  "OpenShiftServicePrincipalProfile",
  "csharp"
);
@@clientName(OutboundType, "OpenShiftOutboundType", "csharp");
@@clientName(OutboundType.Loadbalancer, "LoadBalancer", "csharp");
@@clientName(EncryptionAtHost, "OpenShiftEncryptionAtHost", "csharp");
@@clientName(FipsValidatedModules, "OpenShiftFipsValidatedModule", "csharp");
@@clientName(PreconfiguredNSG, "OpenShiftPreconfiguredNsg", "csharp");
@@clientName(
  PlatformWorkloadIdentity,
  "OpenShiftPlatformWorkloadIdentity",
  "csharp"
);
@@clientName(
  PlatformWorkloadIdentityProfile,
  "OpenShiftPlatformWorkloadIdentityProfile",
  "csharp"
);
@@clientName(
  PlatformWorkloadIdentityRole,
  "OpenShiftPlatformWorkloadIdentityRole",
  "csharp"
);
@@clientName(ConsoleProfile, "OpenShiftConsoleProfile", "csharp");
@@clientName(ManagedOutboundIPs, "OpenShiftManagedOutboundIPs", "csharp");
@@clientName(
  OpenShiftClusterProperties.apiserverProfile,
  "ApiServerProfile",
  "csharp"
);
@@clientName(NetworkProfile.preconfiguredNSG, "PreconfiguredNsg", "csharp");
@@clientName(NetworkProfile.preconfiguredNSG, "PreconfiguredNsg", "csharp");
@@clientName(
  PlatformWorkloadIdentityRoleSet,
  "OpenShiftPlatformWorkloadIdentityRoleSet",
  "csharp"
);

@@alternateType(
  MasterProfile.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MasterProfile.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  WorkerProfile.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  WorkerProfile.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ClusterProfile.resourceGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PlatformWorkloadIdentity.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PlatformWorkloadIdentityRole.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EffectiveOutboundIP.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(APIServerProfile.url, url, "csharp");
@@alternateType(APIServerProfile.ip, ipV4Address, "csharp");
@@alternateType(ConsoleProfile.url, url, "csharp");
@@alternateType(IngressProfile.ip, ipV4Address, "csharp");
