import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./UpdateAccount.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

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
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the Agent.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  extendedLocation?: ExtendedLocation;
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
  @patch(#{ implicitOptionality: false })
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

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Agents.create::parameters.resource, "application/json", "agent");
@@clientName(Agents.create::parameters.resource, "agent");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Agents.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Agents.update::parameters.properties, "tagUpdatePayload");
