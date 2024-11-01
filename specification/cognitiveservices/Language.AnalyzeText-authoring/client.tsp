import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.Authoring.Text;
using Azure.ClientGenerator.Core;

namespace Language.Authoring.TextClientCustomizations;

@@clientName(TextAnalysisAuthoring.getAssignDeploymentResourcesStatus,
  "GetAssignDeploymentResourcesStatusResult",
  "csharp"
);

@@clientName(TextAnalysisAuthoring.getCopyProjectStatus,
  "GetCopyProjectStatusResult",
  "csharp"
);
