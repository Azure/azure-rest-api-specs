import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WhatIfOperationResult.properties);

@@clientName(DeploymentsOperationGroup.calculateTemplateHash::parameters.body,
  "template"
);

@@clientLocation(DeploymentExtendeds.getAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.checkExistenceAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.createOrUpdateAtScope, Deployments);
@@clientName(DeploymentExtendeds.createOrUpdateAtScope::parameters.resource,
  "parameters"
);
@@clientLocation(DeploymentExtendeds.deleteAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.listAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.cancelAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.validateAtScope, Deployments);
@@clientName(DeploymentExtendeds.validateAtScope::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendeds.exportTemplateAtScope, Deployments);
@@clientLocation(DeploymentExtendeds.deploymentOperationsGetAtScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendeds.deploymentOperationsGetAtScope, "GetAtScope");
@@clientLocation(DeploymentExtendeds.deploymentOperationsListAtScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendeds.deploymentOperationsListAtScope,
  "ListAtScope"
);
@@clientName(Deployments.createOrUpdateAtTenantScope::parameters.resource,
  "parameters"
);
@@clientName(Deployments.validateAtTenantScope::parameters.body, "parameters");
@@clientName(Deployments.whatIfAtTenantScope::parameters.body, "parameters");
@@clientLocation(Deployments.deploymentOperationsGetAtTenantScope,
  "DeploymentOperations"
);
@@clientName(Deployments.deploymentOperationsGetAtTenantScope,
  "GetAtTenantScope"
);
@@clientLocation(Deployments.listAtTenantScope, "DeploymentOperations");
@@clientLocation(DeploymentExtendedManagementGroup.getAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.checkExistenceAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope,
  Deployments
);
@@clientName(DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope::parameters.resource,
  "parameters"
);
@@clientLocation(DeploymentExtendedManagementGroup.deleteAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.listAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.cancelAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.validateAtManagementGroupScope,
  Deployments
);
@@clientName(DeploymentExtendedManagementGroup.validateAtManagementGroupScope::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope,
  Deployments
);
@@clientName(DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedManagementGroup.exportTemplateAtManagementGroupScope,
  Deployments
);
@@clientLocation(DeploymentExtendedManagementGroup.deploymentOperationsGetAtManagementGroupScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendedManagementGroup.deploymentOperationsGetAtManagementGroupScope,
  "GetAtManagementGroupScope"
);
@@clientLocation(DeploymentExtendedManagementGroup.deploymentOperationsListAtManagementGroupScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendedManagementGroup.deploymentOperationsListAtManagementGroupScope,
  "ListAtManagementGroupScope"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.getAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.checkExistenceAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope,
  Deployments
);
@@clientName(DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope::parameters.resource,
  "parameters"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.deleteAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.listAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.cancelAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope,
  Deployments
);
@@clientName(DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.whatIfAtSubscriptionScope,
  Deployments
);
@@clientName(DeploymentExtendedSubscriptionGroup.whatIfAtSubscriptionScope::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.exportTemplateAtSubscriptionScope,
  Deployments
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.deploymentOperationsGetAtSubscriptionScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendedSubscriptionGroup.deploymentOperationsGetAtSubscriptionScope,
  "GetAtSubscriptionScope"
);
@@clientLocation(DeploymentExtendedSubscriptionGroup.deploymentOperationsListAtSubscriptionScope,
  "DeploymentOperations"
);
@@clientName(DeploymentExtendedSubscriptionGroup.deploymentOperationsListAtSubscriptionScope,
  "ListAtSubscriptionScope"
);
@@clientLocation(DeploymentExtendedOperationGroup.get, Deployments);
@@clientLocation(DeploymentExtendedOperationGroup.checkExistence, Deployments);
@@clientLocation(DeploymentExtendedOperationGroup.createOrUpdate, Deployments);
@@clientName(DeploymentExtendedOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DeploymentExtendedOperationGroup.delete, Deployments);
@@clientLocation(DeploymentExtendedOperationGroup.listByResourceGroup,
  Deployments
);
@@clientLocation(DeploymentExtendedOperationGroup.cancel, Deployments);
@@clientLocation(DeploymentExtendedOperationGroup.validate, Deployments);
@@clientName(DeploymentExtendedOperationGroup.validate::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedOperationGroup.whatIf, Deployments);
@@clientName(DeploymentExtendedOperationGroup.whatIf::parameters.body,
  "parameters"
);
@@clientLocation(DeploymentExtendedOperationGroup.exportTemplate, Deployments);

@@clientLocation(DeploymentsOperationGroup.calculateTemplateHash, Deployments);

@@clientLocation(DeploymentOperationsOperationGroup.get,
  "DeploymentOperations"
);
@@clientLocation(DeploymentOperationsOperationGroup.list,
  "DeploymentOperations"
);
