import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoorOriginGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("CDN origin is the source of the content being delivered via CDN. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.")
@parentResource(FrontDoorOriginGroup)
model FrontDoorOrigin is ProxyResource<AFDOriginProperties> {
  @doc("Name of the origin which is unique within the profile.")
  @path
  @key("originName")
  @segment("origins")
  name: string;
}

@armResourceOperations
interface FrontDoorOrigins {
  @doc("Gets an existing origin within an origin group.")
  get is ArmResourceRead<FrontDoorOrigin>;
  @doc("Creates a new origin within the specified origin group.")
  create is ArmResourceCreateOrUpdateAsync<FrontDoorOrigin>;
  @doc("Updates an existing origin within an origin group.")
  update is ArmResourcePatchAsync<FrontDoorOrigin, AFDOriginProperties>;
  @doc("Deletes an existing origin within an origin group.")
  delete is ArmResourceDeleteAsync<FrontDoorOrigin>;
  @doc("Lists all of the existing origins within an origin group.")
  listByOriginGroup is ArmResourceListByParent<FrontDoorOrigin>;
}
