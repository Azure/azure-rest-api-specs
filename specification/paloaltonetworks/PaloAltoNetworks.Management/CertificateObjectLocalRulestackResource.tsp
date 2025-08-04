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
 * LocalRulestack Certificate Object
 */
@parentResource(LocalRulestackResource)
model CertificateObjectLocalRulestackResource
  is Azure.ResourceManager.ProxyResource<CertificateObject, false> {
  ...ResourceNameParameter<
    Resource = CertificateObjectLocalRulestackResource,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CertificateObjectLocalRulestackResources {
  /**
   * Get a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectLocalRulestack_Get")
  get is ArmResourceRead<CertificateObjectLocalRulestackResource>;

  /**
   * Create a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CertificateObjectLocalRulestackResource>;

  /**
   * Delete a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CertificateObjectLocalRulestack_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CertificateObjectLocalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List CertificateObjectLocalRulestackResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateObjectLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<CertificateObjectLocalRulestackResource>;
}

@@doc(CertificateObjectLocalRulestackResource.name, "certificate name");
@@doc(CertificateObjectLocalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
