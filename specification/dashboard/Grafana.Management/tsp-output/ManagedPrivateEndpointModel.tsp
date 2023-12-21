import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Grafana;
@doc("The managed private endpoint resource type.")
@parentResource(ManagedGrafana)
model ManagedPrivateEndpointModel
  is TrackedResource<ManagedPrivateEndpointModelProperties> {
  @doc("The managed private endpoint name of Azure Managed Grafana.")
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  @doc("Get a specific managed private endpoint of a grafana resource.")
  get is ArmResourceRead<ManagedPrivateEndpointModel>;
  @doc("Create or update a managed private endpoint for a grafana resource.")
  create is ArmResourceCreateOrUpdateAsync<ManagedPrivateEndpointModel>;
  @doc("Update a managed private endpoint for an existing grafana resource.")
  update is ArmTagsPatchAsync<ManagedPrivateEndpointModel>;
  @doc("Delete a managed private endpoint for a grafana resource.")
  delete is ArmResourceDeleteAsync<ManagedPrivateEndpointModel>;
  @doc("List all managed private endpoints of a grafana resource.")
  list is ArmResourceListByParent<ManagedPrivateEndpointModel>;
}
