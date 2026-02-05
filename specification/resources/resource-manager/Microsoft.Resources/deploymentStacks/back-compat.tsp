import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "./routes.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.Resources.DeploymentStacks;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backwards compat with old swagger"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeploymentStack.properties,
  "!java, !javascript"
);

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

// Client names and locations for ResourceGroup operations
@@clientName(DeploymentStacksAtResourceGroup.get, "getAtResourceGroup");

@@clientLocation(DeploymentStacksAtResourceGroup.get, "DeploymentStacks");

@@clientName(DeploymentStacksAtResourceGroup.list, "listAtResourceGroup");

@@clientLocation(DeploymentStacksAtResourceGroup.list, "DeploymentStacks");

@@clientName(DeploymentStacksAtResourceGroup.validateStack,
  "validateStackAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.validateStack,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtResourceGroup.createOrUpdate,
  "createOrUpdateAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.createOrUpdate,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtResourceGroup.delete, "deleteAtResourceGroup");

@@clientLocation(DeploymentStacksAtResourceGroup.delete, "DeploymentStacks");

@@clientName(DeploymentStacksAtResourceGroup.exportTemplate,
  "exportTemplateAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.exportTemplate,
  "DeploymentStacks"
);

// Client names and locations for Subscription operations
@@clientName(DeploymentStacksAtSubscription.get, "getAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.get, "DeploymentStacks");

@@clientName(DeploymentStacksAtSubscription.list, "listAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.list, "DeploymentStacks");

@@clientName(DeploymentStacksAtSubscription.validateStack,
  "validateStackAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.validateStack,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtSubscription.createOrUpdate,
  "createOrUpdateAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.createOrUpdate,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtSubscription.delete, "deleteAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.delete, "DeploymentStacks");

@@clientName(DeploymentStacksAtSubscription.exportTemplate,
  "exportTemplateAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.exportTemplate,
  "DeploymentStacks"
);

// Client names and locations for ManagementGroup operations
@@clientName(DeploymentStacksAtManagementGroup.get, "getAtManagementGroup");

@@clientLocation(DeploymentStacksAtManagementGroup.get, "DeploymentStacks");

@@clientName(DeploymentStacksAtManagementGroup.list, "listAtManagementGroup");

@@clientLocation(DeploymentStacksAtManagementGroup.list, "DeploymentStacks");

@@clientName(DeploymentStacksAtManagementGroup.validateStack,
  "validateStackAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.validateStack,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtManagementGroup.createOrUpdate,
  "createOrUpdateAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.createOrUpdate,
  "DeploymentStacks"
);

@@clientName(DeploymentStacksAtManagementGroup.delete,
  "deleteAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.delete, "DeploymentStacks");

@@clientName(DeploymentStacksAtManagementGroup.exportTemplate,
  "exportTemplateAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.exportTemplate,
  "DeploymentStacks"
);
