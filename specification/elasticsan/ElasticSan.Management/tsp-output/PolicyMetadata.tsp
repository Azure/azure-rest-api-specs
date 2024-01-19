import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PolicyInsights;
@doc("Policy metadata resource definition.")
@tenantResource
model PolicyMetadata is ProxyResource<PolicyMetadataProperties> {
  @doc("The name of the policy metadata resource.")
  @path
  @key("resourceName")
  @segment("policyMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "PolicyMetadata")
interface PolicyMetadataOperationGroup {
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
