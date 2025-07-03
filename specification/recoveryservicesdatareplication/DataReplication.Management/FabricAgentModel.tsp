import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FabricModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Fabric agent model.
 */
@parentResource(FabricModel)
model FabricAgentModel
  is Azure.ResourceManager.ProxyResource<FabricAgentModelProperties> {
  ...ResourceNameParameter<
    Resource = FabricAgentModel,
    KeyName = "fabricAgentName",
    SegmentName = "fabricAgents",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(FabricAgent.create::parameters.resource,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface FabricAgent {
  /**
   * Gets the details of the fabric agent.
   */
  get is ArmResourceRead<FabricAgentModel>;

  /**
   * Creates the fabric agent.
   */
  create is ArmResourceCreateOrReplaceAsync<FabricAgentModel>;

  /**
   * Deletes fabric agent.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FabricAgentModel>;

  /**
   * Gets the list of fabric agents in the given fabric.
   */
  list is ArmResourceListByParent<FabricAgentModel>;
}

@@doc(FabricAgentModel.name, "The fabric agent name.");
@@doc(FabricAgent.create::parameters.resource, "Fabric agent model.");
