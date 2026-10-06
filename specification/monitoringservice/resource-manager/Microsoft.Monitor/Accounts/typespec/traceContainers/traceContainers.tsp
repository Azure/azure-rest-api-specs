import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * Operations for the trace container of an Azure Monitor Workspace.
   */
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
    createOrUpdate is ArmResourceCreateOrReplaceSync<TraceContainerResource>;

    /**
     * Deletes the trace container for an Azure Monitor Workspace.
     */
    delete is ArmResourceDeleteSync<TraceContainerResource>;

    /**
     * Lists trace containers for an Azure Monitor Workspace.
     */
    listByAzureMonitorWorkspace is ArmResourceListByParent<TraceContainerResource>;
  }
}
