import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Agent resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(StorageMover)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AgentProperties)
model Agent extends ProxyResourceBase {
  /**
   * The name of the Agent resource.
   */
  @path
  @key("agentName")
  @segment("agents")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties: AgentProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<Agent>;

  /**
   * Creates or updates an Agent resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Agent, AgentUpdateParameters>;

  /**
   * Deletes an Agent resource.
   */
  delete is ArmResourceDeleteAsync<
    Agent,
    BaseParameters<Agent>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all Agents in a Storage Mover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Agents_List")
  list is ArmResourceListByParent<Agent>;
}

@@projectedName(Agents.createOrUpdate::parameters.resource, "json", "agent");
@@extension(Agents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agent"
);
@@doc(Agents.createOrUpdate::parameters.resource, "");
@@projectedName(Agents.update::parameters.properties, "json", "agent");
@@extension(Agents.update::parameters.properties, "x-ms-client-name", "agent");
@@doc(Agents.update::parameters.properties, "");
