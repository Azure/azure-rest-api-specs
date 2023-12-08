import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("Class representing a managed private endpoint.")
@parentResource(KustoCluster)
model KustoManagedPrivateEndpoint
  is ProxyResource<ManagedPrivateEndpointProperties> {
  @doc("The name of the managed private endpoint.")
  @pattern("^.*$")
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface KustoManagedPrivateEndpoints {
  @doc("Gets a managed private endpoint.")
  get is ArmResourceRead<KustoManagedPrivateEndpoint>;
  @doc("Creates a managed private endpoint.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoManagedPrivateEndpoint>;
  @doc("Updates a managed private endpoint.")
  update is ArmResourcePatchAsync<
    KustoManagedPrivateEndpoint,
    ManagedPrivateEndpointProperties
  >;
  @doc("Deletes a managed private endpoint.")
  delete is ArmResourceDeleteAsync<KustoManagedPrivateEndpoint>;
  @doc("Returns the list of managed private endpoints.")
  list is ArmResourceListByParent<KustoManagedPrivateEndpoint>;
}
