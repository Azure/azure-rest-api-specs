import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Elastic;

// Client customizations for Java SDK to maintain backward compatibility

// Fix case change in ExternalUserInfo.userName -> username
@@clientName(ExternalUserInfo.userName, "username", "java");

// Fix case changes in PlanDetails properties
@@clientName(PlanDetails.offerID, "offerId", "java,csharp");
@@clientName(PlanDetails.planID, "planId", "java,csharp");
@@clientName(PlanDetails.publisherID, "publisherId", "java,csharp");
@@clientName(PlanDetails.termID, "termId", "java,csharp");

// Fix case changes for createAndAssociate operations (IP -> Ip)
@@clientLocation(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "createAndAssociateIpFilters",
  "java"
);

@@scope(Operations.list, "!csharp");

@@clientName(MonitoringStatus, "ElasticMonitoringStatus", "csharp");
@@clientName(MonitorProperties, "ElasticMonitorProperties", "csharp");
@@clientName(CompanyInfo, "ElasticCompanyInfo", "csharp");
@@clientName(PlanDetails, "ElasticPlanDetails", "csharp");
@@clientName(ProvisioningState, "ElasticProvisioningState", "csharp");
@@clientName(ElasticMonitorResource, "ElasticMonitor", "csharp");
@@alternateType(ElasticMonitorResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(MonitoringTagRules, "ElasticTagRule", "csharp");
@@clientName(MonitoringTagRulesProperties,
  "ElasticTagRuleProperties",
  "csharp"
);
@@clientName(ElasticVersionListProperties.version,
  "AvailableVersion",
  "csharp"
);
@@clientName(OpenAIIntegrationRPModel, "ElasticOpenAIIntegration", "csharp");
@@clientName(OpenAIIntegrationProperties,
  "ElasticOpenAIIntegrationProperties",
  "csharp"
);
@@alternateType(OpenAIIntegrationProperties.openAIResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BillingInfoResponse, "ElasticBillingInfoResult", "csharp");
@@alternateType(ConnectedPartnerResourceProperties.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ConnectedPartnerResourceProperties.location,
  azureLocation,
  "csharp"
);
@@alternateType(ConnectedPartnerResourceProperties.partnerDeploymentUri,
  url,
  "csharp"
);
@@clientName(ConnectedPartnerResourceProperties.type,
  "ConnectedPartnerResourcePropertiesType",
  "csharp"
);
@@clientName(ConnectedPartnerResourcesListFormat,
  "ConnectedPartnerResourceInfo",
  "csharp"
);
@@clientName(DeploymentInfoResponse, "ElasticDeploymentInfoResult", "csharp");
@@clientName(ElasticOrganizationToAzureSubscriptionMappingResponse,
  "ElasticOrganizationToAzureSubscriptionMappingResult",
  "csharp"
);
@@clientName(ElasticOrganizationToAzureSubscriptionMappingResponseProperties,
  "ElasticOrganizationToAzureSubscriptionMappingProperties",
  "csharp"
);
@@clientName(ElasticProperties, "ElasticCloudProperties", "csharp");
@@clientName(ElasticTrafficFilter.includeByDefault,
  "DoesIncludeByDefault",
  "csharp"
);
@@clientName(ElasticTrafficFilter.type, "FilterType", "csharp");
@@clientName(ElasticTrafficFilterResponse,
  "ElasticTrafficFilterListResult",
  "csharp"
);
@@clientName(ElasticVersionListFormat, "ElasticVersion", "csharp");
@@clientName(ElasticVersionListProperties,
  "ElasticVersionProperties",
  "csharp"
);
@@clientName(ExternalUserInfo, "ElasticExternalUserContent", "csharp");
@@clientName(ExternalUserCreationResponse,
  "ElasticExternalUserCreationResult",
  "csharp"
);
@@clientName(ExternalUserCreationResponse.created, "IsCreated", "csharp");
@@clientName(FilteringTag, "ElasticFilteringTag", "csharp");
@@clientName(LiftrResourceCategories, "ElasticLiftrResourceCategory", "csharp");
@@clientName(LogRules, "ElasticLogRules", "csharp");
@@clientName(LogRules.sendAadLogs, "ShouldAadLogsBeSent", "csharp");
@@clientName(LogRules.sendSubscriptionLogs,
  "ShouldSubscriptionLogsBeSent",
  "csharp"
);
@@clientName(LogRules.sendActivityLogs, "ShouldActivityLogsBeSent", "csharp");
@@clientName(MarketplaceSaaSInfo.subscribed, "IsSubscribed", "csharp");
@@clientName(MonitoredResource, "MonitoredResourceInfo", "csharp");
@@alternateType(MonitoredResource.id, armResourceIdentifier, "csharp");
@@clientName(MonitorProperties.generateApiKey, "IsApiKeyGenerated", "csharp");
@@clientName(OpenAIIntegrationStatusResponse,
  "ElasticOpenAIIntegrationStatusResult",
  "csharp"
);
@@clientName(OpenAIIntegrationStatusResponseProperties,
  "ElasticOpenAIIntegrationStatusProperties",
  "csharp"
);
@@clientName(OperationName, "VmCollectionUpdateOperationName", "csharp");
@@clientName(ResourceSku, "ElasticSku", "csharp");
@@clientName(SendingLogs, "SendingLogsStatus", "csharp");
@@clientName(TagAction, "FilteringTagAction", "csharp");
@@clientName(Type, "ElasticFilterType", "csharp");
@@clientName(Type.ip, "IP", "csharp");
@@clientName(UpgradableVersionsList, "UpgradableVersionListResult", "csharp");
@@clientName(UserApiKeyResponse, "ElasticUserApiKeyResult", "csharp");
@@clientName(UserApiKeyResponseProperties,
  "ElasticUserApiKeyProperties",
  "csharp"
);
@@clientName(UserInfo, "ElasticUserInfo", "csharp");
@@clientName(UserEmailId, "ElasticUserEmailId", "csharp");
@@clientName(VMCollectionUpdate, "VmCollectionContent", "csharp");
@@alternateType(VMCollectionUpdate.vmResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(VMIngestionDetailsResponse, "VmIngestionDetailsResult", "csharp");
@@clientName(VMResources, "ElasticVmResourceInfo", "csharp");
@@alternateType(VMResources.vmResourceId, armResourceIdentifier, "csharp");
@@clientName(ConfigurationType,
  "ElasticsearchProjectConfigurationType",
  "csharp"
);
@@clientName(HostingType, "MonitorResourceHostingType", "csharp");
@@alternateType(MarketplaceSaaSInfoMarketplaceSubscription.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Operation, "ResourcePatchOperation", "csharp");
@@alternateType(MonitoredSubscription.subscriptionId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ProjectDetails, "MonitorResourceProjectDetails", "csharp");
@@clientName(ProjectType, "MonitorResourceProjectType", "csharp");
@@clientName(Status, "MonitoringStatus", "csharp");
@@alternateType(ResubscribeProperties.subscriptionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ElasticCloudDeployment.elasticsearchServiceUrl, url, "csharp");
@@alternateType(ElasticCloudDeployment.kibanaServiceUrl, url, "csharp");
@@alternateType(ElasticCloudDeployment.kibanaSsoUrl, url, "csharp");
@@alternateType(ElasticCloudUser.elasticCloudSsoDefaultUrl, url, "csharp");
@@alternateType(DeploymentInfoResponse.deploymentUrl, url, "csharp");
@@alternateType(PartnerBillingEntity.partnerEntityUri, url, "csharp");

@@clientName(ElasticMonitorResources.billingInfoGet,
  "GetBillingInfo",
  "csharp"
);
@@clientName(ElasticMonitorResources.deploymentInfoList,
  "GetDeploymentInfo",
  "csharp"
);
@@clientName(ElasticMonitorResources.details,
  "GetVmIngestionDetails",
  "csharp"
);
@@clientName(ElasticMonitorResources.vMCollectionUpdate,
  "UpdateVmCollection",
  "csharp"
);
@@clientName(ElasticMonitorResources.upgradableVersionsDetails,
  "GetUpgradableVersionDetails",
  "csharp"
);
@@clientName(ElasticMonitorResources.allTrafficFiltersList,
  "GetAllTrafficFilters",
  "csharp"
);
@@clientName(ElasticMonitorResources.listAssociatedTrafficFiltersList,
  "GetAssociatedTrafficFilters",
  "csharp"
);
@@clientName(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "CreateAndAssociateIPFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.createAndAssociatePLFilterCreate,
  "CreateAndAssociatePrivateLinkFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.associate,
  "AssociateTrafficFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.detachAndDeleteTrafficFilterDelete,
  "DetachAndDeleteTrafficFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.detachTrafficFilterUpdate,
  "DetachTrafficFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.trafficFiltersDelete,
  "DeleteTrafficFilter",
  "csharp"
);
@@clientName(ElasticMonitorResources.connectedPartnerResourcesList,
  "GetConnectedPartnerResources",
  "csharp"
);
@@clientName(ElasticMonitorResources.vMHostList, "GetVMHosts", "csharp");
@@clientName(ElasticMonitorResources.createOrUpdate,
  "CreateOrUpdateExternalUser",
  "csharp"
);
@@clientName(ElasticMonitorResources.monitoredResourcesList,
  "GetMonitoredResources",
  "csharp"
);
@@clientName(ElasticMonitorResources.resubscribe,
  "ResubscribeOrganization",
  "csharp"
);
@@clientName(ElasticMonitorResources.upgrade, "UpgradeMonitor", "csharp");
@@clientName(OrganizationsOperationGroup.getApiKey, "GetApiKey", "csharp");
@@clientName(OrganizationsOperationGroup.getElasticToAzureSubscriptionMapping,
  "GetElasticToAzureSubscriptionMapping",
  "csharp"
);
@@clientName(ElasticVersionsOperationGroup.list,
  "GetElasticVersions",
  "csharp"
);
@@clientName(MonitoredSubscriptionProperties,
  "ElasticMonitoredSubscription",
  "csharp"
);
@@clientName(SubscriptionList,
  "ElasticMonitoredSubscriptionProperties",
  "csharp"
);
@@clientName(ElasticMonitorResources.vMHostList, "GetVmHosts", "csharp");
