import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "./routes.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources.DeploymentStacks;

#suppress "deprecated" "Backwards compat with old swagger"
@@flattenProperty(DeploymentStack.properties);

@@clientName(DeploymentStacksAtResourceGroup.createOrUpdate::parameters.resource,
  "deploymentStack"
);
@@clientName(DeploymentStacksAtSubscription.createOrUpdate::parameters.resource,
  "deploymentStack"
);
@@clientName(DeploymentStacksAtManagementGroup.createOrUpdate::parameters.resource,
  "deploymentStack"
);

@@clientName(DeploymentStacksAtResourceGroup.validateStack::parameters.body,
  "deploymentStack"
);
@@clientName(DeploymentStacksAtSubscription.validateStack::parameters.body,
  "deploymentStack"
);
@@clientName(DeploymentStacksAtManagementGroup.validateStack::parameters.body,
  "deploymentStack"
);

// Operation IDs. These overwrites are to preserve the operation IDs before TypeSpec migration.
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.get,
  "DeploymentStacks_GetAtResourceGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.list,
  "DeploymentStacks_ListAtResourceGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.validateStack,
  "DeploymentStacks_ValidateStackAtResourceGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.createOrUpdate,
  "DeploymentStacks_CreateOrUpdateAtResourceGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.delete,
  "DeploymentStacks_DeleteAtResourceGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtResourceGroup.exportTemplate,
  "DeploymentStacks_ExportTemplateAtResourceGroup"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.get,
  "DeploymentStacks_GetAtSubscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.list,
  "DeploymentStacks_ListAtSubscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.validateStack,
  "DeploymentStacks_ValidateStackAtSubscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.createOrUpdate,
  "DeploymentStacks_CreateOrUpdateAtSubscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.delete,
  "DeploymentStacks_DeleteAtSubscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtSubscription.exportTemplate,
  "DeploymentStacks_ExportTemplateAtSubscription"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.get,
  "DeploymentStacks_GetAtManagementGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.list,
  "DeploymentStacks_ListAtManagementGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.validateStack,
  "DeploymentStacks_ValidateStackAtManagementGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.createOrUpdate,
  "DeploymentStacks_CreateOrUpdateAtManagementGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.delete,
  "DeploymentStacks_DeleteAtManagementGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backward compatability"
@@operationId(DeploymentStacksAtManagementGroup.exportTemplate,
  "DeploymentStacks_ExportTemplateAtManagementGroup"
);
