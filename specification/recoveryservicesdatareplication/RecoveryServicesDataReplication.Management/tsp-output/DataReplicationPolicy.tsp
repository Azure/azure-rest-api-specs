import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Policy model.")
@parentResource(DataReplicationVault)
model DataReplicationPolicy is ProxyResource<PolicyModelProperties> {
  @doc("The policy name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("policyName")
  @segment("replicationPolicies")
  name: string;
}

@armResourceOperations
interface DataReplicationPolicies {
  @doc("Gets the details of the policy.")
  get is ArmResourceRead<DataReplicationPolicy>;
  @doc("Creates the policy.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationPolicy>;
  @doc("Removes the policy.")
  delete is ArmResourceDeleteWithoutOkAsync<DataReplicationPolicy>;
  @doc("Gets the list of policies in the given vault.")
  list is ArmResourceListByParent<DataReplicationPolicy>;
}
