import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * GlobalRulestack Certificate Object
 */
@parentResource(GlobalRulestackResource)
model CertificateObjectGlobalRulestackResource
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
interface CertificateObjectGlobalRulestackResources {
  /**
   * Get a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectGlobalRulestack_Get")
  get is ArmResourceRead<CertificateObjectGlobalRulestackResource>;

  /**
   * Create a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CertificateObjectGlobalRulestackResource,
    BaseParameters<CertificateObjectGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a CertificateObjectGlobalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    CertificateObjectGlobalRulestackResource,
    BaseParameters<CertificateObjectGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List CertificateObjectGlobalRulestackResource resources by Tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateObjectGlobalRulestack_List")
  list is ArmResourceListByParent<CertificateObjectGlobalRulestackResource>;
}
