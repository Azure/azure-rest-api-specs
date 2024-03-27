import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Sites {
  get is ArmResourceRead<Site>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;
  update is ArmResourcePatchSync<Site, SiteProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Site>;
  listByResourceGroup is ArmResourceListByParent<Site>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of subscription"
interface SitesBySubscriptions {
  list is ArmListBySubscription<Site>;
  get is ArmResourceRead<Site, BaseParameters = SubscriptionBaseParameters>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site, BaseParameters = SubscriptionBaseParameters>;
  update is ArmResourcePatchSync<Site, SiteProperties, BaseParameters = SubscriptionBaseParameters>;
  delete is ArmResourceDeleteWithoutOkAsync<Site, BaseParameters = SubscriptionBaseParameters>;
}