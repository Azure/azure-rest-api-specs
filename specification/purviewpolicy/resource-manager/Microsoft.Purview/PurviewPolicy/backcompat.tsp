import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

@@path(ResourceUriParameter.resourceUri, "scope");
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "TODO: This should not be used, remove"
@@Azure.ResourceManager.CommonTypes.Private.armCommonParameter(ResourceUriParameter.resourceUri,
  "ScopeParameter",
  Azure.ResourceManager.CommonTypes.Versions.v5
);

@@doc(Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The scope of the operation or resource. Valid scopes are: subscription (format: '/subscriptions/{subscriptionId}'), or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'"
);
