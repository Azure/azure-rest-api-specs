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
 * LocalRulestack prefixList
 */
@parentResource(LocalRulestackResource)
model PrefixListResource is ProxyResource<PrefixObject> {
  /**
   * Local Rule priority
   */
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListResources {
  /**
   * Get a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListLocalRulestack_Get")
  get is ArmResourceRead<PrefixListResource>;

  /**
   * Create a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PrefixListResource,
    BaseParameters<PrefixListResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    PrefixListResource,
    BaseParameters<PrefixListResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List PrefixListResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrefixListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<PrefixListResource>;
}
