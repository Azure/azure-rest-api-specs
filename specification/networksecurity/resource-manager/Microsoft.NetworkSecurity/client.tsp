import "./neuroShield/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@client({
  name: "NetworkSecurityManagementClient",
  service: [NeuroShield.Management],
  autoMergeService: true,
})
namespace NetworkSecurityManagementClient {

}

@@clientName(
  NetworkSecurityManagementClient,
  "NetworkSecurityMgmtClient",
  "python"
);

@@clientName(
  NeuroShield.Management.NeuroShieldFindings.listByNeuroShield,
  "GetNeuroShieldFindings",
  "csharp"
);
@@clientName(
  NeuroShield.Management.NeuroShieldMitigations.listByNeuroShield,
  "GetNeuroShieldMitigations",
  "csharp"
);
@@clientName(
  NeuroShield.Management.NeuroShieldOperationStatuses.get,
  "GetNeuroShieldOperationStatus",
  "csharp"
);

@@alternateType(
  NeuroShield.Management.NeuroShieldInventoryUploadRequestMetadata.requestId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldInventoryUploadRequestResult.requestId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldProperties.resourceGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldTargetIdentityId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldProtectedResourceIdentity.userAssignedIdentities,
  Record<NeuroShield.Management.NeuroShieldProtectedResourceUserAssignedIdentity>,
  "csharp"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldResource.eTag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(
  NeuroShield.Management.NeuroShieldResource,
  "NeuroShield",
  "csharp"
);

@@alternateType(
  NeuroShield.Management.NeuroShieldPatch.tags,
  Record<NeuroShield.Management.NeuroShieldTagValue>,
  "go"
);
@@alternateType(
  NeuroShield.Management.NeuroShieldProtectedResourceIdentity.userAssignedIdentities,
  Record<NeuroShield.Management.NeuroShieldProtectedResourceUserAssignedIdentity>,
  "go"
);

@@clientName(
  NeuroShield.Management.NeuroShieldFindingProperties.cveId,
  "CVEID",
  "go"
);
@@clientName(
  NeuroShield.Management.NeuroShieldFindingProperties.virtualMachineArmId,
  "VirtualMachineARMID",
  "go"
);
@@clientName(
  NeuroShield.Management.NeuroShieldMitigationProperties.cveId,
  "CVEID",
  "go"
);
@@clientName(
  NeuroShield.Management.NeuroShieldMitigationProperties.virtualMachineArmId,
  "VirtualMachineARMID",
  "go"
);
