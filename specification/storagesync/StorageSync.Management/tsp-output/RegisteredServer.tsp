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
/**
 * Registered Server resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StorageSyncService)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(RegisteredServerProperties)
model RegisteredServer extends ProxyResourceBase {
  /**
   * GUID identifying the on-premises server.
   */
  @path
  @key("serverId")
  @segment("registeredServers")
  @visibility("read")
  name: string;

  /**
   * RegisteredServer properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RegisteredServerProperties;
}

@armResourceOperations
interface RegisteredServers {
  /**
   * Get a given registered server.
   */
  get is ArmResourceRead<RegisteredServer>;

  /**
   * Add a new registered server.
   */
  create is ArmResourceCreateOrReplaceAsync<RegisteredServer>;

  /**
   * Delete the given registered server.
   */
  delete is ArmResourceDeleteAsync<RegisteredServer>;

  /**
   * Get a given registered server list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegisteredServers_ListByStorageSyncService")
  listByStorageSyncService is ArmResourceListByParent<RegisteredServer>;

  /**
   * Triggers Server certificate rollover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
