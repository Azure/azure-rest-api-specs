import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Elastic;

@@clientName(Elastic,
  "ElasticAzureMgmt",
  "python"
);

@@clientName(Elastic,
  "ElasticAzureMgmtClient",
  "java"
);

@@clientName(OrganizationResource,
  "ElasticAzureOrganization",
  "csharp"
);

@@clientName(OrganizationProperties,
  "ElasticAzureOrganizationProperties",
  "csharp"
);

@@clientName(ElasticProperties,
  "ElasticAzureElasticProperties",
  "csharp"
);

@@clientName(ElasticDeploymentSettings,
  "ElasticAzureDeploymentSettings",
  "csharp"
);

@@clientName(ElasticDeploymentSize,
  "ElasticAzureDeploymentSize",
  "csharp"
);

@@clientName(LiftrBase.MarketplaceDetails,
  "ElasticAzureMarketplaceDetails",
  "csharp"
);

@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "ElasticAzureMarketplaceSubscriptionStatus",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails,
  "ElasticAzureOfferDetails",
  "csharp"
);

@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ElasticAzureProvisioningState",
  "csharp"
);

@@clientName(LiftrBase.SingleSignOnPropertiesV2,
  "ElasticAzureSingleSignOnPropertiesV2",
  "csharp"
);

@@clientName(LiftrBase.SingleSignOnStates,
  "ElasticAzureSingleSignOnState",
  "csharp"
);

@@clientName(LiftrBase.SingleSignOnType,
  "ElasticAzureSingleSignOnType",
  "csharp"
);

@@clientName(LiftrBase.UserDetails,
  "ElasticAzureUserDetails",
  "csharp"
);