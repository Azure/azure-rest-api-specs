import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StorageSync;
@doc("The Private Endpoint Connection resource.")
@parentResource(StorageSyncService)
model MicrosoftStorageSyncPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface MicrosoftStorageSyncPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the storage sync service.")
  get is ArmResourceRead<MicrosoftStorageSyncPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the storage sync service.")
  create is ArmResourceCreateOrUpdateAsync<MicrosoftStorageSyncPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the storage sync service.")
  delete is ArmResourceDeleteAsync<MicrosoftStorageSyncPrivateEndpointConnection>;
  @doc("Get a PrivateEndpointConnection List.")
  listByStorageSyncService is ArmResourceListByParent<MicrosoftStorageSyncPrivateEndpointConnection>;
}
