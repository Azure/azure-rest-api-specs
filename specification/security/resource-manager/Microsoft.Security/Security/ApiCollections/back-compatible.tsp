import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ApiCollectionsAPI;

@@clientLocation(ApiCollections.getByAzureApiManagementService,
  "APICollections"
);
@@clientLocation(ApiCollections.onboardAzureApiManagementApi, "APICollections");
@@clientLocation(ApiCollections.offboardAzureApiManagementApi,
  "APICollections"
);
@@clientLocation(ApiCollections.listByAzureApiManagementService,
  "APICollections"
);
@@clientLocation(ApiCollections.listBySubscription, "APICollections");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApiCollection.properties);

@@clientLocation(ApiCollectionsOperationGroup.listByResourceGroup,
  "APICollections"
);

