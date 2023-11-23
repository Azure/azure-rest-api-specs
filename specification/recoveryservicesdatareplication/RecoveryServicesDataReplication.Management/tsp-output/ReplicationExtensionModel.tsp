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
@doc("Replication extension model.")
@parentResource(VaultModel)
model ReplicationExtensionModel
  is ProxyResource<ReplicationExtensionModelProperties> {
  @doc("The replication extension name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationExtensionName")
  @segment("replicationExtensions")
  name: string;
}

@armResourceOperations
interface ReplicationExtensionModels {
  @doc("Gets the details of the replication extension.")
  get is ArmResourceRead<ReplicationExtensionModel>;
  @doc("Creates the replication extension in the given vault.")
  create is ArmResourceCreateOrUpdateAsync<ReplicationExtensionModel>;
  @doc("Deletes the replication extension in the given vault.")
  delete is ArmResourceDeleteWithoutOkAsync<ReplicationExtensionModel>;
  @doc("Gets the list of replication extensions in the given vault.")
  list is ArmResourceListByParent<ReplicationExtensionModel>;
  @summary("Gets the replication extension operation status.")
  @doc("Tracks the results of an asynchronous operation on the replication extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationExtensions/{replicationExtensionName}/operations/{operationId}")
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

      @doc("The replication extension name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      replicationExtensionName: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
