import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MongoDB.Atlas;

@@clientName(MongoDB.Atlas, "MongoDBAtlasMgmt", "python");
// java
@@clientName(MongoDB.Atlas, "MongoDBAtlasManagementClient", "java");

//csharp
@@clientName(MongoDB.Atlas.OrganizationResource,
  "MongoDBAtlasOrganization",
  "csharp"
);
@@clientName(MongoDB.Atlas.UserDetails, "MongoDBAtlasUserDetails", "csharp");
@@clientName(MongoDB.Atlas.OrganizationProperties,
  "MongoDBAtlasOrganizationProperties",
  "csharp"
);
@@clientName(MongoDB.Atlas.PartnerProperties,
  "MongoDBAtlasPartnerProperties",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "MongoDBAtlasOfferDetails", "csharp");
@@clientName(LiftrBase.MarketplaceDetails,
  "MongoDBAtlasMarketplaceDetails",
  "csharp"
);

@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "MongoDBAtlasResourceProvisioningState",
  "csharp"
);
