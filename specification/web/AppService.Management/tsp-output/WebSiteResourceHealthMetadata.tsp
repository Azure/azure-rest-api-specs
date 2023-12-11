import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Used for getting ResourceHealthCheck settings.")
@parentResource(WebSite)
@singleton("default")
model WebSiteResourceHealthMetadata
  is ProxyResource<ResourceHealthMetadataProperties> {
  @key("default")
  @segment("resourceHealthMetadata")
  name: string;
}

@armResourceOperations
interface WebSiteResourceHealthMetadata {
  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site")
  getBySite is ArmResourceRead<WebSiteResourceHealthMetadata>;
  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  listByWebSite is ArmResourceListByParent<WebSiteResourceHealthMetadata>;
}
