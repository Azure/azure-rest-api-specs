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
  get is ArmResourceRead<PrefixListGlobalRulestackResource>;

  /**
   * Create a PrefixListGlobalRulestackResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrefixListGlobalRulestackResource>;

  /**
   * Delete a PrefixListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrefixListGlobalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List PrefixListGlobalRulestackResource resources by Tenant
   */
  list is ArmResourceListByParent<PrefixListGlobalRulestackResource>;
}

@@doc(PrefixListGlobalRulestackResource.name, "Local Rule priority");
@@doc(PrefixListGlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
