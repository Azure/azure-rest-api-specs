import "./commontypes.tsp";

namespace Microsoft.App;

/** Collection of Agent Connectors */
model AgentConnectorCollection is Azure.Core.Page<AgentConnector>;

/** Agent Connector Properties */
model AgentConnectorProperties {
  ...Connector;

  /** The type of the data connector */
  dataConnectorType?: string;

  /** Source of the data connector - "Agent" when directly stored in agent, "AgentSpace" when inherited */
  @visibility(Lifecycle.Read)
  source?: string;
}
