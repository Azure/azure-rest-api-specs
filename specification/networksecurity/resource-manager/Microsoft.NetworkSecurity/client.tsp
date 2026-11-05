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
