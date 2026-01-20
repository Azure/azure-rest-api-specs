import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Pinecone.VectorDb;

@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmtClient", "python");
@@clientName(Pinecone.VectorDb, "PineconeVectorDbMgmtClient", "java");

// csharp
@@clientName(OrganizationResource, "PineconeVectorDBOrganization", "csharp");
@@clientName(OrganizationProperties,
  "PineconeVectorDBOrganizationProperties",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceDetails,
  "PineconeVectorDBMarketplaceDetails",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "PineconeVectorDBMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails, "PineconeVectorDBOfferDetails", "csharp");
@@clientName(PartnerProperties, "PineconeVectorDBPartnerProperties", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "PineconeVectorDBProvisioningState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnPropertiesV2,
  "PineconeVectorDBSingleSignOnPropertiesV2",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnStates,
  "PineconeVectorDBSingleSignOnState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnType,
  "PineconeVectorDBSingleSignOnType",
  "csharp"
);
@@clientName(LiftrBase.UserDetails, "PineconeVectorDBUserDetails", "csharp");
