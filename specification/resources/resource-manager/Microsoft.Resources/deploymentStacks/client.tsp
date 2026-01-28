import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources.DeploymentStacks;

@@clientName(DeploymentParameter, "DeploymentParameterItem", "csharp"); // .NET SDK validation: cannot end in "Parameter"
@@clientName(DeploymentStackTemplateDefinition,
  "DeploymentStackTemplateExportResult",
  "csharp"
); // .NET SDK validation: cannot end in "Definition"

@@alternateType(DeploymentStackProperties.template, unknown, "go");
@@alternateType(DeploymentStackProperties.outputs, unknown, "go");
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "go");
@@alternateType(ResourceReference.identifiers, unknown, "go");

// Java SDK: Mitigate breaks from TypeSpec migration
@@alternateType(DeploymentStackProperties.template, unknown, "java");
@@alternateType(DeploymentStackProperties.outputs, unknown, "java");
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "java");
