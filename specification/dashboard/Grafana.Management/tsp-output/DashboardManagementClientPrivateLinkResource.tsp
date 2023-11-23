import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Dashboard;
@doc("A private link resource")
@parentResource(ManagedGrafana)
model DashboardManagementClientPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface DashboardManagementClientPrivateLinkResources {
  @doc("Get specific private link resource information for this grafana resource")
  get is ArmResourceRead<DashboardManagementClientPrivateLinkResource>;
  @doc("List all private link resources information for this grafana resource")
  list is ArmResourceListByParent<DashboardManagementClientPrivateLinkResource>;
}
