import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientLocation(ComputeDiagnosticBases.get, "SpotPlacementScores");
@@clientLocation(ComputeDiagnosticBases.post, "SpotPlacementScores");
@@clientName(ComputeDiagnosticBases.post::parameters.body,
  "spotPlacementScoresInput"
);
