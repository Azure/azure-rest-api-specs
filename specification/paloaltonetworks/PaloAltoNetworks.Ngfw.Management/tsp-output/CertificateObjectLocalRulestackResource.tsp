import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * LocalRulestack Certificate Object
 */
@parentResource(LocalRulestackResource)
model CertificateObjectLocalRulestackResource
  is ProxyResource<CertificateObject> {
  /**
   * certificate name
   */
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface CertificateObjectLocalRulestackResources {
  /**
   * Get a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectLocalRulestack_Get")
  get is ArmResourceRead<CertificateObjectLocalRulestackResource>;

  /**
   * Create a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CertificateObjectLocalRulestackResource,
    BaseParameters<CertificateObjectLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a CertificateObjectLocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    CertificateObjectLocalRulestackResource,
    BaseParameters<CertificateObjectLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List CertificateObjectLocalRulestackResource resources by LocalRulestacks
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<CertificateObjectLocalRulestackResource>;
}
