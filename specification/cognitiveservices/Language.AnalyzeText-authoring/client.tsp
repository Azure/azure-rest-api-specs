import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.Authoring.Analyzetext;
using Azure.ClientGenerator.Core;

namespace Language.Authoring.AnalyzetextClientCustomizations;

@@clientName(TextAnalysisAuthoring.getAssignDeploymentResourcesStatus,
  "GetAssignDeploymentResourcesStatusResult",
  "csharp"
);

@@clientName(TextAnalysisAuthoring.getCopyProjectStatus,
  "GetCopyProjectStatusResult",
  "csharp"
);
