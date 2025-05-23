import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Datadog;

@@clientName(BillingInfoResponse, "BillingInfoResult", "csharp");
@@clientName(CreateResourceSupportedResponse,
  "CreateResourceSupportedResult",
  "csharp"
);
