import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CdnEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("Origin group comprising of origins is used for load balancing to origins when the content cannot be served from CDN.")
@parentResource(CdnEndpoint)
model CdnOriginGroup is ProxyResource<OriginGroupProperties> {
  @doc("Name of the origin group which is unique within the endpoint.")
  @key("originGroupName")
  @segment("originGroups")
  name: string;
}

@armResourceOperations
interface CdnOriginGroups {
  @doc("Gets an existing origin group within an endpoint.")
  get is ArmResourceRead<CdnOriginGroup>;
  @doc("Creates a new origin group within the specified endpoint.")
  create is ArmResourceCreateOrUpdateAsync<CdnOriginGroup>;
  @doc("Updates an existing origin group within an endpoint.")
  update is ArmCustomPatchAsync<CdnOriginGroup, OriginGroupUpdateParameters>;
  @doc("Deletes an existing origin group within an endpoint.")
  delete is ArmResourceDeleteAsync<CdnOriginGroup>;
  @doc("Lists all of the existing origin groups within an endpoint.")
  listByEndpoint is ArmResourceListByParent<CdnOriginGroup>;
}
