import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkWatcher.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;
/**
 * Information about the connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NetworkWatcher)
model ConnectionMonitorResult extends TrackedResourceWithEtag {
  /**
   * Properties of the connection monitor result.
   */
  properties?: ConnectionMonitorResultProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("connectionMonitorName")
  @segment("connectionMonitors")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@armResourceOperations(#{ omitTags: true })
interface ConnectionMonitorResults {
  /**
   * Gets a connection monitor by name.
   */
  @tag("ConnectionMonitors")
  get is ArmResourceRead<ConnectionMonitorResult, Error = ErrorResponse>;

  /**
   * Create or update a connection monitor.
   */
  @tag("ConnectionMonitors")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ConnectionMonitorResult,
    Request = ConnectionMonitor,
    Parameters = {
      /**
       * Value indicating whether connection monitor V1 should be migrated to V2 format.
       */
      @query("migrate")
      migrate?: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Update tags of the specified connection monitor.
   */
  @tag("ConnectionMonitors")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ConnectionMonitorResult,
    PatchModel = TagsObject,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified connection monitor.
   */
  @tag("ConnectionMonitors")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectionMonitorResult,
    Error = ErrorResponse
  >;

  /**
   * Lists all connection monitors for the specified Network Watcher.
   */
  @tag("ConnectionMonitors")
  list is ArmResourceListByParent<
    ConnectionMonitorResult,
    Response = ArmResponse<ConnectionMonitorListResult>,
    Error = ErrorResponse
  >;

  /**
   * Stops the specified connection monitor.
   */
  @tag("ConnectionMonitors")
  stop is ArmResourceActionAsync<
    ConnectionMonitorResult,
    void,
    Response = {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>,
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
