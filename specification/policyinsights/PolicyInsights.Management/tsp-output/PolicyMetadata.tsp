import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PolicyInsights;
@doc("Policy metadata resource definition.")
@tenantResource
model PolicyMetadata is ProxyResource<PolicyMetadataProperties> {
  @doc("The name of the policy metadata resource.")
  @key("resourceName")
  @segment("policyMetadata")
  name: string;
}

@armResourceOperations
interface PolicyMetadata {
  @doc("Get policy metadata resource.")
  getResource is ArmResourceRead<PolicyMetadata>;
  @doc("Get a list of the policy metadata resources.")
  list is ArmResourceListByParent<
    PolicyMetadata,
    {
      ...BaseParameters<PolicyMetadata>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;
    }
  >;
}
