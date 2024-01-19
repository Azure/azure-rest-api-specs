import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
@doc("GlobalRulestack prefixList")
@parentResource(GlobalRulestackResource)
model PrefixListGlobalRulestackResource is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListGlobalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a PrefixListGlobalRulestackResource")
  @operationId("PrefixListGlobalRulestack_Get")
  get is ArmResourceRead<PrefixListGlobalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a PrefixListGlobalRulestackResource")
  @operationId("PrefixListGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrefixListGlobalRulestackResource,
    BaseParameters<PrefixListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a PrefixListGlobalRulestackResource")
  @operationId("PrefixListGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    PrefixListGlobalRulestackResource,
    BaseParameters<PrefixListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List PrefixListGlobalRulestackResource resources by Tenant")
  @operationId("PrefixListGlobalRulestack_List")
  list is ArmResourceListByParent<PrefixListGlobalRulestackResource>;
}
