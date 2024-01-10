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
@doc("Registered Server resource.")
@parentResource(StorageSyncService)
model RegisteredServer is ProxyResource<RegisteredServerProperties> {
  @doc("GUID identifying the on-premises server.")
  @key("serverId")
  @segment("registeredServers")
  name: string;
}

@armResourceOperations
interface RegisteredServers {
  @doc("Get a given registered server.")
  get is ArmResourceRead<RegisteredServer>;

  @doc("Add a new registered server.")
  create is ArmResourceCreateOrUpdateAsync<RegisteredServer>;

  @doc("Delete the given registered server.")
  delete is ArmResourceDeleteAsync<RegisteredServer>;

  @doc("Get a given registered server list.")
  listByStorageSyncService is ArmResourceListByParent<RegisteredServer>;

  @doc("Triggers Server certificate rollover.")
  triggerRollover is ArmResourceActionAsync<
    RegisteredServer,
    TriggerRolloverRequest,
    void
  >;
}
