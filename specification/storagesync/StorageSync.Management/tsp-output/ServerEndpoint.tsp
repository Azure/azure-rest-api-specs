import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageSync;
@doc("Server Endpoint object.")
@parentResource(SyncGroup)
model ServerEndpoint is ProxyResource<ServerEndpointProperties> {
  @doc("Name of Server Endpoint object.")
  @key("serverEndpointName")
  @segment("serverEndpoints")
  name: string;
}

@armResourceOperations
interface ServerEndpoints {
  @doc("Get a ServerEndpoint.")
  get is ArmResourceRead<ServerEndpoint>;
  @doc("Create a new ServerEndpoint.")
  create is ArmResourceCreateOrUpdateAsync<ServerEndpoint>;
  @doc("Patch a given ServerEndpoint.")
  update is ArmCustomPatchAsync<ServerEndpoint, ServerEndpointUpdateParameters>;
  @doc("Delete a given ServerEndpoint.")
  delete is ArmResourceDeleteAsync<ServerEndpoint>;
  @doc("Get a ServerEndpoint list.")
  listBySyncGroup is ArmResourceListByParent<ServerEndpoint>;
  @doc("Recall a server endpoint.")
  recallAction is ArmResourceActionAsync<
    ServerEndpoint,
    RecallActionParameters,
    void
  >;
}
