import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientName(DeploymentStacks.createOrUpdateAtResourceGroup::parameters.resource,
  "deploymentStack"
);
@@clientName(DeploymentStacks.validateStackAtResourceGroup::parameters.body,
  "deploymentStack"
);
@@clientName(DeploymentStackOperationGroup.createOrUpdateAtSubscription::parameters.resource,
  "deploymentStack"
);
@@clientName(DeploymentStackOperationGroup.validateStackAtSubscription::parameters.body,
  "deploymentStack"
);
@@clientName(DeploymentStackOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "deploymentStack"
);
@@clientName(DeploymentStackOperationGroup.validateStackAtManagementGroup::parameters.body,
  "deploymentStack"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeploymentStack.properties);
