import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./UpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * Device Update Agent details.
 */
@parentResource(UpdateAccount)
model Agent is Azure.ResourceManager.TrackedResource<AgentProperties> {
  ...ResourceNameParameter<
    Resource = Agent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface Agents {
  /**
   * Returns agent details.
   */
  get is ArmResourceRead<Agent>;

  /**
   * Creates or updates an Agent.
   */
  create is ArmResourceCreateOrReplaceSync<Agent>;

  /**
   * Updates Agent.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Agent, TagUpdate>;

  /**
   * Delete Agent.
   */
  delete is ArmResourceDeleteSync<Agent>;

  /**
   * Returns agents for the given update account name.
   */
  listByUpdateAccount is ArmResourceListByParent<Agent>;
}

@@maxLength(Agent.name, 1016);
@@minLength(Agent.name, 1);
@@doc(Agent.name, "Agent Id.");
@@doc(Agents.create::parameters.resource, "Agent details.");
@@doc(Agents.update::parameters.properties, "Updated tags.");

@@encodedName(Agents.create::parameters.resource, "application/json", "agent");
@@clientName(Agents.create::parameters.resource, "agent");

@@encodedName(Agents.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Agents.update::parameters.properties, "tagUpdatePayload");
