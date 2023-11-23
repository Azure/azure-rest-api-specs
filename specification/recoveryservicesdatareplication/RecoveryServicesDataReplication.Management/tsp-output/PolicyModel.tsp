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
@doc("Policy model.")
@parentResource(VaultModel)
model PolicyModel is ProxyResource<PolicyModelProperties> {
  @doc("The policy name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("policyName")
  @segment("replicationPolicies")
  name: string;
}

@armResourceOperations
interface PolicyModels {
  @doc("Gets the details of the policy.")
  get is ArmResourceRead<PolicyModel>;
  @doc("Creates the policy.")
  create is ArmResourceCreateOrUpdateAsync<PolicyModel>;
  @doc("Removes the policy.")
  delete is ArmResourceDeleteWithoutOkAsync<PolicyModel>;
  @doc("Gets the list of policies in the given vault.")
  list is ArmResourceListByParent<PolicyModel>;
  @summary("Gets the policy operation status.")
  @doc("Tracks the results of an asynchronous operation on the policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/replicationVaults/{vaultName}/replicationPolicies/{policyName}/operations/{operationId}")
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

      @doc("The policy name.")
      @pattern("^[a-zA-Z0-9]*$")
      @path
      policyName: string;

      @doc("The ID of an ongoing async operation.")
      @minLength(1)
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
