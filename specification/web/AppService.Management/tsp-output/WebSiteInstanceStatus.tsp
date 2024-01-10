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

@parentResource(Site)
model WebSiteInstanceStatus is ProxyResource<WebSiteInstanceStatusProperties> {
  @key("instanceId")
  @segment("instances")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface WebSiteInstanceStatuses_WebApps {
  @doc("Description for Gets all scale-out instances of an app.")
  getInstanceInfo is ArmResourceRead<WebSiteInstanceStatus>;

  @doc("Description for Gets all scale-out instances of an app.")
  listInstanceIdentifiers is ArmResourceListByParent<WebSiteInstanceStatus>;
}
