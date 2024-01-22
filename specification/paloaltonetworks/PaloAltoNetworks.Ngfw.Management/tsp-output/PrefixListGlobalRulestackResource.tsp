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
 * GlobalRulestack prefixList
 */
@parentResource(GlobalRulestackResource)
model PrefixListGlobalRulestackResource is ProxyResource<PrefixObject> {
  /**
   * Local Rule priority
   */
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListGlobalRulestackResources {
  /**
   * Get a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListGlobalRulestack_Get")
  get is ArmResourceRead<PrefixListGlobalRulestackResource>;

  /**
   * Create a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrefixListGlobalRulestackResource,
    BaseParameters<PrefixListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    PrefixListGlobalRulestackResource,
    BaseParameters<PrefixListGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List PrefixListGlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListGlobalRulestack_List")
  list is ArmResourceListByParent<PrefixListGlobalRulestackResource>;
}
