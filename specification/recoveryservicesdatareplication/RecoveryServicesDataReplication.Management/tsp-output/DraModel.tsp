import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FabricModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Dra model.")
@parentResource(FabricModel)
model DraModel is ProxyResource<DraModelProperties> {
  @doc("The fabric agent (Dra) name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("fabricAgentName")
  @segment("fabricAgents")
  name: string;
}

@armResourceOperations
@projectedName("client", "Dra")
interface DraModels_Dra {
  @doc("Gets the details of the fabric agent.")
  get is ArmResourceRead<DraModel>;

  @doc("Creates the fabric agent.")
  create is ArmResourceCreateOrUpdateAsync<DraModel>;

  @doc("Deletes the fabric agent.")
  delete is ArmResourceDeleteWithoutOkAsync<DraModel>;

  @doc("Gets the list of fabric agents in the given fabric.")
  list is ArmResourceListByParent<DraModel>;
}
