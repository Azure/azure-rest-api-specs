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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The existing synchronous trace container service contract does not expose provisioningState."
  @added(Versions.v2026_09_03_preview)
  model TraceContainer {
    /**
     * The trace duration window in seconds.
     */
    @minValue(120)
    @maxValue(600)
    traceDurationWindowInSeconds: int32;

    /**
     * The state of trace-derived metrics. The service defaults this property to Enabled when it is omitted.
     */
    traceMetricsState?: TraceMetricsState = TraceMetricsState.Enabled;
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
