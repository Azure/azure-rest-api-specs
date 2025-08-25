import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Monitor {
  /**
   * Gets or sets allow or disallow public network access to Azure Monitor Workspace
   */
  union PublicNetworkAccess {
    string,

    /** Public network access is enabled. */
    Enabled: "Enabled",

    /** Public network access is disabled. */
    Disabled: "Disabled",
  }

  /**
   * A pageable list of resources
   */
  model AzureMonitorWorkspaceResourceListResult
    is Page<AzureMonitorWorkspaceResource>;

  /**
   * Properties of an Azure Monitor Workspace
   */
  model AzureMonitorWorkspace {
    /**
     * The immutable Id of the Azure Monitor Workspace. This property is read-only.
     */
    @visibility(Lifecycle.Read)
    accountId?: string;

    /**
     * Properties related to the metrics container in the Azure Monitor Workspace
     */
    @visibility(Lifecycle.Read)
    metrics?: AzureMonitorWorkspaceMetrics;

    /**
     * The provisioning state of the Azure Monitor Workspace. Set to Succeeded if everything is healthy.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * The Data Collection Rule and Endpoint used for ingestion by default.
     */
    @visibility(Lifecycle.Read)
    defaultIngestionSettings?: AzureMonitorWorkspaceDefaultIngestionSettings;

    /**
     * List of private endpoint connections
     */
    @visibility(Lifecycle.Read)
    @TypeSpec.OpenAPI.extension("x-ms-identifiers", #["id"])
    privateEndpointConnections?: Azure.ResourceManager.CommonTypes.PrivateEndpointConnection[];

    /**
     * Gets or sets allow or disallow public network access to Azure Monitor Workspace
     */
    publicNetworkAccess?: PublicNetworkAccess;
  }

  /**
   * Properties related to the metrics container in the Azure Monitor Workspace
   */
  model AzureMonitorWorkspaceMetrics {
    /**
     * The Prometheus query endpoint for the Azure Monitor Workspace
     */
    @visibility(Lifecycle.Read)
    prometheusQueryEndpoint?: string;

    /**
     * An internal identifier for the metrics container. Only to be used by the system.
     */
    @visibility(Lifecycle.Read)
    internalId?: string;

    /**
     * Flag that indicates whether to enable access using resource permissions.
     */
    enableAccessUsingResourcePermissions?: boolean;
  }

  /**
   * The Data Collection Rule and Endpoint used for ingestion by default.
   */
  model AzureMonitorWorkspaceDefaultIngestionSettings {
    /**
     * The Azure resource Id of the default data collection rule for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    dataCollectionRuleResourceId?: string;

    /**
     * The Azure resource Id of the default data collection endpoint for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    dataCollectionEndpointResourceId?: string;

    /**
     * The immutable Id of the default data collection rule for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    dataCollectionRuleImmutableId?: string;

    /**
     * The ingestion endpoints for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    ingestionEndpoints?: IngestionEndpoints;
  }

  /**
   * The ingestion endpoints for an Azure Monitor Workspace.
   */
  model IngestionEndpoints {
    /**
     * The metrics ingestion endpoint for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    metrics?: string;
  }

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
   * An Azure Monitor Workspace definition
   */
  model AzureMonitorWorkspaceResource
    is Azure.ResourceManager.TrackedResource<AzureMonitorWorkspace> {
    ...ResourceNameParameter<
      Resource = AzureMonitorWorkspaceResource,
      KeyName = "azureMonitorWorkspaceName",
      SegmentName = "accounts",
      NamePattern = "^(?!-)[a-zA-Z0-9-]+[^-]$"
    >;
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
