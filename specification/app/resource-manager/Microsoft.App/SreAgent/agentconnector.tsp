import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./agent.tsp";
import "./agentconnector.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

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
  @sharedRoute
  @removed(Versions.v2026_07_01)
  @renamedFrom(Versions.v2026_07_01, "listSecrets")
  listSecretsV1 is ArmResourceActionSync<AgentConnector, void, AgentConnector>;

  /** Get a Data Connector with secrets from an Agent. */
  @action("listSecrets")
  @armResourceAction(AgentConnector)
  @post
  @sharedRoute
  @added(Versions.v2026_07_01)
  listSecrets is ArmResourceActionSync<
    AgentConnector,
    void,
    AgentConnectorWithSecrets
  >;

  /** List all Data Connectors with secrets from an Agent */
  @action("listConnectorsWithSecrets")
  @armResourceAction(Agent)
  @post
  @sharedRoute
  @removed(Versions.v2026_07_01)
  @renamedFrom(Versions.v2026_07_01, "listWithSecretsByAgent")
  listWithSecretsByAgentV1 is ArmResourceActionSync<
    Agent,
    void,
    AgentConnectorCollection
  >;

  /** List all Data Connectors with secrets from an Agent. */
  @action("listConnectorsWithSecrets")
  @armResourceAction(Agent)
  @post
  @sharedRoute
  @added(Versions.v2026_07_01)
  listWithSecretsByAgent is ArmResourceActionSync<
    Agent,
    void,
    AgentConnectorWithSecretsCollection
  >;
}
