import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Description of the parameters of Private Access for a Web Site.")
@singleton("virtualNetworks")
@parentResource(Site)
model PrivateAccess is ProxyResource<PrivateAccessProperties> {
  @key("privateAccess")
  @segment("privateAccess")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface PrivateAccesses_WebApps {
  @doc("Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  getPrivateAccess is ArmResourceRead<PrivateAccess>;

  @doc("Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  putPrivateAccessVnet is ArmResourceCreateOrReplaceSync<PrivateAccess>;
}
