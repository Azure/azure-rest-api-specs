import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources.DeploymentStacks;

#suppress "deprecated" "Backwards compat with old swagger"
@@flattenProperty(DeploymentStack.properties);
@@clientName(Microsoft.Resources.DeploymentStacks,
  "DeploymentStacksMgmtClient",
  "python"
);

@@clientName(DeploymentParameter, "DeploymentParameterItem", "csharp"); // .NET SDK validation: cannot end in "Parameter"
@@clientName(DeploymentStackTemplateDefinition,
  "DeploymentStackTemplateExportResult",
  "csharp"
); // .NET SDK validation: cannot end in "Definition"
