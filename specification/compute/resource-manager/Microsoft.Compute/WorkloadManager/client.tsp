import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute.WorkloadManager;

@@clientName(ProvisioningState, "WorkloadManagerProvisioningState", "csharp");
@@clientName(VersionPolicy, "WorkloadCapabilityVersionPolicy", "csharp");
@@clientName(CapabilityKind, "WorkloadCapabilityKind", "csharp");
@@clientName(EgressMode, "RuntimeEgressMode", "csharp");
@@clientName(CapacityProfile, "RuntimeLinkCapacityProfile", "csharp");
@@clientName(
  CapacityProfileUpdate,
  "RuntimeLinkCapacityProfilePatch",
  "csharp"
);
@@access(CapacityProfileUpdate, Access.public, "csharp");
@@clientName(CapabilityProperties, "WorkloadCapabilityProperties", "csharp");
@@clientName(Capability, "WorkloadCapability", "csharp");
@@clientName(CapabilityUpdate, "WorkloadCapabilityPatch", "csharp");
@@clientName(
  RuntimeLinkMutableProperties.capacityProfile,
  "CapacityProfile",
  "csharp"
);
@@clientName(
  CapabilityMutableProperties.versionPolicy,
  "VersionPolicy",
  "csharp"
);

@@clientName(
  Microsoft.Compute.WorkloadManager,
  "ComputeWorkloadManagerMgmtClient",
  "python"
);
