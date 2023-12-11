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
@doc("Registered Server resource.")
@parentResource(StorageSyncService)
model StorageSyncRegisteredServer is ProxyResource<RegisteredServerProperties> {
  @doc("GUID identifying the on-premises server.")
  @path
  @key("serverId")
  @segment("registeredServers")
  name: string;
}

@armResourceOperations
interface StorageSyncRegisteredServers {
  @doc("Get a given registered server.")
  get is ArmResourceRead<StorageSyncRegisteredServer>;
  @doc("Add a new registered server.")
  create is ArmResourceCreateOrUpdateAsync<StorageSyncRegisteredServer>;
  @doc("Delete the given registered server.")
  delete is ArmResourceDeleteAsync<StorageSyncRegisteredServer>;
  @doc("Get a given registered server list.")
  listByStorageSyncService is ArmResourceListByParent<StorageSyncRegisteredServer>;
  @doc("Triggers Server certificate rollover.")
  triggerRollover is ArmResourceActionAsync<
    StorageSyncRegisteredServer,
    TriggerRolloverRequest,
    {}
  >;
}
