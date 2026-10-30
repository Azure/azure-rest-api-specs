import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Sovereign, "SovereignMgmtClient", "python");

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "SovereignCheckNameAvailabilityRequestContent",
  "csharp"
);
