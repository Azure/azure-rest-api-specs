import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ispCustomers.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ConnectedCache;

@doc("Represents the high level Nodes needed to provision cache node resources")
@parentResource(IspCustomerResource)
model IspCacheNodeResource is TrackedResource<CacheNodeProperty> {
  @doc("Name of the ConnectedCache resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("cacheNodeResourceName")
  @segment("ispCacheNodes")
  @path
  name: string;
}

@armResourceOperations
interface IspCacheNodesOperations {
  @doc("This api gets ispCacheNode resource information")
  get is ArmResourceRead<IspCacheNodeResource>;
  @doc("This api creates an ispCacheNode with the specified create parameters")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IspCacheNodeResource>;
  @doc("This api updates an existing ispCacheNode resource")
  update is ArmCustomPatchSync<
    IspCacheNodeResource,
    ConnectedCachePatchResource
  >;
  @doc("This api deletes an existing ispCacheNode resource")
  delete is ArmResourceDeleteWithoutOkAsync<IspCacheNodeResource>;
  @doc("This api retrieves information about all ispCacheNode resources under the given subscription and resource group")
  listByIspCustomerResource is ArmResourceListByParent<IspCacheNodeResource>;
  @doc("This api gets ispCacheNode resource information")
  getBgpCidrs is ArmResourceActionSync<
    IspCacheNodeResource,
    void,
    MccCacheNodeBgpCidrDetails
  >;
  @doc("This api gets secrets of the ispCacheNode resource install details")
  getCacheNodeInstallDetails is ArmResourceActionSync<
    IspCacheNodeResource,
    void,
    MccCacheNodeInstallDetails
  >;
  @added(Versions.v2024_11_30_preview)
  @doc("This api gets ispCacheNode resource auto update histrory information")
  getCacheNodeAutoUpdateHistory is ArmResourceActionSync<
    IspCacheNodeResource,
    void,
    MccCacheNodeAutoUpdateHistory
  >;
  @added(Versions.v2024_11_30_preview)
  @doc("This api gets ispCacheNode resource issues details histrory information")
  getCacheNodeMccIssueDetailsHistory is ArmResourceActionSync<
    IspCacheNodeResource,
    void,
    MccCacheNodeIssueHistory
  >;
}
