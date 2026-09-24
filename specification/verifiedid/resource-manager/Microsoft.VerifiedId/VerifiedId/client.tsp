import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.VerifiedId, "VerifiedIdMgmtClient", "python");
@@clientName(Microsoft.VerifiedId.Authority, "VerifiedIdAuthority", "csharp");
@@clientName(
  Microsoft.VerifiedId.ProvisioningState,
  "VerifiedIdAuthorityProvisioningState",
  "csharp"
);
