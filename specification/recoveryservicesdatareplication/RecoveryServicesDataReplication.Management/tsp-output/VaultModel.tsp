import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Vault model.")
model VaultModel is TrackedResource<VaultModelProperties> {
  @doc("The vault name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("vaultName")
  @segment("replicationVaults")
  name: string;
}

@armResourceOperations
interface VaultModels {
  @doc("Gets the details of the vault.")
  get is ArmResourceRead<VaultModel>;
  @doc("Creates the vault.")
  create is ArmResourceCreateOrUpdateAsync<VaultModel>;
  @doc("Performs update on the vault.")
  update is ArmResourcePatchAsync<VaultModel, VaultModelProperties>;
  @doc("Removes the vault.")
  delete is ArmResourceDeleteWithoutOkAsync<VaultModel>;
  @doc("Gets the list of vaults in the given subscription and resource group.")
  list is ArmResourceListByParent<
    VaultModel,
    {
      ...BaseParameters<VaultModel>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
  @doc("Gets the list of vaults in the given subscription.")
  listBySubscription is ArmListBySubscription<VaultModel>;
  @summary("Gets the vault operation status.")
  @doc("Tracks the results of an asynchronous operation on the vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/operations/{operationId}")
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

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
