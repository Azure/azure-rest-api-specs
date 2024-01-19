import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
@doc("Registered Server resource.")
@parentResource(StorageSyncService)
model RegisteredServer is ProxyResource<RegisteredServerProperties> {
  @doc("GUID identifying the on-premises server.")
  @path
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Triggers Server certificate rollover.")
  @operationId("RegisteredServers_triggerRollover")
  triggerRollover is ArmResourceActionAsync<
    RegisteredServer,
    TriggerRolloverRequest,
    void
  >;
}

@@projectedName(RegisteredServers.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(RegisteredServers.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(RegisteredServers.create::parameters.resource,
  "Body of Registered Server object."
);
@@projectedName(RegisteredServers.triggerRollover::parameters.body,
  "json",
  "parameters"
);
@@extension(RegisteredServers.triggerRollover::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(RegisteredServers.triggerRollover::parameters.body,
  "Body of Trigger Rollover request."
);
