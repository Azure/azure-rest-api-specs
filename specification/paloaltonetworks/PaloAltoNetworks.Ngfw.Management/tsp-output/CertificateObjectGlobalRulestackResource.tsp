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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GlobalRulestackResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CertificateObject)
model CertificateObjectGlobalRulestackResource extends ProxyResourceBase {
  /**
   * certificate name
   */
  @path
  @key("name")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: CertificateObject;
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
