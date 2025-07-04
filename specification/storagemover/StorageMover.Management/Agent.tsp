import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Agent resource.
 */
@parentResource(StorageMover)
model Agent is Azure.ResourceManager.ProxyResource<AgentProperties, false> {
  ...ResourceNameParameter<
    Resource = Agent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Agents {
  /**
   * Gets an Agent resource.
   */
  get is ArmResourceRead<Agent>;

  /**
   * Creates or updates an Agent resource, which references a hybrid compute machine that can run jobs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Agent,
    Response = ArmResourceUpdatedResponse<Agent>
  >;

  /**
   * Creates or updates an Agent resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Agent, PatchModel = AgentUpdateParameters>;

  /**
   * Deletes an Agent resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Agent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Agents in a Storage Mover.
   */
  list is ArmResourceListByParent<Agent, Response = ArmResponse<AgentList>>;
}

@@doc(Agent.name, "The name of the Agent resource.");
@@doc(Agent.properties, "");
@@doc(Agents.createOrUpdate::parameters.resource, "");
@@doc(Agents.update::parameters.properties, "");
