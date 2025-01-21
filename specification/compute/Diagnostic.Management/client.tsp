import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(ComputeDiagnosticBases.create::parameters.body,
  "runDiskInspectionInput"
);
@@clientName(ComputeDiagnosticBases.register::parameters.body,
  "storageConfigurationInput"
);
@@clientName(SpotPlacementRecommenderOperations.post::parameters.body,
  "spotPlacementRecommenderInput"
);
@@clientName(SpotPlacementScoresOperations.post::parameters.body,
  "spotPlacementScoresInput"
);
