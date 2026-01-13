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
 * GlobalRulestack Certificate Object
 */
@parentResource(GlobalRulestackResource)
model CertificateObjectGlobalRulestackResource
  is Azure.ResourceManager.ProxyResource<CertificateObject, false> {
  ...ResourceNameParameter<
    Resource = CertificateObjectGlobalRulestackResource,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CertificateObjectGlobalRulestackResources {
  /**
   * Get a CertificateObjectGlobalRulestackResource
   */
  get is ArmResourceRead<CertificateObjectGlobalRulestackResource>;

  /**
   * Create a CertificateObjectGlobalRulestackResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CertificateObjectGlobalRulestackResource>;

  /**
   * Delete a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    CertificateObjectGlobalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List CertificateObjectGlobalRulestackResource resources by Tenant
   */
  list is ArmResourceListByParent<CertificateObjectGlobalRulestackResource>;
}

@@doc(CertificateObjectGlobalRulestackResource.name, "certificate name");
@@doc(CertificateObjectGlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
