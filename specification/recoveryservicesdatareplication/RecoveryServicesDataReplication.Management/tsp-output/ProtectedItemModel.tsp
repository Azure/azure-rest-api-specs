import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Protected item model.")
@parentResource(VaultModel)
model ProtectedItemModel is ProxyResource<ProtectedItemModelProperties> {
  @doc("The protected item name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("protectedItemName")
  @segment("protectedItems")
  name: string;
}

@armResourceOperations
interface ProtectedItemModels {
  @doc("Gets the details of the protected item.")
  get is ArmResourceRead<ProtectedItemModel>;
  @doc("Creates the protected item.")
  create is ArmResourceCreateOrUpdateAsync<ProtectedItemModel>;
  @doc("Removes the protected item.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProtectedItemModel,
    {
      ...BaseParameters<ProtectedItemModel>;

      @doc("A flag indicating whether to do force delete or not.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("Gets the list of protected items in the given vault.")
  list is ArmResourceListByParent<ProtectedItemModel>;
  @doc("Performs the planned failover on the protected item.")
  plannedFailover is ArmResourceActionAsync<
    ProtectedItemModel,
    PlannedFailoverModel,
    PlannedFailoverModel
  >;
  @summary("Gets the protected item operation status.")
  @doc("Tracks the results of an asynchronous operation on the protected item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/protectedItems/{protectedItemName}/operations/{operationId}")
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

      @doc("The vault name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      vaultName: string;

      @doc("The protected item name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      protectedItemName: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
