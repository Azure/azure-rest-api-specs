import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkWatcher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Information about the connection monitor.
 */
@parentResource(NetworkWatcher)
model ConnectionMonitorResult
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ConnectionMonitorResultProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionMonitorResult,
    KeyName = "connectionMonitorName",
    SegmentName = "connectionMonitors",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ConnectionMonitorResults {
  /**
   * Gets a connection monitor by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_Get")
  get is ArmResourceRead<ConnectionMonitorResult, Error = ErrorResponse>;

  /**
   * Create or update a connection monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ConnectionMonitorResult,
    Request = ConnectionMonitor,
    Parameters = {
      /**
       * Value indicating whether connection monitor V1 should be migrated to V2 format.
       */
      @query("migrate")
      migrate?: string;
    }
  >;

  /**
   * Update tags of the specified connection monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ConnectionMonitorResult,
    PatchModel = TagsObject,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified connection monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectionMonitorResult,
    Error = ErrorResponse
  >;

  /**
   * Lists all connection monitors for the specified Network Watcher.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_List")
  list is ArmResourceListByParent<
    ConnectionMonitorResult,
    Response = ArmResponse<ConnectionMonitorListResult>,
    Error = ErrorResponse
  >;

  /**
   * Stops the specified connection monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionMonitors_Stop")
  stop is ArmResourceActionAsync<
    ConnectionMonitorResult,
    void,
    OkResponse,
    Error = ErrorResponse
  >;
}

@@doc(ConnectionMonitorResult.name, "The name of the connection monitor.");
@@doc(ConnectionMonitorResult.properties,
  "Properties of the connection monitor result."
);
@@doc(ConnectionMonitorResults.createOrUpdate::parameters.resource,
  "Parameters that define the operation to create a connection monitor."
);
@@doc(ConnectionMonitorResults.updateTags::parameters.properties,
  "Parameters supplied to update connection monitor tags."
);
