import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agentspace.tsp";
import "./agentspaceconnector.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

using Azure.ResourceManager;

namespace Microsoft.App;

/** Agent Space Connector resource */
@doc("Agent Space Connector used to connect to data sources")
@parentResource(AgentSpace)
model AgentSpaceConnector is ProxyResource<AgentSpaceConnectorProperties> {
  ...ResourceNameParameter<
    Resource = AgentSpaceConnector,
    KeyName = "connectorName",
    SegmentName = "connectors",
    NamePattern = "^[A-Za-z]([-A-Za-z0-9]{0,30}[A-Za-z0-9])$"
  >;
}

@armResourceOperations
interface AgentSpacesConnectors {
  /** Get the properties of an Agent Space Connector */
  get is ArmResourceRead<AgentSpaceConnector>;

  /** Creates or updates an Agent Space Connector */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentSpaceConnector>;

  /** Delete an Agent Space Connector */
  delete is ArmResourceDeleteWithoutOkAsync<AgentSpaceConnector>;

  /** Get all the connectors for an Agent Space */
  listByAgentSpace is ArmResourceListByParent<AgentSpaceConnector>;

  /** List secrets for an Agent Space Connector */
  @action("listSecrets")
  @armResourceAction(AgentSpaceConnector)
  @post
  listSecrets is ArmResourceActionSync<
    AgentSpaceConnector,
    void,
    AgentSpaceConnector
  >;

  /** List all secrets for AgentSpace Connectors */
  @action("listConnectorsWithSecrets")
  @armResourceAction(AgentSpace)
  @post
  listAllSecrets is ArmResourceActionSync<
    AgentSpace,
    void,
    AgentSpaceConnectorCollection
  >;
}
