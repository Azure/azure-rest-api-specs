import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.CognitiveServices;
using Azure.ResourceManager;

@@clientName(Microsoft.CognitiveServices,
  "CognitiveServicesManagementClient",
  "javascript,python"
);

@@clientName(AgentProtocol.A2A, "A2_A", "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ConnectionsListParameters.includeAll,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentDeploymentsListParameters.count,
  30,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentDeploymentsListParameters.orderByAsc,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentApplicationsListParameters.count,
  30,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentApplicationsListParameters.orderByAsc,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op checkDomainAvailabilityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  subdomainName: string,
  type: string,
  kind?: string,
): DomainAvailability;
@@override(checkDomainAvailability,
  checkDomainAvailabilityCustom,
  "javascript"
);
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op checkSkuAvailabilityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  location: string,
  skus: string[],
  type: string,
  kind: string,
): SkuAvailabilityListResult;
@@override(checkSkuAvailability, checkSkuAvailabilityCustom, "javascript");
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op calculateModelCapacityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  `model`?: DeploymentModel,
  skuName?: string,

  @identifiers(#[])
  workloads?: ModelCapacityCalculatorWorkload[],
): CalculateModelCapacityResult;

@@override(calculateModelCapacity, calculateModelCapacityCustom, "javascript");

@@clientName(Microsoft.CognitiveServices.PATAuthTypeConnectionProperties,
  "PatAuthTypeConnectionProperties",
  "java"
);
@@clientName(Microsoft.CognitiveServices.SASAuthTypeConnectionProperties,
  "SasAuthTypeConnectionProperties",
  "java"
);
@@clientName(Microsoft.CognitiveServices.AADAuthTypeConnectionProperties,
  "AadAuthTypeConnectionProperties",
  "java"
);

@@clientLocation(checkDomainAvailability, "ManagementClient", "go");
@@clientLocation(checkSkuAvailability, "ManagementClient", "go");
@@clientLocation(calculateModelCapacity, "ManagementClient", "go");

// C# fix: rename Models operation group to avoid namespace collision
@@clientLocation(ModelsOperationGroup.list, "CognitiveServicesModels", "csharp");
@@clientName(ModelsOperationGroup.list, "GetModels", "csharp");

// C# fix: move CommitmentPlanOperationGroup operations to avoid duplicates with CommitmentPlans ARM resource
@@clientLocation(
  CommitmentPlanOperationGroup.getPlan,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);
@@clientLocation(
  CommitmentPlanOperationGroup.createOrUpdatePlan,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);
@@clientLocation(
  CommitmentPlanOperationGroup.updatePlan,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);
@@clientLocation(
  CommitmentPlanOperationGroup.deletePlan,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);
@@clientLocation(
  CommitmentPlanOperationGroup.listPlansByResourceGroup,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);
@@clientLocation(
  CommitmentPlanOperationGroup.listPlansBySubscription,
  "CognitiveServicesCommitmentPlanOperations",
  "csharp"
);

// C# fix: rename subscription-level list operations to avoid GetAll collisions
@@clientLocation(ResourceSkusOperationGroup.list, "CognitiveServicesResourceSkus", "csharp");
@@clientName(ResourceSkusOperationGroup.list, "GetResourceSkus", "csharp");
@@clientLocation(UsagesOperationGroup.list, "CognitiveServicesUsages", "csharp");
@@clientLocation(
  CommitmentTiersOperationGroup.list,
  "CognitiveServicesCommitmentTiers",
  "csharp"
);
@@clientName(CommitmentTiersOperationGroup.list, "GetCommitmentTiers", "csharp");
@@clientLocation(
  LocationBasedModelCapacitiesOperationGroup.list,
  "CognitiveServicesLocationBasedModelCapacities",
  "csharp"
);
@@clientLocation(
  ModelCapacitiesOperationGroup.list,
  "CognitiveServicesModelCapacities",
  "csharp"
);

