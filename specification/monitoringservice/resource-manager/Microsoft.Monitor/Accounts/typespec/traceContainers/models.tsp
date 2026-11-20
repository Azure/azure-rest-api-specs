import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models.tsp";
import "../service.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * The state of trace-derived metrics for a trace container.
   */
  @added(Versions.v2026_09_03_preview)
  union TraceMetricsState {
    string,

    /**
     * Trace-derived metrics are emitted.
     */
    Enabled: "Enabled",

    /**
     * Trace-derived metrics are not emitted.
     */
    Disabled: "Disabled",
  }

  /**
   * Properties of a trace container.
   */
  @added(Versions.v2026_09_03_preview)
  model TraceContainer {
    /**
     * The provisioning state of the trace container.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * The trace duration window in seconds.
     */
    @minValue(120)
    @maxValue(600)
    traceDurationWindowInSeconds: int32;

    /**
     * The number of days for which the traces are retained. Value must be between 4 and 730 days.
     */
    @minValue(4)
    @maxValue(730)
    traceRetentionInDays: int32;

    /**
     * Controls whether trace-derived metrics are emitted for this trace container.
     */
    traceMetricsState: TraceMetricsState;
  }

  /**
   * The trace container for an Azure Monitor Workspace.
   */
  @added(Versions.v2026_09_03_preview)
  @singleton("default")
  @parentResource(AzureMonitorWorkspaceResource)
  model TraceContainerResource
    is Azure.ResourceManager.ProxyResource<TraceContainer> {
    ...ResourceNameParameter<
      Resource = TraceContainerResource,
      KeyName = "traceContainerName",
      SegmentName = "traceContainers",
      /**
       * The name of the trace container. Always 'default'.
       */
      NamePattern = "^default$"
    >;
  }
}
