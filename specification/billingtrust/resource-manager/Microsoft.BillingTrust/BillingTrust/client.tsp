import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.BillingTrust;
using Azure.ClientGenerator.Core;

@@clientName(ProvisioningState, "BillingTrustProvisioningState", "csharp");
@@clientName(Microsoft.BillingTrust, "BillingTrustMgmtClient", "python");
@@clientName(Assessment, "BillingTrustAssessment", "csharp");
@@clientName(Rule, "BillingTrustRule", "csharp");
@@clientName(
  GenerateUploadTokenResponse,
  "GenerateUploadTokenResult",
  "csharp"
);
