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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GlobalRulestackResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PrefixObject)
model PrefixListGlobalRulestackResource extends ProxyResourceBase {
  /**
   * Local Rule priority
   */
  @path
  @key("name")
  @segment("prefixlists")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: PrefixObject;
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
