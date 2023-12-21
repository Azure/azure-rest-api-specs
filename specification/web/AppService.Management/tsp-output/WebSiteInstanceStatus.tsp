import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;

@parentResource(Site)
model WebSiteInstanceStatus is ProxyResource<WebSiteInstanceStatusProperties> {
  @path
  @key("instanceId")
  @segment("instances")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Gets all scale-out instances of an app.")
  getInstanceInfo is ArmResourceRead<WebSiteInstanceStatus>;
  @doc("Description for Gets all scale-out instances of an app.")
  listInstanceIdentifiers is ArmResourceListByParent<WebSiteInstanceStatus>;
}
