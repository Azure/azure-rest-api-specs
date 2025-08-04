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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectGlobalRulestack_Get")
  get is ArmResourceRead<CertificateObjectGlobalRulestackResource>;

  /**
   * Create a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CertificateObjectGlobalRulestackResource>;

  /**
   * Delete a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CertificateObjectGlobalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CertificateObjectGlobalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List CertificateObjectGlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectGlobalRulestack_List")
  list is ArmResourceListByParent<CertificateObjectGlobalRulestackResource>;
}

@@doc(CertificateObjectGlobalRulestackResource.name, "certificate name");
@@doc(CertificateObjectGlobalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
