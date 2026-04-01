import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientName(Microsoft.Resources.DeploymentExtended, "Deployment", "java");
@@clientName(Microsoft.Resources.Deployment, "DeploymentParameters", "java");

@@clientLocation(DeploymentExtendeds.getAtScope, "DeploymentsClient", "go");
@@clientLocation(DeploymentExtendeds.checkExistenceAtScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendeds.createOrUpdateAtScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendeds.deleteAtScope, "DeploymentsClient", "go");
@@clientLocation(DeploymentExtendeds.listAtScope, "DeploymentsClient", "go");
@@clientLocation(DeploymentExtendeds.cancelAtScope, "DeploymentsClient", "go");
@@clientLocation(DeploymentExtendeds.validateAtScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendeds.exportTemplateAtScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.getAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.checkExistenceAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.deleteAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.listAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.cancelAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.validateAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedManagementGroup.exportTemplateAtManagementGroupScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.getAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.checkExistenceAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.deleteAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.listAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.cancelAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.whatIfAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.exportTemplateAtSubscriptionScope,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.get,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.checkExistence,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.createOrUpdate,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.delete,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.listByResourceGroup,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.cancel,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.validate,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.whatIf,
  "DeploymentsClient",
  "go"
);
@@clientLocation(DeploymentExtendedOperationGroup.exportTemplate,
  "DeploymentsClient",
  "go"
);

@@clientLocation(DeploymentsOperationGroup.calculateTemplateHash,
  "DeploymentsClient",
  "go"
);
