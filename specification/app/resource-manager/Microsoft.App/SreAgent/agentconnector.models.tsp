import "@typespec/versioning";
import "./commontypes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** Collection of Agent Connectors */
model AgentConnectorCollection is Azure.Core.Page<AgentConnector>;

/** Agent Connector Properties */
model AgentConnectorProperties {
  ...Connector;

  /** The type of the data connector */
  dataConnectorType?: string;
}

/** Agent Connector returned by secret-listing actions. */
@added(Versions.v2026_07_01)
model AgentConnectorWithSecrets
  is ProxyResource<AgentConnectorPropertiesWithSecrets> {
  ...ResourceNameParameter<
    Resource = AgentConnector,
    KeyName = "connectorName",
    SegmentName = "connectors",
    NamePattern = "^[A-Za-z]([-A-Za-z0-9]{0,30}[A-Za-z0-9])$"
  >;
}

/** Agent Connector properties returned by secret-listing actions. */
@added(Versions.v2026_07_01)
model AgentConnectorPropertiesWithSecrets {
  ...OmitProperties<Connector, "dataSourceV1" | "dataSource">;

  /** Data source connection string or endpoint. */
  @secret
  dataSource?: string;

  /** The type of the data connector. */
  dataConnectorType?: string;
}

/** Collection of Agent Connectors returned by secret-listing actions. */
@added(Versions.v2026_07_01)
model AgentConnectorWithSecretsCollection
  is Azure.Core.Page<AgentConnectorWithSecrets>;
