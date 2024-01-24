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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LocalRulestackResource)
@Azure.ResourceManager.Private.armResourceInternal(FqdnObject)
@includeInapplicableMetadataInPayload(false)
model FqdnListLocalRulestackResource extends ProxyResourceBase {
  /**
   * fqdn list name
   */
  @path
  @key("name")
  @segment("fqdnlists")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: FqdnObject;
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
