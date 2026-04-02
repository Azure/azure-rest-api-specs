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
