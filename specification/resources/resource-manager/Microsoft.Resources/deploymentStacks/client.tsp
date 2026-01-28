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

/**
 * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
 */
union UnmanageActionManagementGroupMode {
  string,

  /** Delete the specified resources from Azure */
  Delete: "delete",

  /** Keep the specified resources in Azure */
  Detach: "detach",
}

/**
 * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
 */
union UnmanageActionResourceMode {
  string,

  /** Delete the specified resources from Azure */
  Delete: "delete",

  /** Keep the specified resources in Azure */
  Detach: "detach",
}

/**
 * Specifies an action for a newly unmanaged resource. Delete will attempt to delete the resource from Azure. Detach will leave the resource in it's current state.
 */
union UnmanageActionResourceGroupMode {
  string,

  /** Delete the specified resources from Azure */
  Delete: "delete",

  /** Keep the specified resources in Azure */
  Detach: "detach",
}

@@alternateType(ActionOnUnmanageDeleteParameters.unmanageActionResources,
  UnmanageActionResourceMode,
  "javascript"
);
@@alternateType(ActionOnUnmanageDeleteParameters.unmanageActionResourceGroups,
  UnmanageActionResourceGroupMode,
  "javascript"
);
@@alternateType(ActionOnUnmanageDeleteParameters.unmanageActionManagementGroups,
  UnmanageActionManagementGroupMode,
  "javascript"
);
// Java SDK: Mitigate breaks from TypeSpec migration
@@alternateType(DeploymentStackProperties.template, unknown, "java");
@@alternateType(DeploymentStackProperties.outputs, unknown, "java");
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "java");
