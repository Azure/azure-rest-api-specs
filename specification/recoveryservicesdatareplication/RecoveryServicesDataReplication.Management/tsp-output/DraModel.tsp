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
  @path
  @key("fabricAgentName")
  @segment("fabricAgents")
  name: string;
}

@armResourceOperations
interface DraModels {
  @doc("Gets the details of the fabric agent.")
  get is ArmResourceRead<DraModel>;
  @doc("Creates the fabric agent.")
  create is ArmResourceCreateOrUpdateAsync<DraModel>;
  @doc("Deletes the fabric agent.")
  delete is ArmResourceDeleteWithoutOkAsync<DraModel>;
  @doc("Gets the list of fabric agents in the given fabric.")
  list is ArmResourceListByParent<DraModel>;
  @summary("Gets the fabric agent (Dra) operation status.")
  @doc("Tracks the results of an asynchronous operation on the fabric agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationFabrics/{fabricName}/fabricAgents/{fabricAgentName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The fabric name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      fabricName: string;

      @doc("The fabric agent (Dra) name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      fabricAgentName: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
