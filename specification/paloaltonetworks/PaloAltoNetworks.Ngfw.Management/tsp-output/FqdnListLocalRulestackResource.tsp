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
/**
 * LocalRulestack fqdnList
 */
@parentResource(LocalRulestackResource)
model FqdnListLocalRulestackResource is ProxyResource<FqdnObject> {
  /**
   * fqdn list name
   */
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListLocalRulestackResources {
  /**
   * Get a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListLocalRulestack_Get")
  get is ArmResourceRead<FqdnListLocalRulestackResource>;

  /**
   * Create a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FqdnListLocalRulestackResource,
    BaseParameters<FqdnListLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    FqdnListLocalRulestackResource,
    BaseParameters<FqdnListLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List FqdnListLocalRulestackResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<FqdnListLocalRulestackResource>;
}
