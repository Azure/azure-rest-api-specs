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

@@clientLocation(DeploymentStacksAtResourceGroup.get,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtResourceGroup.list, "listAtResourceGroup");

@@clientLocation(DeploymentStacksAtResourceGroup.list,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtResourceGroup.validateStack,
  "validateStackAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.validateStack,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtResourceGroup.createOrUpdate,
  "createOrUpdateAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.createOrUpdate,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtResourceGroup.delete, "deleteAtResourceGroup");

@@clientLocation(DeploymentStacksAtResourceGroup.delete,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtResourceGroup.exportTemplate,
  "exportTemplateAtResourceGroup"
);

@@clientLocation(DeploymentStacksAtResourceGroup.exportTemplate,
  "DeploymentStacks",
  "!csharp"
);

// Client names and locations for Subscription operations
@@clientName(DeploymentStacksAtSubscription.get, "getAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.get,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtSubscription.list, "listAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.list,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtSubscription.validateStack,
  "validateStackAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.validateStack,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtSubscription.createOrUpdate,
  "createOrUpdateAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.createOrUpdate,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtSubscription.delete, "deleteAtSubscription");

@@clientLocation(DeploymentStacksAtSubscription.delete,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtSubscription.exportTemplate,
  "exportTemplateAtSubscription"
);

@@clientLocation(DeploymentStacksAtSubscription.exportTemplate,
  "DeploymentStacks",
  "!csharp"
);

// Client names and locations for ManagementGroup operations
@@clientName(DeploymentStacksAtManagementGroup.get, "getAtManagementGroup");

@@clientLocation(DeploymentStacksAtManagementGroup.get,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtManagementGroup.list, "listAtManagementGroup");

@@clientLocation(DeploymentStacksAtManagementGroup.list,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtManagementGroup.validateStack,
  "validateStackAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.validateStack,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtManagementGroup.createOrUpdate,
  "createOrUpdateAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.createOrUpdate,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtManagementGroup.delete,
  "deleteAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.delete,
  "DeploymentStacks",
  "!csharp"
);

@@clientName(DeploymentStacksAtManagementGroup.exportTemplate,
  "exportTemplateAtManagementGroup"
);

@@clientLocation(DeploymentStacksAtManagementGroup.exportTemplate,
  "DeploymentStacks",
  "!csharp"
);
