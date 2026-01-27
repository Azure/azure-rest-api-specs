import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./agent.tsp";
import "./agentconnector.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

/** Agent Connector resource */
@doc("Agent Connector used to connect to data sources")
@parentResource(Agent)
model AgentConnector is ProxyResource<AgentConnectorProperties> {
  ...ResourceNameParameter<
    Resource = AgentConnector,
    KeyName = "connectorName",
    SegmentName = "connectors",
    NamePattern = "^[A-Za-z]([-A-Za-z0-9]{0,30}[A-Za-z0-9])$"
  >;
}

@armResourceOperations
interface AgentsConnectors {
  /** Get the properties of an Agent Connector */
  get is ArmResourceRead<AgentConnector>;

  /** Creates or updates an Agent Connector */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentConnector>;

  /** Delete an Agent Connector */
  delete is ArmResourceDeleteWithoutOkAsync<AgentConnector>;

  /** Get all the connectors for an Agent */
  listByAgent is ArmResourceListByParent<AgentConnector>;

  /** Get a Data Connector with secrets from an Agent */
  @action("listSecrets")
  @armResourceAction(AgentConnector)
  @post
  listSecrets is ArmResourceActionSync<AgentConnector, void, AgentConnector>;

  /** List all Data Connectors with secrets from an Agent */
  @action("listConnectorsWithSecrets")
  @armResourceAction(Agent)
  @post
  listWithSecretsByAgent is ArmResourceActionSync<
    Agent,
    void,
    AgentConnectorCollection
  >;
}
