import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Monitor {

    /**
   * Definition of Geneva Metrics limits
   */
  model MacMetricsLimits {
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
  model MacMetricsContainer {
    /**
     * The provisioning state of the metrics container.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * Geneva Metrics limits.
     */
    limits?: MacMetricsLimits;
  }

  /**
   * Metrics container resource for an Azure Monitor Workspace.
   */
  @parentResource(AzureMonitorWorkspaceResource)
  model MacMetricsContainerResource
    is Azure.ResourceManager.ProxyResource<MacMetricsContainer> {
    ...ResourceNameParameter<
      Resource = MacMetricsContainer,
      KeyName = "metricsContainerName",
      SegmentName = "metricsContainers",
      /**
       * The name of the metrics container. Always 'default'.
       */
      NamePattern = "^default$"
    >;
  }
}
