import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Grafana;
@doc("The grafana resource type.")
model ManagedGrafana is TrackedResource<ManagedGrafanaProperties> {
  @doc("The workspace name of Azure Managed Grafana.")
  @path
  @key("workspaceName")
  @segment("grafana")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Grafana {
  @doc("Get the properties of a specific workspace for Grafana resource.")
  get is ArmResourceRead<ManagedGrafana>;
  @doc("Create or update a workspace for Grafana resource. This API is idempotent, so user can either create a new grafana or update an existing grafana.")
  create is ArmResourceCreateOrUpdateAsync<ManagedGrafana>;
  @doc("Update a workspace for Grafana resource.")
  update is ArmResourcePatchSync<ManagedGrafana, ManagedGrafanaProperties>;
  @doc("Delete a workspace for Grafana resource.")
  delete is ArmResourceDeleteAsync<ManagedGrafana>;
  @doc("List all resources of workspaces for Grafana under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<ManagedGrafana>;
  @doc("List all resources of workspaces for Grafana under the specified subscription.")
  list is ArmListBySubscription<ManagedGrafana>;
  @doc("Retrieve enterprise add-on details information")
  checkEnterpriseDetails is ArmResourceActionSync<
    ManagedGrafana,
    void,
    EnterpriseDetails
  >;

  fetchAvailablePlugins is ArmResourceActionSync<
    ManagedGrafana,
    void,
    GrafanaAvailablePluginListResponse
  >;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  @doc("Refresh and sync managed private endpoints of a grafana resource to latest state.")
  refresh is ArmResourceActionAsync<ManagedGrafana, void, void>;
}
