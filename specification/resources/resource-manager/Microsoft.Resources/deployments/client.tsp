import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Resources;

@@clientName(Microsoft.Resources, "DeploymentsMgmtClient", "python");

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Deployments, "ArmDeployments", "csharp"); // Avoid "Deployments" name conflict with namespace in C#
@@clientName(ResourceReference, "ArmResourceReference", "csharp");
@@clientName(
  DeploymentExtensionDefinition,
  "ArmDeploymentExtensionDefinition",
  "csharp"
);
@@clientName(DeploymentParameter, "ArmDeploymentParameterValue", "csharp");
@@clientName(Deployment, "ArmDeploymentContent", "csharp");
@@alternateType(
  Deployment.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Deployment.location, azureLocation, "csharp");
@@clientName(DeploymentExtended, "ArmDeployment", "csharp");
@@clientName(
  DeploymentPropertiesExtended,
  "ArmDeploymentPropertiesExtended",
  "csharp"
);
@@clientName(
  DeploymentPropertiesExtended.onErrorDeployment,
  "ErrorDeployment",
  "csharp"
);
@@clientName(
  DeploymentPropertiesExtended.outputResources,
  "OutputResourceDetails",
  "csharp"
);
@@clientName(
  DeploymentPropertiesExtended.validatedResources,
  "ValidatedResourceDetails",
  "csharp"
);
@@alternateType(DeploymentExtended.location, azureLocation, "csharp");
@@clientName(DeploymentMode, "ArmDeploymentMode", "csharp");
@@clientName(DeploymentExportResult, "ArmDeploymentExportResult", "csharp");
@@clientName(DeploymentExtendedFilter, "ArmDeploymentExtendedFilter", "csharp");
@@clientName(DeploymentListResult, "ArmDeploymentListResult", "csharp");
@@clientName(DeploymentExtendedFilter, "ArmDeploymentExtendedFilter", "csharp");
@@clientName(DeploymentOperation, "ArmDeploymentOperation", "csharp");
@@clientName(
  DeploymentOperationProperties,
  "ArmDeploymentOperationProperties",
  "csharp"
);
@@alternateType(DeploymentOperationProperties.duration, duration, "csharp");
@@clientName(ProvisioningOperation, "ProvisioningOperationKind", "csharp");
@@clientName(
  DeploymentOperationsListResult,
  "ArmDeploymentOperationsListResult",
  "csharp"
);
@@clientName(DeploymentValidateResult, "ArmDeploymentValidateResult", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DeploymentValidateResult,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
@@clientName(DeploymentWhatIf, "ArmDeploymentWhatIfContent", "csharp");
@@alternateType(DeploymentWhatIf.location, azureLocation, "csharp");
@@clientName(DeploymentWhatIfSettings, "ArmDeploymentWhatIfSettings", "csharp");
@@clientName(
  DeploymentWhatIfProperties,
  "ArmDeploymentWhatIfProperties",
  "csharp"
);
@@clientName(DeploymentProperties, "ArmDeploymentProperties", "csharp");
@@clientName(DeploymentProperties.parameters, "DeploymentParameters", "csharp");
@@clientName(
  DeploymentProperties.onErrorDeployment,
  "ErrorDeployment",
  "csharp"
);
@@clientName(
  ExpressionEvaluationOptions.scope,
  "ExpressionEvaluationScope",
  "csharp"
);
@@clientName(Dependency, "ArmDependency", "csharp");
@@alternateType(Dependency.resourceType, armResourceType, "csharp");
@@clientName(BasicDependency, "BasicArmDependency", "csharp");
@@alternateType(BasicDependency.resourceType, armResourceType, "csharp");
@@alternateType(TargetResource.resourceType, armResourceType, "csharp");
@@clientName(ProvisioningState, "ResourcesProvisioningState", "csharp");
@@alternateType(DeploymentPropertiesExtended.duration, duration, "csharp");
@@clientName(OnErrorDeployment, "ErrorDeployment", "csharp");
@@clientName(OnErrorDeployment.type, "DeploymentType", "csharp");
@@clientName(OnErrorDeploymentType, "ErrorDeploymentType", "csharp");
@@clientName(OnErrorDeploymentExtended, "ErrorDeploymentExtended", "csharp");
@@clientName(OnErrorDeploymentExtended.type, "DeploymentType", "csharp");
@@clientName(
  ExpressionEvaluationOptionsScopeType,
  "ExpressionEvaluationScope",
  "csharp"
);
@@clientName(ParametersLink, "ArmDeploymentParametersLink", "csharp");
@@alternateType(ParametersLink.uri, url, "csharp");
@@clientName(TemplateLink, "ArmDeploymentTemplateLink", "csharp");
@@alternateType(TemplateLink.uri, url, "csharp");
@@clientName(ChangeType, "WhatIfChangeType", "csharp");
@@clientName(PropertyChangeType, "WhatIfPropertyChangeType", "csharp");
@@alternateType(ResourceReference.id, armResourceIdentifier, "csharp");
@@clientName(DeploymentExternalInput, "ArmDeploymentExternalInput", "csharp");
@@clientName(
  DeploymentExternalInputDefinition,
  "ArmDeploymentExternalInputDefinition",
  "csharp"
);
@@clientName(
  DeploymentExtensionConfigItem,
  "ArmDeploymentExtensionConfigItem",
  "csharp"
);
@@clientName(
  DeploymentExtensionConfigItem.type,
  "ExtensionConfigPropertyType",
  "csharp"
);
@@clientName(Deployments.cancelAtScope, "Cancel", "csharp");
@@clientName(
  Deployments.deploymentOperationsGetAtScope,
  "GetDeploymentOperation",
  "csharp"
);
@@clientName(
  Deployments.deploymentOperationsListAtScope,
  "GetDeploymentOperations",
  "csharp"
);
@@clientName(Deployments.exportTemplateAtScope, "ExportTemplate", "csharp");
@@clientName(Deployments.validateAtScope, "Validate", "csharp");
@@clientName(Deployments.checkExistenceAtScope, "CheckExistence", "csharp");
@@alternateType(KeyVaultReference.id, armResourceIdentifier, "csharp");
@@clientName(
  Azure.ResourceManager.Foundations.ErrorAdditionalInfo.type,
  "ErrorAdditionalInfoType",
  "csharp"
);
@@clientName(
  DeploymentsOperationGroup.calculateTemplateHash,
  "CalculateDeploymentTemplateHash",
  "csharp"
);

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
@@scope(DeploymentsExtendedTenant.getAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.checkExistenceAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.createOrUpdateAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.deleteAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.cancelAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.validateAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.whatIfAtTenantScope, "!csharp");
@@scope(DeploymentsExtendedTenant.exportTemplateAtTenantScope, "!csharp");
@@scope(
  DeploymentsExtendedTenant.deploymentOperationsGetAtTenantScope,
  "!csharp"
);
@@scope(DeploymentsExtendedTenant.list, "!csharp");
@@scope(DeploymentsExtendedTenant.listAtTenantScope, "!csharp");

// Management group scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(DeploymentExtendedManagementGroup.getAtManagementGroupScope, "!csharp");
@@scope(
  DeploymentExtendedManagementGroup.checkExistenceAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.deleteAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.listAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.cancelAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.validateAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.exportTemplateAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.deploymentOperationsGetAtManagementGroupScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedManagementGroup.deploymentOperationsListAtManagementGroupScope,
  "!csharp"
);

// Subscription scope — covered by DeploymentExtendeds with Extension.ScopeParameter
@@scope(DeploymentExtendedSubscriptionGroup.getAtSubscriptionScope, "!csharp");
@@scope(
  DeploymentExtendedSubscriptionGroup.checkExistenceAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.deleteAtSubscriptionScope,
  "!csharp"
);
@@scope(DeploymentExtendedSubscriptionGroup.listAtSubscriptionScope, "!csharp");
@@scope(
  DeploymentExtendedSubscriptionGroup.cancelAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.exportTemplateAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.deploymentOperationsGetAtSubscriptionScope,
  "!csharp"
);
@@scope(
  DeploymentExtendedSubscriptionGroup.deploymentOperationsListAtSubscriptionScope,
  "!csharp"
);

@@scope(DeploymentOperationsOperationGroup.get, "!csharp");
@@scope(DeploymentOperationsOperationGroup.list, "!csharp");

@@scope(Deployments.checkExistenceAtScope, "!csharp"); // Remove this setting once https://github.com/Azure/azure-sdk-for-net/issues/58746 get fixed

@@apiVersion(ProviderResourceType.apiVersions, false);
@@apiVersion(AliasPath.apiVersions, false);
