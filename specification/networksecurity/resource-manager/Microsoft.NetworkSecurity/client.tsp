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
