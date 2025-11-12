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
 * GlobalRulestack fqdnList
 */
@parentResource(GlobalRulestackResource)
model FqdnListGlobalRulestackResource
  is Azure.ResourceManager.ProxyResource<FqdnObject, false> {
  ...ResourceNameParameter<
    Resource = FqdnListGlobalRulestackResource,
    KeyName = "name",
    SegmentName = "fqdnlists",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FqdnListGlobalRulestackResources {
  /**
   * Get a FqdnListGlobalRulestackResource
   */
  get is ArmResourceRead<FqdnListGlobalRulestackResource>;

  /**
   * Create a FqdnListGlobalRulestackResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FqdnListGlobalRulestackResource>;

  /**
   * Delete a FqdnListGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FqdnListGlobalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List FqdnListGlobalRulestackResource resources by Tenant
   */
  list is ArmResourceListByParent<FqdnListGlobalRulestackResource>;
}

@@doc(FqdnListGlobalRulestackResource.name, "fqdn list name");
@@doc(FqdnListGlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
