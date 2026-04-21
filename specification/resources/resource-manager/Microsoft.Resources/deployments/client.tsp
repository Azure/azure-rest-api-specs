import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientName(Microsoft.Resources, "DeploymentsMgmtClient", "python");

// Fix AZC naming violations for C#
@@clientName(DeploymentOperation, "ArmDeploymentOperation", "csharp");
@@clientName(DeploymentExtensionDefinition, "ArmDeploymentExtensionDefinition", "csharp");
@@clientName(DeploymentParameter, "DeploymentParameterValue", "csharp");

// C# SDK: Use the generic at-scope interface (DeploymentExtendeds) for all scopes.
// Suppress per-scope @armResourceOperations interfaces from C# to eliminate duplicate
// ArmClient extension methods (CS0111). Mirrors the pattern in deploymentStacks/client.tsp.

// Resource-group scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(DeploymentExtendedOperationGroup.get, "!csharp");
@@scope(DeploymentExtendedOperationGroup.checkExistence, "!csharp");
@@scope(DeploymentExtendedOperationGroup.createOrUpdate, "!csharp");
@@scope(DeploymentExtendedOperationGroup.delete, "!csharp");
@@scope(DeploymentExtendedOperationGroup.listByResourceGroup, "!csharp");
@@scope(DeploymentExtendedOperationGroup.cancel, "!csharp");
@@scope(DeploymentExtendedOperationGroup.validate, "!csharp");
@@scope(DeploymentExtendedOperationGroup.whatIf, "!csharp");
@@scope(DeploymentExtendedOperationGroup.exportTemplate, "!csharp");

// Tenant scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(Deployments.getAtTenantScope, "!csharp");
@@scope(Deployments.checkExistenceAtTenantScope, "!csharp");
@@scope(Deployments.createOrUpdateAtTenantScope, "!csharp");
@@scope(Deployments.deleteAtTenantScope, "!csharp");
@@scope(Deployments.cancelAtTenantScope, "!csharp");
@@scope(Deployments.validateAtTenantScope, "!csharp");
@@scope(Deployments.whatIfAtTenantScope, "!csharp");
@@scope(Deployments.exportTemplateAtTenantScope, "!csharp");
@@scope(Deployments.deploymentOperationsGetAtTenantScope, "!csharp");
@@scope(Deployments.list, "!csharp");
@@scope(Deployments.listAtTenantScope, "!csharp");

// Management group scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(DeploymentExtendedManagementGroup.getAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.checkExistenceAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.deleteAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.listAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.cancelAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.validateAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.exportTemplateAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.deploymentOperationsGetAtManagementGroupScope, "!csharp");
@@scope(DeploymentExtendedManagementGroup.deploymentOperationsListAtManagementGroupScope, "!csharp");

// Subscription scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(DeploymentExtendedSubscriptionGroup.getAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.checkExistenceAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.deleteAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.listAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.cancelAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.whatIfAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.exportTemplateAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.deploymentOperationsGetAtSubscriptionScope, "!csharp");
@@scope(DeploymentExtendedSubscriptionGroup.deploymentOperationsListAtSubscriptionScope, "!csharp");
