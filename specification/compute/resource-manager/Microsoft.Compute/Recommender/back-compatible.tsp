import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientLocation(SpotPlacementScores.get, "SpotPlacementScores");
@@clientLocation(SpotPlacementScores.post, "SpotPlacementScores");
@@clientName(
  SpotPlacementScores.post::parameters.body,
  "spotPlacementScoresInput"
);
@@clientLocation(ComputePlacementScores.get, "ComputePlacementScores");
@@clientLocation(ComputePlacementScores.post, "ComputePlacementScores");
@@clientName(
  ComputePlacementScores.post::parameters.body,
  "computePlacementScoresInput"
);
@@clientLocation(SkuMixPlacementScores.get, "SkuMixPlacementScores");
@@clientLocation(SkuMixPlacementScores.post, "SkuMixPlacementScores");
@@clientName(
  SkuMixPlacementScores.post::parameters.body,
  "skuMixPlacementRequest"
);
