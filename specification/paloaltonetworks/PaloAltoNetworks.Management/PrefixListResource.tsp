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
  get is ArmResourceRead<PrefixListResource>;

  /**
   * Create a PrefixListResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrefixListResource>;

  /**
   * Delete a PrefixListResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrefixListResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List PrefixListResource resources by LocalRulestacks
   */
  listByLocalRulestacks is ArmResourceListByParent<PrefixListResource>;
}

@@doc(PrefixListResource.name, "Local Rule priority");
@@doc(PrefixListResource.properties,
  "The resource-specific properties for this resource."
);
