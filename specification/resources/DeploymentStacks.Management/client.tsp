import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources.DeploymentStacks;

@@flattenProperty(DeploymentStack.properties);
@@clientName(Microsoft.Resources.DeploymentStacks, "DeploymentStacksMgmtClient", "python");

@@clientName(DeploymentParameter, "DeploymentParameterContent"); // .NET SDK validation: cannot end in "Parameter"
@@clientName(DeploymentStackTemplateDefinition, "DeploymentStackTemplateExportResult"); // .NET SDK validation: cannot end in "Definition"