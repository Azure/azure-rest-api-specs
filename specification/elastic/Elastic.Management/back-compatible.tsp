import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Elastic;

@@clientLocation(ElasticMonitorResources.get, "Monitors", "!csharp");
@@clientLocation(ElasticMonitorResources.create, "Monitors", "!csharp");
@@clientName(ElasticMonitorResources.create::parameters.resource, "body");
@@clientLocation(ElasticMonitorResources.update, "Monitors", "!csharp");
@@clientName(ElasticMonitorResources.update::parameters.properties, "body");
@@clientLocation(ElasticMonitorResources.delete, "Monitors", "!csharp");
@@clientLocation(ElasticMonitorResources.listByResourceGroup,
  "Monitors",
  "!csharp"
);
@@clientLocation(ElasticMonitorResources.list, "Monitors", "!csharp");
@@clientLocation(ElasticMonitorResources.monitoredResourcesList,
  "MonitoredResources",
  "!csharp"
);
@@clientName(ElasticMonitorResources.monitoredResourcesList, "List");
@@clientLocation(ElasticMonitorResources.deploymentInfoList,
  "DeploymentInfo",
  "!csharp"
);
@@clientName(ElasticMonitorResources.deploymentInfoList, "List");
@@clientLocation(ElasticMonitorResources.createOrUpdate,
  "ExternalUser",
  "!csharp"
);
@@clientLocation(ElasticMonitorResources.billingInfoGet,
  "BillingInfo",
  "!csharp"
);
@@clientName(ElasticMonitorResources.billingInfoGet, "Get");
@@clientLocation(ElasticMonitorResources.connectedPartnerResourcesList,
  "ConnectedPartnerResources",
  "!csharp"
);
@@clientName(ElasticMonitorResources.connectedPartnerResourcesList, "List");
@@clientLocation(ElasticMonitorResources.vMHostList, "VMHost", "!csharp");
@@clientName(ElasticMonitorResources.vMHostList, "List");
@@clientLocation(ElasticMonitorResources.details, "VMIngestion", "!csharp");
@@clientLocation(ElasticMonitorResources.vMCollectionUpdate,
  "VMCollection",
  "!csharp"
);
@@clientName(ElasticMonitorResources.vMCollectionUpdate, "Update");
@@clientLocation(ElasticMonitorResources.upgradableVersionsDetails,
  "UpgradableVersions",
  "!csharp"
);
@@clientName(ElasticMonitorResources.upgradableVersionsDetails, "Details");
@@clientLocation(ElasticMonitorResources.upgrade, "Monitor", "!csharp");
@@clientLocation(ElasticMonitorResources.allTrafficFiltersList,
  "AllTrafficFilters",
  "!csharp"
);
@@clientName(ElasticMonitorResources.allTrafficFiltersList, "list");
@@clientLocation(ElasticMonitorResources.listAssociatedTrafficFiltersList,
  "listAssociatedTrafficFilters",
  "!csharp"
);
@@clientName(ElasticMonitorResources.listAssociatedTrafficFiltersList, "list");
@@clientLocation(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "createAndAssociateIPFilter",
  "!csharp"
);
@@clientName(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "Create"
);
@@clientLocation(ElasticMonitorResources.createAndAssociatePLFilterCreate,
  "createAndAssociatePLFilter",
  "!csharp"
);
@@clientName(ElasticMonitorResources.createAndAssociatePLFilterCreate,
  "Create"
);
@@clientLocation(ElasticMonitorResources.associate,
  "AssociateTrafficFilter",
  "!csharp"
);
@@clientLocation(ElasticMonitorResources.detachAndDeleteTrafficFilterDelete,
  "DetachAndDeleteTrafficFilter",
  "!csharp"
);
@@clientName(ElasticMonitorResources.detachAndDeleteTrafficFilterDelete,
  "Delete"
);
@@clientLocation(ElasticMonitorResources.detachTrafficFilterUpdate,
  "DetachTrafficFilter",
  "!csharp"
);
@@clientName(ElasticMonitorResources.detachTrafficFilterUpdate, "Update");
@@clientLocation(ElasticMonitorResources.trafficFiltersDelete,
  "TrafficFilters",
  "!csharp"
);
@@clientName(ElasticMonitorResources.trafficFiltersDelete, "Delete");
@@clientLocation(ElasticMonitorResources.resubscribe,
  "Organizations",
  "!csharp"
);

@@clientName(MonitoredSubscriptions.createorUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientLocation(OpenAIIntegrationRPModels.get, "OpenAI", "!csharp");
@@clientLocation(OpenAIIntegrationRPModels.createOrUpdate, "OpenAI", "!csharp");
@@clientName(OpenAIIntegrationRPModels.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OpenAIIntegrationRPModels.delete, "OpenAI", "!csharp");
@@clientLocation(OpenAIIntegrationRPModels.list, "OpenAI", "!csharp");
@@clientLocation(OpenAIIntegrationRPModels.getStatus, "OpenAI", "!csharp");

@@clientName(TagRules.createOrUpdate::parameters.resource, "body");

@@clientLocation(ElasticVersionsOperationGroup.list,
  "ElasticVersions",
  "!csharp"
);

@@clientLocation(OrganizationsOperationGroup.getApiKey,
  "Organizations",
  "!csharp"
);
@@clientLocation(OrganizationsOperationGroup.getElasticToAzureSubscriptionMapping,
  "Organizations",
  "!csharp"
);

@@identifiers(ElasticVersionsListResponse.value, #["properties/version"]);

@@identifiers(ConnectedPartnerResourcesListResponse.value,
  #["properties/azureResourceId"]
);
