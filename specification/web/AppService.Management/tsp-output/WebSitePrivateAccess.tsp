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
@doc("Description of the parameters of Private Access for a Web Site.")
@parentResource(WebSite)
@singleton("virtualNetworks")
model WebSitePrivateAccess is ProxyResource<PrivateAccessProperties> {
  @key("virtualNetworks")
  @segment("privateAccess")
  name: string;
}

@armResourceOperations
interface WebSitePrivateAccesses {
  @doc("Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  getPrivateAccess is ArmResourceRead<WebSitePrivateAccess>;
  @doc("Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  putPrivateAccessVnet is ArmResourceCreateOrReplaceSync<WebSitePrivateAccess>;
}
