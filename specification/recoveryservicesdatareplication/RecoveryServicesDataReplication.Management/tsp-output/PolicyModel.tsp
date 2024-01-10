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
  @key("policyName")
  @segment("replicationPolicies")
  name: string;
}

@armResourceOperations
@projectedName("client", "Policy")
interface PolicyModels_Policy {
  @doc("Gets the details of the policy.")
  get is ArmResourceRead<PolicyModel>;

  @doc("Creates the policy.")
  create is ArmResourceCreateOrUpdateAsync<PolicyModel>;

  @doc("Removes the policy.")
  delete is ArmResourceDeleteWithoutOkAsync<PolicyModel>;

  @doc("Gets the list of policies in the given vault.")
  list is ArmResourceListByParent<PolicyModel>;
}
