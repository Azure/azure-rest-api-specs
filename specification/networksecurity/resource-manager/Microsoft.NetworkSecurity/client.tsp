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
