import "../models.tsp";

using TypeSpec.Rest;
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
