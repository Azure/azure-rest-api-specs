import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./enterpriseMccCustomers.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ConnectedCache;

@doc("Represents the high level Nodes needed to provision cache node resources")
@parentResource(EnterpriseMccCustomerResource)
model EnterpriseMccCacheNodeResource is TrackedResource<CacheNodeProperty> {
  @doc("Name of the ConnectedCache resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("cacheNodeResourceName")
  @segment("enterpriseMccCacheNodes")
  @path
  name: string;
}

@armResourceOperations
interface EnterpriseMccCacheNodesOperations {
  @doc("This api gets ispCacheNode resource information")
  get is ArmResourceRead<EnterpriseMccCacheNodeResource>;
  @doc("This api creates an ispCacheNode with the specified create parameters")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnterpriseMccCacheNodeResource>;
  @doc("This api updates an existing ispCacheNode resource")
  update is ArmCustomPatchSync<
    EnterpriseMccCacheNodeResource,
    ConnectedCachePatchResource
  >;
  @doc("This api deletes an existing ispCacheNode resource")
  delete is ArmResourceDeleteWithoutOkAsync<EnterpriseMccCacheNodeResource>;
  @doc("This api retrieves information about all ispCacheNode resources under the given subscription and resource group")
  listByEnterpriseMccCustomerResource is ArmResourceListByParent<EnterpriseMccCacheNodeResource>;
  @doc("This api gets secrets of the ispCacheNode resource install details")
  getCacheNodeInstallDetails is ArmResourceActionSync<
    EnterpriseMccCacheNodeResource,
    void,
    MccCacheNodeInstallDetails
  >;
  @added(Versions.v2024_11_30_preview)
  @doc("This api gets ispCacheNode resource auto update histrory information")
  getCacheNodeAutoUpdateHistory is ArmResourceActionSync<
    EnterpriseMccCacheNodeResource,
    void,
    MccCacheNodeAutoUpdateHistory
  >;
  @added(Versions.v2024_11_30_preview)
  @doc("This api gets ispCacheNode resource issues details histrory information")
  getCacheNodeMccIssueDetailsHistory is ArmResourceActionSync<
    EnterpriseMccCacheNodeResource,
    void,
    MccCacheNodeIssueHistory
  >;
  @added(Versions.v2024_11_30_preview)
  @doc("This api gets ispCacheNode resource tls certificate histrory information")
  getCacheNodeTlsCertificateHistory is ArmResourceActionSync<
    EnterpriseMccCacheNodeResource,
    void,
    MccCacheNodeTlsCertificateHistory
  >;
}

@@visibility(Azure.ResourceManager.TrackedResource.properties,
  Lifecycle.Create,
  Lifecycle.Update,
  Lifecycle.Read
);
