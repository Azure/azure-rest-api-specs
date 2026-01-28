import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Resource tags update model */
model ResourceTags {
  /** Resource tags */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is a free-form dictionary"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/** Base connector properties shared across Agent and AgentSpace connectors */
model Connector {
  /** Endpoint of the connector */
  endpoint?: string;

  /** Data source connection string or endpoint */
  @secret
  dataSource?: string;

  /** Identity used to access the data source */
  identity?: armResourceIdentifier;

  /** Provisioning state of the connector */
  @visibility(Lifecycle.Read)
  provisioningState?: ConnectorProvisioningState;

  /** Deployment error message if provisioning failed */
  @visibility(Lifecycle.Read)
  deploymentError?: string;

  /** Additional properties for the data connector which can be used to store custom key-value pairs */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a key-value pair for extended properties"
  extendedProperties?: Record<unknown>;
}

/** Provisioning state of a connector */
@lroStatus
union ConnectorProvisioningState {
  string,
  ResourceProvisioningState,

  /** The connector is being provisioned */
  InProgress: "InProgress",

  /** The connector provisioning succeeded */
  Succeeded: "Succeeded",

  /** The connector provisioning failed */
  Failed: "Failed",

  /** The connector provisioning was canceled */
  Canceled: "Canceled",

  /** The connector is being deleted */
  Deleting: "Deleting",
}