// C# resource renames (model names for Data classes)
@@clientName(Microsoft.CognitiveServices.Account,
  "CognitiveServicesAccount",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Deployment,
  "CognitiveServicesAccountDeployment",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.EncryptionScope,
  "CognitiveServicesEncryptionScope",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PrivateEndpointConnection,
  "CognitiveServicesPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Project,
  "CognitiveServicesProject",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CapabilityHost,
  "CognitiveServicesCapabilityHost",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionPropertiesV2BasicResource,
  "CognitiveServicesConnection",
  "csharp"
);

// C# collection renames
@@clientName(Microsoft.CognitiveServices.CommitmentPlans,
  "CognitiveServicesCommitmentPlan",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionPropertiesV2BasicResources,
  "CognitiveServicesConnection",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeletedAccounts,
  "CognitiveServicesDeletedAccount",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProjectCapabilityHosts,
  "CognitiveServicesProjectCapabilityHost",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProjectConnections,
  "CognitiveServicesProjectConnection",
  "csharp"
);

// C# model/enum renames
@@clientName(Microsoft.CognitiveServices.AADAuthTypeConnectionProperties,
  "AadAuthTypeConnectionProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.AccountModel,
  "CognitiveServicesAccountModel",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.AccountProperties,
  "CognitiveServicesAccountProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.AccountSku,
  "CognitiveServicesAccountSku",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ApiKeys,
  "ServiceAccountApiKeys",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ApiProperties,
  "ServiceAccountApiProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ByPassSelection,
  "TrustedServicesByPassSelection",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CalculateModelCapacityParameter,
  "CalculateModelCapacityContent",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CallRateLimit,
  "ServiceAccountCallRateLimit",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CapabilityHostProperties,
  "CognitiveServicesCapabilityHostProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CapacityConfig,
  "CognitiveServicesCapacityConfig",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CheckDomainAvailabilityParameter,
  "CognitiveServicesDomainAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.CheckSkuAvailabilityParameter,
  "CognitiveServicesSkuAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionAccessKey,
  "CognitiveServicesConnectionAccessKey",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionCategory,
  "CognitiveServicesConnectionCategory",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionGroup,
  "CognitiveServicesConnectionGroup",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionManagedIdentity,
  "CognitiveServicesConnectionManagedIdentity",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionOAuth2,
  "CognitiveServicesConnectionOAuth2",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionPropertiesV2,
  "CognitiveServicesConnectionProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionServicePrincipal,
  "CognitiveServicesConnectionServicePrincipal",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionUpdateContent,
  "CognitiveServicesConnectionPatch",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ConnectionUsernamePassword,
  "CognitiveServicesConnectionUsernamePassword",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ContentLevel,
  "RaiPolicyContentLevel",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeploymentModel,
  "CognitiveServicesAccountDeploymentModel",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeploymentProperties,
  "CognitiveServicesAccountDeploymentProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeploymentProvisioningState,
  "CognitiveServicesAccountDeploymentProvisioningState",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeploymentScaleSettings,
  "CognitiveServicesAccountDeploymentScaleSettings",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DeploymentScaleType,
  "CognitiveServicesAccountDeploymentScaleType",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.DomainAvailability,
  "CognitiveServicesDomainAvailabilityList",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Encryption,
  "ServiceAccountEncryptionProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.EncryptionScopeProperties,
  "CognitiveServicesEncryptionScopeProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.HostingModel,
  "ServiceAccountHostingModel",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.IpRule,
  "CognitiveServicesIPRule",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.KeyName,
  "ServiceAccountKeyName",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.KeySource,
  "ServiceAccountEncryptionKeySource",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.KeyVaultProperties,
  "CognitiveServicesKeyVaultProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.MetricName,
  "ServiceAccountUsageMetricName",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Model,
  "CognitiveServicesModel",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ModelDeprecationInfo,
  "ServiceAccountModelDeprecationInfo",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ModelSku,
  "CognitiveServicesModelSku",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.MultiRegionSettings,
  "CognitiveServicesMultiRegionSettings",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.NetworkInjection,
  "AIFoundryNetworkInjection",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.NetworkRuleAction,
  "CognitiveServicesNetworkRuleAction",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.NetworkRuleSet,
  "CognitiveServicesNetworkRuleSet",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.NetworkSecurityPerimeter,
  "CognitiveServicesNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PATAuthTypeConnectionProperties,
  "PatAuthTypeConnectionProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PatchResourceTags,
  "CognitiveServicesPatchResourceTags",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PrivateLinkResource,
  "CognitiveServicesPrivateLinkResource",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PrivateLinkResourceProperties,
  "CognitiveServicesPrivateLinkResourceProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProjectProperties,
  "CognitiveServicesProjectProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProvisioningIssue,
  "NetworkSecurityPerimeterProvisioningIssue",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProvisioningIssueProperties,
  "NetworkSecurityPerimeterProvisioningIssueProperties",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ProvisioningState,
  "ServiceAccountProvisioningState",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PublicNetworkAccess,
  "ServiceAccountPublicNetworkAccess",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.QuotaLimit,
  "ServiceAccountQuotaLimit",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.QuotaUsageStatus,
  "ServiceAccountQuotaUsageStatus",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.RaiBlocklistItemBulkRequest,
  "RaiBlocklistItemBulkContent",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.RegionSetting,
  "CognitiveServicesRegionSetting",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.RegenerateKeyParameters,
  "RegenerateServiceAccountKeyContent",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.RequestMatchPattern,
  "ServiceAccountThrottlingMatchPattern",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceBase,
  "CognitiveServicesResourceBase",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceSku,
  "AvailableCognitiveServicesSku",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceSkuRestrictionInfo,
  "CognitiveServicesSkuRestrictionInfo",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceSkuRestrictions,
  "CognitiveServicesSkuRestrictions",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceSkuRestrictionsReasonCode,
  "CognitiveServicesSkuRestrictionReasonCode",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ResourceSkuRestrictionsType,
  "CognitiveServicesSkuRestrictionsType",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.RoutingMethods,
  "CognitiveServicesRoutingMethod",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ScenarioType,
  "AIFoundryNetworkInjectionScenarioType",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.SkuAvailability,
  "CognitiveServicesSkuAvailabilityList",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.SkuCapability,
  "CognitiveServicesSkuCapability",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.SkuChangeInfo,
  "CognitiveServicesSkuChangeInfo",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.SkuResource,
  "CognitiveServicesResourceSku",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.SkuTier,
  "CognitiveServicesSkuTier",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.ThrottlingRule,
  "ServiceAccountThrottlingRule",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.UnitType,
  "ServiceAccountUsageUnitType",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Usage,
  "ServiceAccountUsage",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.UserOwnedStorage,
  "ServiceAccountUserOwnedStorage",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.VirtualNetworkRule,
  "CognitiveServicesVirtualNetworkRule",
  "csharp"
);

// C# internal -> public
@@access(Microsoft.CognitiveServices.AbusePenalty, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.ApiProperties, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.CallRateLimit, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.CommitmentPlanAssociation,
  Access.public,
  "csharp"
);
@@access(Microsoft.CognitiveServices.KeyVaultProperties,
  Access.public,
  "csharp"
);
@@access(Microsoft.CognitiveServices.MultiRegionSettings, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.NetworkRuleSet, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.ProvisioningState, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.PublicNetworkAccess, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.QuotaLimit, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.RaiMonitorConfig, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.Sku, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.SkuCapability, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.SkuChangeInfo, Access.public, "csharp");
@@access(Microsoft.CognitiveServices.UserOwnedAmlWorkspace,
  Access.public,
  "csharp"
);
@@access(Microsoft.CognitiveServices.UserOwnedStorage, Access.public, "csharp");
