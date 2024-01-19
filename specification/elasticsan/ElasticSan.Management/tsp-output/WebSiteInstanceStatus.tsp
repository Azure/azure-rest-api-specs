import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;

@parentResource(Site)
model WebSiteInstanceStatus is ProxyResource<WebSiteInstanceStatusProperties> {
  @path
  @key("instanceId")
  @segment("instances")
  name: string;
}

@armResourceOperations
interface WebSiteInstanceStatuses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets all scale-out instances of an app.")
  @operationId("WebApps_GetInstanceInfo")
  getInstanceInfo is ArmResourceRead<WebSiteInstanceStatus>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets all scale-out instances of an app.")
  @operationId("WebApps_ListInstanceIdentifiers")
  listInstanceIdentifiers is ArmResourceListByParent<WebSiteInstanceStatus>;
}
