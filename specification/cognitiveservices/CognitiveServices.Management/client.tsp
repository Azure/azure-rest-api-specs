import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
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

@@clientName(PATAuthTypeConnectionProperties,
  "PatAuthTypeConnectionProperties",
  "java"
);
@@clientName(SASAuthTypeConnectionProperties,
  "SasAuthTypeConnectionProperties",
  "java"
);
@@clientName(AADAuthTypeConnectionProperties,
  "AadAuthTypeConnectionProperties",
  "java"
);

@@clientLocation(checkDomainAvailability, "ManagementClient", "go");
@@clientLocation(checkSkuAvailability, "ManagementClient", "go");
@@clientLocation(calculateModelCapacity, "ManagementClient", "go");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientLocation(ModelsOperationGroup.list,
  "CognitiveServicesModels",
  "csharp"
);
@@clientName(ModelsOperationGroup.list, "GetModels", "csharp");
@@clientName(ResourceSkusOperationGroup.list, "GetResourceSkus", "csharp");
@@clientName(CommitmentTiersOperationGroup.list,
  "GetCommitmentTiers",
  "csharp"
);

@@clientName(Account, "CognitiveServicesAccount", "csharp");
@@alternateType(Account.location, azureLocation, "csharp");
@@alternateType(Account.etag, eTag, "csharp");
@@alternateType(Account.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@hierarchyBuilding(Account,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@alternateType(CommitmentPlan.location, azureLocation, "csharp");
@@alternateType(CommitmentPlan.etag, eTag, "csharp");
@@clientName(Deployment, "CognitiveServicesAccountDeployment", "csharp");
@@alternateType(Deployment.etag, eTag, "csharp");
@@clientName(AgentApplication, "CognitiveServicesAgentApplication", "csharp");
@@clientName(AgenticApplicationProperties,
  "CognitiveServicesAgenticApplicationProperties",
  "csharp"
);
@@clientName(AgenticApplicationProvisioningState,
  "CognitiveServicesAgenticApplicationProvisioningState",
  "csharp"
);
@@clientName(AssignedIdentity, "CognitiveServicesAssignedIdentity", "csharp");
@@clientName(AgentDeployment, "CognitiveServicesAgentDeployment", "csharp");
@@clientName(AgentDeploymentProperties,
  "CognitiveServicesAgentDeploymentProperties",
  "csharp"
);
@@clientName(AgentDeploymentProvisioningState,
  "CognitiveServicesAgentDeploymentProvisioningState",
  "csharp"
);
@@clientName(AgentDeploymentState,
  "CognitiveServicesAgentDeploymentState",
  "csharp"
);
@@clientName(AgentProtocol, "CognitiveServicesAgentProtocol", "csharp");
@@clientName(AgentProtocolVersion,
  "CognitiveServicesAgentProtocolVersion",
  "csharp"
);
@@clientName(AgentReference, "CognitiveServicesAgentReference", "csharp");
@@clientName(AgentReferenceProperties,
  "CognitiveServicesAgentReferenceProperties",
  "csharp"
);
@@clientName(EncryptionScope, "CognitiveServicesEncryptionScope", "csharp");
@@alternateType(EncryptionScope.etag, eTag, "csharp");
@@clientName(Microsoft.CognitiveServices.PrivateEndpointConnection,
  "CognitiveServicesPrivateEndpointConnection",
  "csharp"
);
@@alternateType(Microsoft.CognitiveServices.PrivateEndpointConnection.location,
  azureLocation,
  "csharp"
);
@@alternateType(Microsoft.CognitiveServices.PrivateEndpointConnection.etag,
  eTag,
  "csharp"
);
@@clientName(Project, "CognitiveServicesProject", "csharp");
@@alternateType(Project.location, azureLocation, "csharp");
@@alternateType(Project.etag, eTag, "csharp");
@@alternateType(Project.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@hierarchyBuilding(Project,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(CapabilityHost, "CognitiveServicesCapabilityHost", "csharp");
@@clientName(ConnectionPropertiesV2BasicResource,
  "CognitiveServicesConnection",
  "csharp"
);
@@clientName(ProjectCapabilityHost,
  "CognitiveServicesProjectCapabilityHost",
  "csharp"
);

@@clientName(AADAuthTypeConnectionProperties,
  "AadAuthTypeConnectionProperties",
  "csharp"
);
@@clientName(AccountModel, "CognitiveServicesAccountModel", "csharp");
@@clientName(AccountProperties, "CognitiveServicesAccountProperties", "csharp");
@@clientName(AccountProperties.dateCreated, "CreatedOn", "csharp");
@@alternateType(AccountProperties.dateCreated, utcDateTime, "csharp");
@@clientName(AccountProperties.deletionDate, "DeletedOn", "csharp");
@@alternateType(AccountProperties.deletionDate, utcDateTime, "csharp");
@@clientName(AccountProperties.dynamicThrottlingEnabled,
  "EnableDynamicThrottling",
  "csharp"
);
@@clientName(AccountSku, "CognitiveServicesAccountSku", "csharp");
@@clientName(ApiKeys, "ServiceAccountApiKeys", "csharp");
@@clientName(ApiProperties, "ServiceAccountApiProperties", "csharp");
@@clientName(ByPassSelection, "TrustedServicesByPassSelection", "csharp");
@@clientName(CalculateModelCapacityParameter,
  "CalculateModelCapacityContent",
  "csharp"
);
@@clientName(CallRateLimit, "ServiceAccountCallRateLimit", "csharp");
@@clientName(CapabilityHostProperties,
  "CognitiveServicesCapabilityHostProperties",
  "csharp"
);
@@clientName(CapacityConfig, "CognitiveServicesCapacityConfig", "csharp");
@@clientName(CheckDomainAvailabilityParameter,
  "CognitiveServicesDomainAvailabilityContent",
  "csharp"
);
@@clientName(CheckSkuAvailabilityParameter,
  "CognitiveServicesSkuAvailabilityContent",
  "csharp"
);
@@clientName(ConnectionAccessKey,
  "CognitiveServicesConnectionAccessKey",
  "csharp"
);
@@clientName(ConnectionCategory,
  "CognitiveServicesConnectionCategory",
  "csharp"
);
@@clientName(ConnectionGroup, "CognitiveServicesConnectionGroup", "csharp");
@@clientName(ConnectionManagedIdentity,
  "CognitiveServicesConnectionManagedIdentity",
  "csharp"
);
@@clientName(ConnectionOAuth2, "CognitiveServicesConnectionOAuth2", "csharp");
@@clientName(ConnectionPropertiesV2,
  "CognitiveServicesConnectionProperties",
  "csharp"
);
@@clientName(ConnectionServicePrincipal,
  "CognitiveServicesConnectionServicePrincipal",
  "csharp"
);
@@clientName(ConnectionUpdateContent,
  "CognitiveServicesConnectionPatch",
  "csharp"
);
@@clientName(ConnectionUsernamePassword,
  "CognitiveServicesConnectionUsernamePassword",
  "csharp"
);
@@clientName(ContentLevel, "RaiPolicyContentLevel", "csharp");
@@clientName(DeploymentModel,
  "CognitiveServicesAccountDeploymentModel",
  "csharp"
);
@@clientName(DeploymentProperties,
  "CognitiveServicesAccountDeploymentProperties",
  "csharp"
);
@@clientName(DeploymentProvisioningState,
  "CognitiveServicesAccountDeploymentProvisioningState",
  "csharp"
);
@@clientName(DeploymentScaleSettings,
  "CognitiveServicesAccountDeploymentScaleSettings",
  "csharp"
);
@@clientName(DeploymentScaleType,
  "CognitiveServicesAccountDeploymentScaleType",
  "csharp"
);
@@clientName(DomainAvailability,
  "CognitiveServicesDomainAvailabilityList",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.Encryption,
  "ServiceAccountEncryptionProperties",
  "csharp"
);
@@clientName(EncryptionScopeProperties,
  "CognitiveServicesEncryptionScopeProperties",
  "csharp"
);
@@clientName(HostingModel, "ServiceAccountHostingModel", "csharp");
@@clientName(IpRule, "CognitiveServicesIPRule", "csharp");
@@clientName(KeyName, "ServiceAccountKeyName", "csharp");
@@clientName(KeySource, "ServiceAccountEncryptionKeySource", "csharp");
@@clientName(KeyVaultProperties,
  "CognitiveServicesKeyVaultProperties",
  "csharp"
);
@@clientName(MetricName, "ServiceAccountUsageMetricName", "csharp");
@@clientName(Model, "CognitiveServicesModel", "csharp");
@@clientName(ModelDeprecationInfo,
  "ServiceAccountModelDeprecationInfo",
  "csharp"
);
@@clientName(ModelSku, "CognitiveServicesModelSku", "csharp");
@@clientName(MultiRegionSettings,
  "CognitiveServicesMultiRegionSettings",
  "csharp"
);
@@clientName(NetworkInjection, "AIFoundryNetworkInjection", "csharp");
@@alternateType(NetworkInjection.subnetArmId, armResourceIdentifier, "csharp");
@@clientName(NetworkRuleAction, "CognitiveServicesNetworkRuleAction", "csharp");
@@clientName(NetworkRuleSet, "CognitiveServicesNetworkRuleSet", "csharp");
@@clientName(NetworkSecurityPerimeter,
  "CognitiveServicesNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(PATAuthTypeConnectionProperties,
  "PatAuthTypeConnectionProperties",
  "csharp"
);
@@clientName(PatchResourceTags, "CognitiveServicesPatchResourceTags", "csharp");
@@clientName(Microsoft.CognitiveServices.PrivateLinkResource,
  "CognitiveServicesPrivateLinkResource",
  "csharp"
);
@@clientName(Microsoft.CognitiveServices.PrivateLinkResourceProperties,
  "CognitiveServicesPrivateLinkResourceProperties",
  "csharp"
);
@@clientName(ProjectProperties, "CognitiveServicesProjectProperties", "csharp");
@@clientName(ProvisioningIssue,
  "NetworkSecurityPerimeterProvisioningIssue",
  "csharp"
);
@@clientName(ProvisioningIssueProperties,
  "NetworkSecurityPerimeterProvisioningIssueProperties",
  "csharp"
);
@@clientName(ProvisioningState, "ServiceAccountProvisioningState", "csharp");
@@clientName(PublicNetworkAccess,
  "ServiceAccountPublicNetworkAccess",
  "csharp"
);
@@clientName(QuotaLimit, "ServiceAccountQuotaLimit", "csharp");
@@clientName(QuotaUsageStatus, "ServiceAccountQuotaUsageStatus", "csharp");
@@clientName(RaiBlocklistItemBulkRequest,
  "RaiBlocklistItemBulkContent",
  "csharp"
);
@@clientName(RegionSetting, "CognitiveServicesRegionSetting", "csharp");
@@clientName(RegenerateKeyParameters,
  "RegenerateServiceAccountKeyContent",
  "csharp"
);
@@clientName(RequestMatchPattern,
  "ServiceAccountThrottlingMatchPattern",
  "csharp"
);
@@clientName(ResourceBase, "CognitiveServicesResourceBase", "csharp");
@@clientName(Microsoft.CognitiveServices.ResourceSku,
  "AvailableCognitiveServicesSku",
  "csharp"
);
@@clientName(ResourceSkuRestrictionInfo,
  "CognitiveServicesSkuRestrictionInfo",
  "csharp"
);
@@clientName(ResourceSkuRestrictions,
  "CognitiveServicesSkuRestrictions",
  "csharp"
);
@@clientName(ResourceSkuRestrictionsReasonCode,
  "CognitiveServicesSkuRestrictionReasonCode",
  "csharp"
);
@@clientName(ResourceSkuRestrictionsType,
  "CognitiveServicesSkuRestrictionsType",
  "csharp"
);
@@clientName(RoutingMethods, "CognitiveServicesRoutingMethod", "csharp");
@@clientName(ScenarioType, "AIFoundryNetworkInjectionScenarioType", "csharp");
@@clientName(SkuAvailability, "CognitiveServicesSkuAvailabilityList", "csharp");
@@clientName(SkuCapability, "CognitiveServicesSkuCapability", "csharp");
@@clientName(SkuChangeInfo, "CognitiveServicesSkuChangeInfo", "csharp");
@@clientName(SkuResource, "CognitiveServicesResourceSku", "csharp");
@@clientName(SkuTier, "CognitiveServicesSkuTier", "csharp");
@@clientName(ThrottlingRule, "ServiceAccountThrottlingRule", "csharp");
@@clientName(UnitType, "ServiceAccountUsageUnitType", "csharp");
@@clientName(Microsoft.CognitiveServices.Usage,
  "ServiceAccountUsage",
  "csharp"
);
@@clientName(UserOwnedStorage, "ServiceAccountUserOwnedStorage", "csharp");
@@clientName(VirtualNetworkRule,
  "CognitiveServicesVirtualNetworkRule",
  "csharp"
);
@@clientName(ManagedNetworkProvisionStatus.status,
  "ManagedNetworkStatus",
  "csharp"
);
@@clientName(ManagedNetworkSettingsPropertiesBasicResource,
  "CognitiveServicesManagedNetworkSettings",
  "csharp"
);
@@clientName(ManagedNetworkSettingsProperties,
  "CognitiveServicesManagedNetworkSettingsProperties",
  "csharp"
);
@@clientName(OutboundRuleBasicResource,
  "CognitiveServicesOutboundRuleBasic",
  "csharp"
);
@@clientName(OutboundRule,
  "CognitiveServicesOutboundRuleBasicProperties",
  "csharp"
);
@@clientName(QuotaTier, "CognitiveServicesQuotaTier", "csharp");
@@clientName(QuotaTierProperties,
  "CognitiveServicesQuotaTierProperties",
  "csharp"
);
@@alternateType(RaiBlocklist.etag, eTag, "csharp");
@@alternateType(RaiBlocklistItem.etag, eTag, "csharp");
@@alternateType(CommitmentPlanAccountAssociation.etag, eTag, "csharp");
@@alternateType(RaiExternalSafetyProviderSchema.etag, eTag, "csharp");
@@alternateType(RaiPolicy.etag, eTag, "csharp");
@@alternateType(RaiToolLabel.etag, eTag, "csharp");
@@alternateType(RaiTopic.etag, eTag, "csharp");
@@clientName(DeploymentState, "CognitiveServicesDeploymentState", "csharp");
@@alternateType(Azure.ResourceManager.LocationParameter.location,
  azureLocation,
  "csharp"
);
@@clientName(CommitmentPlanOperationGroup.listPlansBySubscription,
  "GetCognitiveServicesCommitmentPlans",
  "csharp"
);
@@clientName(Accounts.list, "GetCognitiveServicesAccounts", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This operation is pageable for .Net SDK"
@@markAsPageable(checkSkuAvailability, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This operation is pageable for .Net SDK"
@@markAsPageable(CommitmentPlanOperationGroup.listPlansByResourceGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This operation is pageable for .Net SDK"
@@markAsPageable(CommitmentPlanOperationGroup.listPlansBySubscription,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This operation is pageable for .Net SDK"
@@markAsPageable(Accounts.listSkus, "csharp");

@@access(AbusePenalty, Access.public, "csharp");
@@access(ApiProperties, Access.public, "csharp");
@@access(CallRateLimit, Access.public, "csharp");
@@access(CommitmentPlanAssociation, Access.public, "csharp");
@@access(KeyVaultProperties, Access.public, "csharp");
@@access(MultiRegionSettings, Access.public, "csharp");
@@access(NetworkRuleSet, Access.public, "csharp");
@@access(ProvisioningState, Access.public, "csharp");
@@access(PublicNetworkAccess, Access.public, "csharp");
@@access(QuotaLimit, Access.public, "csharp");
@@access(RaiMonitorConfig, Access.public, "csharp");
@@access(Sku, Access.public, "csharp");
@@access(SkuCapability, Access.public, "csharp");
@@access(SkuChangeInfo, Access.public, "csharp");
@@access(UserOwnedAmlWorkspace, Access.public, "csharp");
@@access(UserOwnedStorage, Access.public, "csharp");
