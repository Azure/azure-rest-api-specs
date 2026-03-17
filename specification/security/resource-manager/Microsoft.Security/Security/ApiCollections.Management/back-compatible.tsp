import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ApiCollection.properties);

@@clientLocation(APICollectionsOperationGroup.listByResourceGroup,
  "APICollections"
);
