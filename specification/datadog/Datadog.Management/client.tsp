import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Datadog;

@@clientName(Microsoft.Datadog, "MicrosoftDatadogClient", "javascript");
@@clientName(BillingInfoResponse, "BillingInfoResult", "csharp");
@@clientName(CreateResourceSupportedResponse,
  "CreateResourceSupportedResult",
  "csharp"
);
