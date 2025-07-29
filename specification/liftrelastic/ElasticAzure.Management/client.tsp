import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ElasticAzure;

@@clientName(ElasticAzure, "ElasticAzureMgmt", "python");
// java
@@clientName(ElasticAzure, "ElasticAzureManagementClient", "java");

//csharp
@@clientName(ElasticAzure.OrganizationResource,
  "ElasticAzureOrganization",
  "csharp"
);
@@clientName(ElasticAzure.UserDetails, "ElasticAzureUserDetails", "csharp");
@@clientName(ElasticAzure.OrganizationProperties,
  "ElasticAzureOrganizationProperties",
  "csharp"
);
@@clientName(ElasticAzure.PartnerProperties,
  "ElasticAzurePartnerProperties",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "ElasticAzureOfferDetails", "csharp");
@@clientName(LiftrBase.MarketplaceDetails,
  "ElasticAzureMarketplaceDetails",
  "csharp"
);

@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ElasticAzureResourceProvisioningState",
  "csharp"
);