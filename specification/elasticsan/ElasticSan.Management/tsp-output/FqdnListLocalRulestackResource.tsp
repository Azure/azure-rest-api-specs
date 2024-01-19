import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
@doc("LocalRulestack fqdnList")
@parentResource(LocalRulestackResource)
model FqdnListLocalRulestackResource is ProxyResource<FqdnObject> {
  @doc("fqdn list name")
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListLocalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a FqdnListLocalRulestackResource")
  @operationId("FqdnListLocalRulestack_Get")
  get is ArmResourceRead<FqdnListLocalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a FqdnListLocalRulestackResource")
  @operationId("FqdnListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FqdnListLocalRulestackResource,
    BaseParameters<FqdnListLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a FqdnListLocalRulestackResource")
  @operationId("FqdnListLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    FqdnListLocalRulestackResource,
    BaseParameters<FqdnListLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FqdnListLocalRulestackResource resources by LocalRulestacks")
  @operationId("FqdnListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<FqdnListLocalRulestackResource>;
}
