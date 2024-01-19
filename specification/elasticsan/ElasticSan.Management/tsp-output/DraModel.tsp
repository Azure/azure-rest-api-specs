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
@doc("Dra model.")
@parentResource(FabricModel)
model DraModel is ProxyResource<DraModelProperties> {
  @doc("The fabric agent (Dra) name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricAgentName")
  @segment("fabricAgents")
  name: string;
}

@armResourceOperations
interface DraModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the fabric agent.")
  @operationId("Dra_Get")
  get is ArmResourceRead<DraModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the fabric agent.")
  @operationId("Dra_Create")
  create is ArmResourceCreateOrUpdateAsync<
    DraModel,
    BaseParameters<DraModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the fabric agent.")
  @operationId("Dra_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DraModel,
    BaseParameters<DraModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of fabric agents in the given fabric.")
  @operationId("Dra_List")
  list is ArmResourceListByParent<DraModel>;
}

@@projectedName(DraModels.create::parameters.resource, "json", "body");
@@extension(DraModels.create::parameters.resource, "x-ms-client-name", "body");
@@doc(DraModels.create::parameters.resource, "Dra model.");
