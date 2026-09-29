import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * Operations for the trace container of an Azure Monitor Workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The trace container is a service-managed singleton and does not support deletion."
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface TraceContainers {
    /**
     * Gets the trace container for an Azure Monitor Workspace.
     */
    get is ArmResourceRead<TraceContainerResource>;

    /**
     * Creates or replaces the trace container for an Azure Monitor Workspace.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The deployed trace container PUT contract returns 200 for both create and update."
    createOrUpdate is ArmResourceCreateOrReplaceSync<
      TraceContainerResource,
      Response = ArmResourceUpdatedResponse<TraceContainerResource>
    >;

    /**
     * Lists trace containers for an Azure Monitor Workspace.
     */
    listByAzureMonitorWorkspace is ArmResourceListByParent<TraceContainerResource>;
  }
}
