import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Batch;
@doc("Contains information about an Azure Batch account.")
model BatchAccount is ProxyResource<BatchAccountProperties> {
  @doc("The name of the Batch account.")
  @maxLength(24)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("accountName")
  @segment("batchAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface BatchAccounts {
  @doc("Gets information about the specified Batch account.")
  get is ArmResourceRead<BatchAccount>;
  @doc("Creates a new Batch account with the specified parameters. Existing accounts cannot be updated with this API and should instead be updated with the Update Batch Account API.")
  create is ArmResourceCreateOrUpdateAsync<BatchAccount>;
  @doc("Updates the properties of an existing Batch account.")
  update is ArmResourcePatchSync<BatchAccount, BatchAccountProperties>;
  @doc("Deletes the specified Batch account.")
  delete is ArmResourceDeleteAsync<BatchAccount>;
  @doc("Gets information about the Batch accounts associated with the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<BatchAccount>;
  @doc("Gets information about the Batch accounts associated with the subscription.")
  list is ArmListBySubscription<BatchAccount>;
  @doc("Synchronizes access keys for the auto-storage account configured for the specified Batch account, only if storage key authentication is being used.")
  synchronizeAutoStorageKeys is ArmResourceActionNoContentSync<
    BatchAccount,
    {}
  >;
  @doc("This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, regenerating the keys will fail.")
  regenerateKey is ArmResourceActionSync<
    BatchAccount,
    BatchAccountRegenerateKeyParameters,
    BatchAccountKeys
  >;
  @doc("This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, getting the keys will fail.")
  getKeys is ArmResourceActionSync<BatchAccount, {}, BatchAccountKeys>;
  @doc("Lists the endpoints that a Batch Compute Node under this Batch Account may call as part of Batch service administration. If you are deploying a Pool inside of a virtual network that you specify, you must make sure your network allows outbound access to these endpoints. Failure to allow access to these endpoints may cause Batch to mark the affected nodes as unusable. For more information about creating a pool inside of a virtual network, see https://docs.microsoft.com/en-us/azure/batch/batch-virtual-network.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the Batch account.")
      @path
      resourceGroupName: string;

      @doc("The name of the Batch account.")
      @maxLength(24)
      @minLength(3)
      @pattern("^[a-zA-Z0-9]+$")
      @path
      accountName: string;

      @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;
}
