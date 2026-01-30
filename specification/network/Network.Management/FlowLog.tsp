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
 * A flow log resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@parentResource(NetworkWatcher)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FlowLog extends Resource {
  properties?: FlowLogPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("flowLogName")
  @segment("flowLogs")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * FlowLog resource Managed Identity
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface FlowLogs {
  /**
   * Gets a flow log resource by name.
   */
  get is ArmResourceRead<FlowLog, Error = ErrorResponse>;

  /**
   * Create or update a flow log for the specified network security group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FlowLog,
    Error = ErrorResponse
  >;

  /**
   * Update tags of the specified flow log.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    FlowLog,
    PatchModel = TagsObject,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified flow log resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FlowLog, Error = ErrorResponse>;

  /**
   * Lists all flow log resources for the specified Network Watcher.
   */
  list is ArmResourceListByParent<FlowLog, Error = ErrorResponse>;
}

@@doc(FlowLog.name, "The name of the flow log resource.");
@@doc(FlowLog.properties, "Properties of the flow log.");
@@doc(FlowLogs.createOrUpdate::parameters.resource,
  "Parameters that define the create or update flow log resource."
);
@@doc(FlowLogs.updateTags::parameters.properties,
  "Parameters supplied to update flow log tags."
);
