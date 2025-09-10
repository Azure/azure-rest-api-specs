import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.MessagingConnectors.Models.Connector;

@doc("Properties of one Azure MessagingConnector resource")
@discriminator("direction")
model ConnectorProperties {
  @doc("Direction of connector")
  direction: Direction;

  @doc("Max Tasks count of the Connector.")
  maxTasks: int32;

  @doc("networkProperties config.")
  networkProperties?: Models.Network.NetworkProperties;

  @doc("Scale config.")
  scalingProperties: Models.Scaling.ScalingProperties;

  @doc("State of the MessagingConnector")
  connectorState?: ConnectorState;

  @doc("State of provisioning of the MessagingConnector ARM Resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ConnectorProvisioningState;
}

@doc("Provisioning states of Connector ARM Resource")
@lroStatus
union ConnectorProvisioningState {
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",

  @doc("Creating State")
  Creating: "Creating",

  @doc("Updating State")
  Updating: "Updating",

  string,
}

@doc("Connector job execution status")
union ConnectorState {
  @doc("Unknown State")
  Unknown: "Unknown",

  @doc("Creating State")
  Creating: "Creating",

  @doc("Initializing State")
  Initializing: "Initializing",

  @doc("Running State")
  Running: "Running",

  @doc("Updating State")
  Updating: "Updating",

  @doc("Degraded State")
  Degraded: "Degraded",

  @doc("Stopped State")
  Stopped: "Stopped",

  @doc("Paused State")
  Paused: "Paused",

  @doc("Deleting State")
  Deleting: "Deleting",

  @doc("Failed State")
  Failed: "Failed",

  string,
}

@doc("Enum of Directions of Connector")
union Direction {
  @doc("Source Connector")
  Source: "Source",

  @doc("Sink Connector")
  Sink: "Sink",

  string,
}
