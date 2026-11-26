import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProfessionalService;

@@clientName(
  Microsoft.ProfessionalService,
  "ProfessionalServiceMgmtClient",
  "python"
);

@@clientName(UnsubscribeOptions, "UnsubscribeConfig", "csharp");
@@clientName(
  ProfessionalServicePurchaseValidationRequest,
  "ProfessionalServicePurchaseValidationContent",
  "csharp"
);
