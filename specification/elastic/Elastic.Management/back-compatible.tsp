import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Elastic;

@@clientLocation(ElasticMonitorResources.get, "Monitors", "!csharp");
@@clientLocation(ElasticMonitorResources.create, "Monitors");
@@clientName(ElasticMonitorResources.create::parameters.resource, "body");
@@clientLocation(ElasticMonitorResources.update, "Monitors");
@@clientName(ElasticMonitorResources.update::parameters.properties, "body");
@@clientLocation(ElasticMonitorResources.delete, "Monitors");
@@clientLocation(ElasticMonitorResources.listByResourceGroup, "Monitors");
@@clientLocation(ElasticMonitorResources.list, "Monitors");
@@clientLocation(ElasticMonitorResources.monitoredResourcesList,
  "MonitoredResources"
);
@@clientName(ElasticMonitorResources.monitoredResourcesList, "List");
@@clientLocation(ElasticMonitorResources.deploymentInfoList, "DeploymentInfo");
@@clientName(ElasticMonitorResources.deploymentInfoList, "List");
@@clientLocation(ElasticMonitorResources.createOrUpdate, "ExternalUser");
@@clientLocation(ElasticMonitorResources.billingInfoGet, "BillingInfo");
@@clientName(ElasticMonitorResources.billingInfoGet, "Get");
@@clientLocation(ElasticMonitorResources.connectedPartnerResourcesList,
  "ConnectedPartnerResources"
);
@@clientName(ElasticMonitorResources.connectedPartnerResourcesList, "List");
@@clientLocation(ElasticMonitorResources.vMHostList, "VMHost");
@@clientName(ElasticMonitorResources.vMHostList, "List");
@@clientLocation(ElasticMonitorResources.details, "VMIngestion");
@@clientLocation(ElasticMonitorResources.vMCollectionUpdate, "VMCollection");
@@clientName(ElasticMonitorResources.vMCollectionUpdate, "Update");
@@clientLocation(ElasticMonitorResources.upgradableVersionsDetails,
  "UpgradableVersions"
);
@@clientName(ElasticMonitorResources.upgradableVersionsDetails, "Details");
@@clientLocation(ElasticMonitorResources.upgrade, "Monitor");
@@clientLocation(ElasticMonitorResources.allTrafficFiltersList,
  "AllTrafficFilters"
);
@@clientName(ElasticMonitorResources.allTrafficFiltersList, "list");
@@clientLocation(ElasticMonitorResources.listAssociatedTrafficFiltersList,
  "listAssociatedTrafficFilters"
);
@@clientName(ElasticMonitorResources.listAssociatedTrafficFiltersList, "list");
@@clientLocation(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "createAndAssociateIPFilter"
);
@@clientName(ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "Create"
);
@@clientLocation(ElasticMonitorResources.createAndAssociatePLFilterCreate,
  "createAndAssociatePLFilter"
);
@@clientName(ElasticMonitorResources.createAndAssociatePLFilterCreate,
  "Create"
);
@@clientLocation(ElasticMonitorResources.associate, "AssociateTrafficFilter");
@@clientLocation(ElasticMonitorResources.detachAndDeleteTrafficFilterDelete,
  "DetachAndDeleteTrafficFilter"
);
@@clientName(ElasticMonitorResources.detachAndDeleteTrafficFilterDelete,
  "Delete"
);
@@clientLocation(ElasticMonitorResources.detachTrafficFilterUpdate,
  "DetachTrafficFilter"
);
@@clientName(ElasticMonitorResources.detachTrafficFilterUpdate, "Update");
@@clientLocation(ElasticMonitorResources.trafficFiltersDelete,
  "TrafficFilters"
);
@@clientName(ElasticMonitorResources.trafficFiltersDelete, "Delete");
@@clientLocation(ElasticMonitorResources.resubscribe, "Organizations");

@@clientName(MonitoredSubscriptions.createorUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientLocation(OpenAIIntegrationRPModels.get, "OpenAI");
@@clientLocation(OpenAIIntegrationRPModels.createOrUpdate, "OpenAI");
@@clientName(OpenAIIntegrationRPModels.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OpenAIIntegrationRPModels.delete, "OpenAI");
@@clientLocation(OpenAIIntegrationRPModels.list, "OpenAI");
@@clientLocation(OpenAIIntegrationRPModels.getStatus, "OpenAI");

@@clientName(TagRules.createOrUpdate::parameters.resource, "body");

@@clientLocation(ElasticVersionsOperationGroup.list, "ElasticVersions");

@@clientLocation(OrganizationsOperationGroup.getApiKey, "Organizations");
@@clientLocation(OrganizationsOperationGroup.getElasticToAzureSubscriptionMapping,
  "Organizations"
);

@@OpenAPI.extension(ElasticVersionsListResponse.value,
  "x-ms-identifiers",
  #["properties/version"]
);

@@OpenAPI.extension(ConnectedPartnerResourcesListResponse.value,
  "x-ms-identifiers",
  #["properties/azureResourceId"]
);
