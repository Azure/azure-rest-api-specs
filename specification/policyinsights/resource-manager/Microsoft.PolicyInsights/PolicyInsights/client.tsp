import "./PolicyInsights/main.tsp";
import "./PolicyTrackedResources/main.tsp";

using Azure.ClientGenerator.Core;

@client({
  name: "PolicyInsightsManagementClient",
  service: [PolicyInsightsApi, PolicyTrackedResourcesApi],
  autoMergeService: true,
})
namespace PolicyInsightsManagementClient;

@@clientName(PolicyInsightsManagementClient,
  "PolicyInsightsClient",
  "javascript"
);
