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
 * LocalRulestack prefixList
 */
@parentResource(LocalRulestackResource)
model PrefixListResource
  is Azure.ResourceManager.ProxyResource<PrefixObject, false> {
  ...ResourceNameParameter<
    Resource = PrefixListResource,
    KeyName = "name",
    SegmentName = "prefixlists",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrefixListResources {
  /**
   * Get a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListLocalRulestack_Get")
  get is ArmResourceRead<PrefixListResource>;

  /**
   * Create a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrefixListResource>;

  /**
   * Delete a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PrefixListLocalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrefixListResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List PrefixListResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrefixListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<PrefixListResource>;
}

@@doc(PrefixListResource.name, "Local Rule priority");
@@doc(PrefixListResource.properties,
  "The resource-specific properties for this resource."
);
