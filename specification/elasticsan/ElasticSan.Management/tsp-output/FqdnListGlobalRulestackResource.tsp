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
@doc("GlobalRulestack fqdnList")
@parentResource(GlobalRulestackResource)
model FqdnListGlobalRulestackResource is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListGlobalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a FqdnListGlobalRulestackResource")
  @operationId("FqdnListGlobalRulestack_Get")
  get is ArmResourceRead<FqdnListGlobalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a FqdnListGlobalRulestackResource")
  @operationId("FqdnListGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FqdnListGlobalRulestackResource,
    BaseParameters<FqdnListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a FqdnListGlobalRulestackResource")
  @operationId("FqdnListGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    FqdnListGlobalRulestackResource,
    BaseParameters<FqdnListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FqdnListGlobalRulestackResource resources by Tenant")
  @operationId("FqdnListGlobalRulestack_List")
  list is ArmResourceListByParent<FqdnListGlobalRulestackResource>;
}
