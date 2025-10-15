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
  model AzureMonitorWorkspaceProperties {
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
    @identifiers(#["id"])
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
    dataCollectionRuleResourceId?: Azure.Core.armResourceIdentifier;

    /**
     * The Azure resource Id of the default data collection endpoint for this Azure Monitor Workspace.
     */
    @visibility(Lifecycle.Read)
    dataCollectionEndpointResourceId?: Azure.Core.armResourceIdentifier;

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
     * Geneva Metrics limits.
     */
    limits?: MetricsLimits;
  }

  /**
   * Properties of an Export Rule
   */
  model ExportRule {
    /**
     * Description of the export rule
     */
    description?: string;

    /**
     * The immutable ID of the export rule. This property is READ-ONLY.
     */
    @visibility(Lifecycle.Read)
    immutableId?: string;

    /**
     * Metrics to be exported
     */
    @identifiers(#[])
    metrics: ExportRuleMetric[];

    /**
     * Destinations for the export rule
     */
    destinations: ExportRuleDestinations;

    /**
     * The provisioning state of the export rule
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * Metadata about the resource
     */
    @visibility(Lifecycle.Read)
    metadata?: Metadata;
  }

  /**
   * Export rule metric definition
   */
  model ExportRuleMetric {
    /**
     * Namespace of the metric to export
     */
    metricNamespace?: string;

    /**
     * Name of the metric to export
     */
    metricName?: string;

    /**
     * Type of the metric to export
     */
    metricType?: string;

    /**
     * Dimensions of the metric to export
     */
    @visibility(Lifecycle.Read)
    dimensions?: string[];
  }

  /**
   * Export rule destinations configuration
   */
  model ExportRuleDestinations {
    /**
     * Event Hub destinations for the export rule
     */
    eventHubs?: ExportRuleEventHubDestination[];

    /**
     * Storage destinations for the export rule
     */
    storageAccounts?: ExportRuleStorageDestination[];
  }

  /**
   * Event Hub destination for export rule
   */
  model ExportRuleEventHubDestination {
    /**
     * A friendly name for the destination
     */
    name: string;

    /**
     * The resource ID of the Event Hub
     */
    eventHubResourceId: string;
  }

  /**
   * Azure Storage destination for export rule
   */
  model ExportRuleStorageDestination {
    /**
     * A friendly name for the destination
     */
    name: string;

    /**
     * The resource ID of the Storage Account
     */
    storageAccountResourceId: Azure.Core.armResourceIdentifier;

    /**
     * The container name in the Storage Account.
     * The container name must start with a letter or number, use only lowercase letters, numbers, and hyphens, and avoid consecutive hyphens.
     */
    @pattern("^(?!-)(?!.*--)[a-z0-9-]{3,63}(?<!-)$")
    containerName?: string;
  }

  /**
   * Metadata about the resource
   */
  model Metadata {
    /**
     * Azure offering managing this resource on-behalf-of customer.
     */
    @visibility(Lifecycle.Read)
    provisionedBy?: string;

    /**
     * Resource Id of azure offering managing this resource on-behalf-of customer.
     */
    @visibility(Lifecycle.Read)
    provisionedByResourceId?: string;

    /**
     * Immutable Id of azure offering managing this resource on-behalf-of customer.
     */
    @visibility(Lifecycle.Read)
    provisionedByImmutableId?: string;
  }

  /**
   * Export Rule resource for an Azure Monitor Workspace
   */
  @parentResource(AzureMonitorWorkspaceResource)
  model ExportRuleResource is Azure.ResourceManager.ProxyResource<ExportRule> {
    ...ResourceNameParameter<
      Resource = ExportRule,
      KeyName = "exportRuleName",
      SegmentName = "exportRules",
      NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{0,63}$"
    >;
  }
}
