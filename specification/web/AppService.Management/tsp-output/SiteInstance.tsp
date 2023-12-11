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

@parentResource(WebSite)
model SiteInstance is ProxyResource<WebSiteInstanceStatusProperties> {
  @path
  @key("instanceId")
  @segment("instances")
  name: string;
}

@armResourceOperations
interface SiteInstances {
  @doc("Description for Gets all scale-out instances of an app.")
  getInstanceInfo is ArmResourceRead<SiteInstance>;
  @doc("Description for Gets all scale-out instances of an app.")
  listInstanceIdentifiers is ArmResourceListByParent<SiteInstance>;
}
