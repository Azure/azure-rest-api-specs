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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LocalRulestackResource)
@Azure.ResourceManager.Private.armResourceInternal(CertificateObject)
@includeInapplicableMetadataInPayload(false)
model CertificateObjectLocalRulestackResource extends ProxyResourceBase {
  /**
   * certificate name
   */
  @path
  @key("name")
  @segment("certificates")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: CertificateObject;
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
