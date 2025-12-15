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
  get is ArmResourceRead<FqdnListLocalRulestackResource>;

  /**
   * Create a FqdnListLocalRulestackResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FqdnListLocalRulestackResource>;

  /**
   * Delete a FqdnListLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FqdnListLocalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List FqdnListLocalRulestackResource resources by LocalRulestacks
   */
  listByLocalRulestacks is ArmResourceListByParent<FqdnListLocalRulestackResource>;
}

@@doc(FqdnListLocalRulestackResource.name, "fqdn list name");
@@doc(FqdnListLocalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
