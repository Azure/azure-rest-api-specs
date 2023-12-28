import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeAnalytics;
@doc("Data Lake Analytics compute policy information.")
@parentResource(DataLakeAnalyticsAccount)
model ComputePolicy is ProxyResource<ComputePolicyProperties> {
  @doc("The name of the compute policy to retrieve.")
  @key("computePolicyName")
  @segment("computePolicies")
  name: string;
}

@armResourceOperations
interface ComputePolicies {
  @doc("Gets the specified Data Lake Analytics compute policy.")
  get is ArmResourceRead<ComputePolicy>;
  @doc("Creates or updates the specified compute policy. During update, the compute policy with the specified name will be replaced with this new compute policy. An account supports, at most, 50 policies")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ComputePolicy>;
  @doc("Updates the specified compute policy.")
  update is ArmCustomPatchSync<ComputePolicy, UpdateComputePolicyParameters>;
  @doc("Deletes the specified compute policy from the specified Data Lake Analytics account")
  delete is ArmResourceDeleteSync<ComputePolicy>;
  @doc("Lists the Data Lake Analytics compute policies within the specified Data Lake Analytics account. An account supports, at most, 50 policies")
  listByAccount is ArmResourceListByParent<ComputePolicy>;
}
