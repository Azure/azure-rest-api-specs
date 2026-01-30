import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Edge;

@@clientName(Microsoft.Edge, "SiteManagerMgmtClient", "python");

@@clientName(Microsoft.Edge, "SiteManagerManagementClient", "java");

// CSharp
@@clientName(Site, "EdgeSite", "csharp");
@@clientName(Sites, "ResourceGroupEdgeSite", "csharp");
@@clientName(SiteProperties, "EdgeSiteProperties", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "EdgeSiteProvisioningState",
  "csharp"
);
@@clientName(SiteUpdate, "EdgeSitePatch", "csharp");
@@clientName(SiteUpdateProperties, "EdgeSitePatchProperties", "csharp");
@@clientName(SiteAddressProperties, "EdgeSiteAddressProperties", "csharp");
@@clientName(SitesByServiceGroup, "ServiceGroupEdgeSite", "csharp");
@@clientName(SitesBySubscription, "SubscriptionEdgeSite", "csharp");
