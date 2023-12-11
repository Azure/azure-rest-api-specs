import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageMover;
@doc("The Endpoint resource, which contains information about file sources and targets.")
@parentResource(StorageMover)
model StorageMoverEndpoint is ProxyResource<EndpointBaseProperties> {
  @doc("The name of the Endpoint resource.")
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface StorageMoverEndpoints {
  @doc("Gets an Endpoint resource.")
  get is ArmResourceRead<StorageMoverEndpoint>;
  @doc("Creates or updates an Endpoint resource, which represents a data transfer source or destination.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageMoverEndpoint>;
  @doc("Updates properties for an Endpoint resource. Properties not specified in the request body will be unchanged.")
  update is ArmResourcePatchSync<StorageMoverEndpoint, EndpointBaseProperties>;
  @doc("Deletes an Endpoint resource.")
  delete is ArmResourceDeleteAsync<StorageMoverEndpoint>;
  @doc("Lists all Endpoints in a Storage Mover.")
  list is ArmResourceListByParent<StorageMoverEndpoint>;
}
