import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MongoDB.Atlas;

@@clientName(MongoDB.Atlas, "MongoDBAtlasMgmtClient", "python");
// java
@@clientName(MongoDB.Atlas, "MongoDBAtlasManagementClient", "java");

//csharp
@@clientName(
  MongoDB.Atlas.OrganizationResource,
  "MongoDBAtlasOrganization",
  "csharp"
);
@@clientName(MongoDB.Atlas.UserDetails, "MongoDBAtlasUserDetails", "csharp");
@@clientName(
  MongoDB.Atlas.OrganizationProperties,
  "MongoDBAtlasOrganizationProperties",
  "csharp"
);
@@clientName(
  MongoDB.Atlas.PartnerProperties,
  "MongoDBAtlasPartnerProperties",
  "csharp"
);

@@clientName(LiftrBase.OfferDetails, "MongoDBAtlasOfferDetails", "csharp");
@@clientName(
  LiftrBase.MarketplaceDetails,
  "MongoDBAtlasMarketplaceDetails",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "MongoDBAtlasResourceProvisioningState",
  "csharp"
);

// Project and Cluster resources (preview). Renaming the resource models to the
// MongoDBAtlas* prefix makes the generator emit MongoDBAtlas*Resource/*Data/*Collection,
// matching the package naming convention (same pattern as OrganizationResource above).
@@clientName(MongoDB.Atlas.Project, "MongoDBAtlasProject", "csharp");
@@clientName(MongoDB.Atlas.Cluster, "MongoDBAtlasCluster", "csharp");
@@clientName(
  MongoDB.Atlas.ProjectProperties,
  "MongoDBAtlasProjectProperties",
  "csharp"
);
@@clientName(
  MongoDB.Atlas.ClusterProperties,
  "MongoDBAtlasClusterProperties",
  "csharp"
);
@@clientName(MongoDB.Atlas.ClusterTier, "MongoDBAtlasClusterTier", "csharp");

// Tier and region preview models. Apply the MongoDBAtlas* prefix for naming
// consistency, and rename the "Response" suffix to "Result" so the public model
// names satisfy the AZC0030 analyzer. Client-only (csharp) renames; the wire
// contract is unchanged.
@@clientName(
  MongoDB.Atlas.RegionsByTierResponse,
  "MongoDBAtlasRegionsByTierResult",
  "csharp"
);
@@clientName(
  MongoDB.Atlas.TierLimitReachedResponse,
  "MongoDBAtlasTierLimitReachedResult",
  "csharp"
);
@@clientName(MongoDB.Atlas.TierRegions, "MongoDBAtlasTierRegions", "csharp");
@@clientName(
  MongoDB.Atlas.ProjectLimitStatus,
  "MongoDBAtlasProjectLimitStatus",
  "csharp"
);
