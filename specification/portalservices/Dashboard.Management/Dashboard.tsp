import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.PortalServices;
@doc("The shared dashboard resource definition.")
@resource("dashboards")
model Dashboard
  is Azure.ResourceManager.TrackedResource<DashboardPropertiesWithProvisioningState> {
  @doc("The name of the dashboard.")
  @maxLength(64)
  @minLength(1)
  @pattern("^(?!con$|prn$|aux$|nul$|com[1-9]$)(?!.*[._-]{2,})[a-zA-Z0-9]([a-zA-Z0-9-._]*[a-zA-Z0-9])?$")
  @key("dashboardName")
  @segment("dashboards")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface Dashboards {
  @doc("Gets the Dashboard.")
  get is ArmResourceRead<Dashboard>;
  @doc("Creates or updates a Dashboard.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Dashboard>;
  @doc("Updates an existing Dashboard.")
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<Dashboard, PatchableDashboard>;
  @doc("Deletes the Dashboard.")
  delete is ArmResourceDeleteSync<Dashboard>;
  @doc("Gets all the Dashboards within a resource group.")
  listByResourceGroup is ArmResourceListByParent<Dashboard>;
  @doc("Gets all the dashboards within a subscription.")
  listBySubscription is ArmListBySubscription<Dashboard>;
}
