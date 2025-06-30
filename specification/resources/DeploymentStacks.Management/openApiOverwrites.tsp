import "@typespec/openapi";
import "./routes.tsp";

using TypeSpec.OpenAPI;
using Microsoft.Resources.DeploymentStacks;

// Operation IDs. These overwrites are to preserve the operation IDs before TypeSpec migration.
@@operationId(DeploymentStacksAtResourceGroup.get, "DeploymentStacks_GetAtResourceGroup");
@@operationId(DeploymentStacksAtResourceGroup.list, "DeploymentStacks_ListAtResourceGroup");
@@operationId(DeploymentStacksAtResourceGroup.validateStack, "DeploymentStacks_ValidateStackAtResourceGroup");
@@operationId(DeploymentStacksAtResourceGroup.createOrUpdate, "DeploymentStacks_CreateOrUpdateAtResourceGroup");
@@operationId(DeploymentStacksAtResourceGroup.delete, "DeploymentStacks_DeleteAtResourceGroup");
@@operationId(DeploymentStacksAtResourceGroup.exportTemplate, "DeploymentStacks_ExportTemplateAtResourceGroup");

@@operationId(DeploymentStacksAtSubscription.get, "DeploymentStacks_GetAtSubscription");
@@operationId(DeploymentStacksAtSubscription.list, "DeploymentStacks_ListAtSubscription");
@@operationId(DeploymentStacksAtSubscription.validateStack, "DeploymentStacks_ValidateStackAtSubscription");
@@operationId(DeploymentStacksAtSubscription.createOrUpdate, "DeploymentStacks_CreateOrUpdateAtSubscription");
@@operationId(DeploymentStacksAtSubscription.delete, "DeploymentStacks_DeleteAtSubscription");
@@operationId(DeploymentStacksAtSubscription.exportTemplate, "DeploymentStacks_ExportTemplateAtSubscription");

@@operationId(DeploymentStacksAtManagementGroup.get, "DeploymentStacks_GetAtManagementGroup");
@@operationId(DeploymentStacksAtManagementGroup.list, "DeploymentStacks_ListAtManagementGroup");
@@operationId(DeploymentStacksAtManagementGroup.validateStack, "DeploymentStacks_ValidateStackAtManagementGroup");
@@operationId(DeploymentStacksAtManagementGroup.createOrUpdate, "DeploymentStacks_CreateOrUpdateAtManagementGroup");
@@operationId(DeploymentStacksAtManagementGroup.delete, "DeploymentStacks_DeleteAtManagementGroup");
@@operationId(DeploymentStacksAtManagementGroup.exportTemplate, "DeploymentStacks_ExportTemplateAtManagementGroup");
