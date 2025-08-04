import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * LocalRulestack fqdnList
 */
@parentResource(LocalRulestackResource)
model FqdnListLocalRulestackResource
  is Azure.ResourceManager.ProxyResource<FqdnObject, false> {
  ...ResourceNameParameter<
    Resource = FqdnListLocalRulestackResource,
    KeyName = "name",
    SegmentName = "fqdnlists",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FqdnListLocalRulestackResources {
  /**
   * Get a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FqdnListLocalRulestack_Get")
  get is ArmResourceRead<FqdnListLocalRulestackResource>;

  /**
   * Create a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FqdnListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FqdnListLocalRulestackResource>;

  /**
   * Delete a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("FqdnListLocalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    FqdnListLocalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List FqdnListLocalRulestackResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FqdnListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<FqdnListLocalRulestackResource>;
}

@@doc(FqdnListLocalRulestackResource.name, "fqdn list name");
@@doc(FqdnListLocalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
