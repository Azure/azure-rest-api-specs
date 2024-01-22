import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FabricModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Dra model.
 */
@parentResource(FabricModel)
model DraModel is ProxyResource<DraModelProperties> {
  /**
   * The fabric agent (Dra) name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricAgentName")
  @segment("fabricAgents")
  name: string;
}

@armResourceOperations
interface DraModels {
  /**
   * Gets the details of the fabric agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Dra_Get")
  get is ArmResourceRead<DraModel>;

  /**
   * Creates the fabric agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Dra_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DraModel,
    BaseParameters<DraModel>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes the fabric agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Dra_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DraModel,
    BaseParameters<DraModel>,
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of fabric agents in the given fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Dra_List")
  list is ArmResourceListByParent<DraModel>;
}

@@projectedName(DraModels.create::parameters.resource, "json", "body");
@@extension(DraModels.create::parameters.resource, "x-ms-client-name", "body");
@@doc(DraModels.create::parameters.resource, "Dra model.");
