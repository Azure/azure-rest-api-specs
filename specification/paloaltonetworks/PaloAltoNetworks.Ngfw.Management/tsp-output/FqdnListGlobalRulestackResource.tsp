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
/**
 * GlobalRulestack fqdnList
 */
@parentResource(GlobalRulestackResource)
model FqdnListGlobalRulestackResource is ProxyResource<FqdnObject> {
  /**
   * fqdn list name
   */
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;
}

@armResourceOperations
interface FqdnListGlobalRulestackResources {
  /**
   * Get a FqdnListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListGlobalRulestack_Get")
  get is ArmResourceRead<FqdnListGlobalRulestackResource>;

  /**
   * Create a FqdnListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FqdnListGlobalRulestackResource,
    BaseParameters<FqdnListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a FqdnListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    FqdnListGlobalRulestackResource,
    BaseParameters<FqdnListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List FqdnListGlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FqdnListGlobalRulestack_List")
  list is ArmResourceListByParent<FqdnListGlobalRulestackResource>;
}
