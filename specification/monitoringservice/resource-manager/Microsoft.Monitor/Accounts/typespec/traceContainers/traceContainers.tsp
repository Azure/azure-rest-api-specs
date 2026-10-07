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
     * Creates or replaces the trace container for an Azure Monitor Workspace. Completes synchronously (200) or, when provisioning is long-running, returns 202 and is tracked as a long-running operation.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The trace container PUT is a mixed sync/async operation: it returns 200 when it completes synchronously and 202 (Location-polled LRO) when provisioning is long-running. 201 is intentionally not used."
    createOrUpdate is ArmResourceCreateOrReplaceAsync<
      TraceContainerResource,
      Response = ArmResourceUpdatedResponse<TraceContainerResource> | ArmAcceptedLroResponse<"Trace container create or replace request accepted.">
    >;

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
