import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageSync;
@doc("Server Endpoint object.")
@parentResource(StorageSyncGroup)
model StorageSyncServerEndpoint is ProxyResource<ServerEndpointProperties> {
  @doc("Name of Server Endpoint object.")
  @path
  @key("serverEndpointName")
  @segment("serverEndpoints")
  name: string;
}

@armResourceOperations
interface StorageSyncServerEndpoints {
  @doc("Get a ServerEndpoint.")
  get is ArmResourceRead<StorageSyncServerEndpoint>;
  @doc("Create a new ServerEndpoint.")
  create is ArmResourceCreateOrUpdateAsync<StorageSyncServerEndpoint>;
  @doc("Patch a given ServerEndpoint.")
  update is ArmResourcePatchAsync<
    StorageSyncServerEndpoint,
    ServerEndpointProperties
  >;
  @doc("Delete a given ServerEndpoint.")
  delete is ArmResourceDeleteAsync<StorageSyncServerEndpoint>;
  @doc("Get a ServerEndpoint list.")
  listBySyncGroup is ArmResourceListByParent<StorageSyncServerEndpoint>;
  @doc("Recall a server endpoint.")
  recallAction is ArmResourceActionAsync<
    StorageSyncServerEndpoint,
    RecallActionParameters,
    void
  >;
}
