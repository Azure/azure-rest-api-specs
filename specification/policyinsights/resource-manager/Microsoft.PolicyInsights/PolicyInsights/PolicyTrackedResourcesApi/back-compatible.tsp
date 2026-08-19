import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PolicyTrackedResourcesApi;

@@clientLocation(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForManagementGroup,
  "PolicyTrackedResources"
);
@@clientLocation(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForSubscription,
  "PolicyTrackedResources"
);
@@clientLocation(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForResourceGroup,
  "PolicyTrackedResources"
);
@@clientLocation(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForResource,
  "PolicyTrackedResources"
);
