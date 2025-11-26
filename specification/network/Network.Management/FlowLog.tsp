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
@parentResource(NetworkWatcher)
model FlowLog
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<FlowLogPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = FlowLog,
    KeyName = "flowLogName",
    SegmentName = "flowLogs",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * FlowLog resource Managed Identity
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface FlowLogs {
  /**
   * Gets a flow log resource by name.
   */
  get is ArmResourceRead<FlowLog, Error = CloudError>;

  /**
   * Create or update a flow log for the specified network security group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FlowLog,
    Error = CloudError
  >;

  /**
   * Update tags of the specified flow log.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    FlowLog,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified flow log resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FlowLog, Error = CloudError>;

  /**
   * Lists all flow log resources for the specified Network Watcher.
   */
  list is ArmResourceListByParent<FlowLog, Error = CloudError>;
}

@@doc(FlowLog.name, "The name of the flow log resource.");
@@doc(FlowLog.properties, "Properties of the flow log.");
@@doc(FlowLogs.createOrUpdate::parameters.resource,
  "Parameters that define the create or update flow log resource."
);
@@doc(FlowLogs.updateTags::parameters.properties,
  "Parameters supplied to update flow log tags."
);
