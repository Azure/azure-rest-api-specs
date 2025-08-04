import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * GlobalRulestack prefixList
 */
@parentResource(GlobalRulestackResource)
model PrefixListGlobalRulestackResource
  is Azure.ResourceManager.ProxyResource<PrefixObject, false> {
  ...ResourceNameParameter<
    Resource = PrefixListGlobalRulestackResource,
    KeyName = "name",
    SegmentName = "prefixlists",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrefixListGlobalRulestackResources {
  /**
   * Get a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListGlobalRulestack_Get")
  get is ArmResourceRead<PrefixListGlobalRulestackResource>;

  /**
   * Create a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrefixListGlobalRulestackResource>;

  /**
   * Delete a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PrefixListGlobalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrefixListGlobalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List PrefixListGlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListGlobalRulestack_List")
  list is ArmResourceListByParent<PrefixListGlobalRulestackResource>;
}

@@doc(PrefixListGlobalRulestackResource.name, "Local Rule priority");
@@doc(PrefixListGlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
