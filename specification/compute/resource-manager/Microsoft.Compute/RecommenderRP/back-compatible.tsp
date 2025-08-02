import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(ComputeDiagnosticBases.post::parameters.body,
  "spotPlacementScoresInput"
);
@@clientName(SpotPlacementScoresResponse,
  "SpotPlacementScoresResult",
  "csharp"
);
