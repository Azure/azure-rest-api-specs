import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Sites {
  get is ArmResourceRead<Site>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;
  update is ArmCustomPatchSync<Site, SiteUpdate>;
  delete is ArmResourceDeleteSync<Site>;
  listByResourceGroup is ArmResourceListByParent<Site>;
}

alias SubscriptionParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of subscription"
interface SitesBySubscription {
  list is ArmListBySubscription<Site>;
  get is ArmResourceRead<Site, BaseParameters = SubscriptionParameters>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
  update is ArmCustomPatchSync<
    Site,
    SiteUpdate,
    BaseParameters = SubscriptionParameters
  >;
  delete is ArmResourceDeleteSync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
}

alias TenantParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of Tenant"
interface SitesByTenant {
   #suppress "@azure-tools/typespec-azure-core/no-openapi" "For changing operation id"
  @operationId("List_by_Tenant")
  list is ArmResourceListAtScope<Site, BaseParameters = TenantParameters>;
  get is ArmResourceRead<Site, BaseParameters = TenantParameters>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters = TenantParameters
  >;
  update is ArmCustomPatchSync<
    Site,
    SiteUpdate,
    BaseParameters = TenantParameters
  >;
  delete is ArmResourceDeleteSync<
    Site,
    BaseParameters = TenantParameters
  >;
}
