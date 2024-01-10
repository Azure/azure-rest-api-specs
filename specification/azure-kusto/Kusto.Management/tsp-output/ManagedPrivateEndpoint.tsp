import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
@doc("Class representing a managed private endpoint.")
@parentResource(Cluster)
model ManagedPrivateEndpoint
  is ProxyResource<ManagedPrivateEndpointProperties> {
  @doc("The name of the managed private endpoint.")
  @pattern("^.*$")
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  @doc("Gets a managed private endpoint.")
  get is ArmResourceRead<ManagedPrivateEndpoint>;

  @doc("Creates a managed private endpoint.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedPrivateEndpoint>;

  @doc("Updates a managed private endpoint.")
  update is ArmCustomPatchAsync<ManagedPrivateEndpoint, ManagedPrivateEndpoint>;

  @doc("Deletes a managed private endpoint.")
  delete is ArmResourceDeleteAsync<ManagedPrivateEndpoint>;

  @doc("Returns the list of managed private endpoints.")
  list is ArmResourceListByParent<ManagedPrivateEndpoint>;
}
