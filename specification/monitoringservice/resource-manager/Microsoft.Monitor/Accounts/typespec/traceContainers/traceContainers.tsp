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
     * Creates or replaces the trace container for an Azure Monitor Workspace. Modeled as a long-running operation (200 + 201); the service may complete synchronously by returning a terminal provisioningState, or track progress via Azure-AsyncOperation.
     */
    createOrUpdate is ArmResourceCreateOrReplaceAsync<TraceContainerResource>;

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
