import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(NeuroShield.Management, "NeuroShieldManagementClient", "python");
@@clientName(
  NeuroShield.Management,
  "NeuroShieldManagementClient",
  "javascript"
);
@@clientName(NeuroShield.Management, "NetworkSecurityManagementClient", "java");

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
