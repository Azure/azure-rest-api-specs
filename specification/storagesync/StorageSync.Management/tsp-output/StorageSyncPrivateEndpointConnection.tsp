import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageSync;
@doc("The Private Endpoint Connection resource.")
@parentResource(StorageSyncService)
model StorageSyncPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface StorageSyncPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the storage sync service.")
  get is ArmResourceRead<StorageSyncPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the storage sync service.")
  create is ArmResourceCreateOrUpdateAsync<StorageSyncPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the storage sync service.")
  delete is ArmResourceDeleteAsync<StorageSyncPrivateEndpointConnection>;
  @doc("Get a PrivateEndpointConnection List.")
  listByStorageSyncService is ArmResourceListByParent<StorageSyncPrivateEndpointConnection>;
}
