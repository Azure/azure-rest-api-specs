import "./commontypes.tsp";

namespace Microsoft.App;

/** Collection of Agent Space Connectors */
model AgentSpaceConnectorCollection is Azure.Core.Page<AgentSpaceConnector>;

/** Agent Space Connector Properties */
model AgentSpaceConnectorProperties {
  ...Connector;

  /** The type of the data connector */
  dataConnectorType?: AgentSpaceConnectorType;
}

/** Agent Space connector type */
union AgentSpaceConnectorType {
  string,

  /** Kusto connector type */
  Kusto: "Kusto",

  /** ICM connector type */
  Icm: "Icm",
}
