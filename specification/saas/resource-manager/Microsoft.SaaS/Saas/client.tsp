import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SaaS;

@@clientName(UnsubscribeOptions, "UnsubscribeConfig", "csharp");
@@clientName(
  SaasPurchaseValidationRequest,
  "SaasPurchaseValidationContent",
  "csharp"
);
