import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Monitor;

/**
 * The provisioning state of the Azure Monitor Workspace. Set to Succeeded if everything is healthy.
 */
union ProvisioningState {
  string,
  Creating: "Creating",
  Succeeded: "Succeeded",
  Deleting: "Deleting",
  Failed: "Failed",
  Canceled: "Canceled",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  Pending: "Pending",
  Approved: "Approved",
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,
  Succeeded: "Succeeded",
  Creating: "Creating",
  Deleting: "Deleting",
  Failed: "Failed",
}

/**
 * Gets or sets allow or disallow public network access to Azure Monitor Workspace
 */
union PublicNetworkAccess {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * A pageable list of resources
 */
model AzureMonitorWorkspaceResourceListResult
  is Azure.Core.Page<AzureMonitorWorkspaceResource>;

/**
 * Resource properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureMonitorWorkspaceResourceProperties extends AzureMonitorWorkspace {}

/**
 * Properties of an Azure Monitor Workspace
 */
model AzureMonitorWorkspace {
  /**
   * The immutable Id of the Azure Monitor Workspace. This property is read-only.
   */
  @visibility("read")
  accountId?: string;

  /**
   * Properties related to the metrics container in the Azure Monitor Workspace
   */
  @visibility("read")
  metrics?: AzureMonitorWorkspaceMetrics;

  /**
   * The provisioning state of the Azure Monitor Workspace. Set to Succeeded if everything is healthy.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The Data Collection Rule and Endpoint used for ingestion by default.
   */
  @visibility("read")
  defaultIngestionSettings?: AzureMonitorWorkspaceDefaultIngestionSettings;

  /**
   * List of private endpoint connections
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["id"])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Gets or sets allow or disallow public network access to Azure Monitor Workspace
   */
  @visibility("read", "create", "update")
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Properties related to the metrics container in the Azure Monitor Workspace
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureMonitorWorkspaceMetrics extends Metrics {}

/**
 * Properties related to the metrics container in the Azure Monitor Workspace
 */
model Metrics {
  /**
   * The Prometheus query endpoint for the Azure Monitor Workspace
   */
  @visibility("read")
  prometheusQueryEndpoint?: string;

  /**
   * An internal identifier for the metrics container. Only to be used by the system
   */
  @visibility("read")
  internalId?: string;
}

/**
 * The Data Collection Rule and Endpoint used for ingestion by default.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureMonitorWorkspaceDefaultIngestionSettings extends IngestionSettings {}

/**
 * Settings for data ingestion
 */
model IngestionSettings {
  /**
   * The Azure resource Id of the default data collection rule for this Azure Monitor Workspace.
   */
  @visibility("read")
  dataCollectionRuleResourceId?: string;

  /**
   * The Azure resource Id of the default data collection endpoint for this Azure Monitor Workspace.
   */
  @visibility("read")
  dataCollectionEndpointResourceId?: string;
}

/**
 * The Private Endpoint Connection resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Definition of ARM tracked top level resource properties for the Update operation
 */
model AzureMonitorWorkspaceResourceForUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}
