import "@typespec/versioning";
import "../models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Monitor {
  /**
   * Definition of Metrics limits
   */
  model MetricsLimits {
    /**
     * Indicates whether automatic scaling of ingestion limits is enabled.
     * Omit this property or specify null to preserve the existing automatic scaling mode.
     */
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "The deployed API distinguishes explicit null and accepts it to preserve the existing mode."
    @added(Versions.v2026_09_03_preview)
    enableAutoScale?: boolean | null;

    /**
     * Maximum number of active time series allowed on the metrics containers.
     */
    maxActiveTimeSeries?: int64;

    /**
     * Maximum rate (events per minute) that can be processed on the metrics containers.
     */
    maxEventsPerMinute?: int64;
  }

  /**
   * Properties of a metrics container.
   */
  model MetricsContainer {
    /**
     * The provisioning state of the metrics container.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * Metrics limits.
     */
    @removed(Versions.v2025_10_03_stable)
    @added(Versions.v2026_09_03_preview)
    limits?: MetricsLimits;

    /**
     * The version of Metrics Query Service that this AMW will use for all metric queries.
     */
    @added(Versions.v2025_10_03)
    @example("1.0", #{ title: "Version example" })
    version?: string;
  }

  /**
   * Metrics container resource for an Azure Monitor Workspace.
   */
  @parentResource(AzureMonitorWorkspaceResource)
  model MetricsContainerResource
    is Azure.ResourceManager.ProxyResource<MetricsContainer> {
    ...ResourceNameParameter<
      Resource = MetricsContainer,
      KeyName = "metricsContainerName",
      SegmentName = "metricsContainers",
      /**
       * The name of the metrics container. Always 'default'.
       */
      NamePattern = "^default$"
    >;
  }
}
