import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagementPartner;
/**
 * this is the management partner operations response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
model PartnerResponse {
  /**
   * Id of the Partner
   */
  @path
  @key("partnerId")
  @segment("partners")
  @visibility("read")
  name: string;

  /**
   * Type of the partner
   */
  etag?: int32;

  /**
   * Identifier of the partner
   */
  @visibility("read")
  id?: string;

  /**
   * Type of resource. "Microsoft.ManagementPartner/partners"
   */
  @visibility("read")
  type?: string;

  /**
   * Properties of the partner
   */
  @extension("x-ms-client-flatten", true)
  properties?: PartnerProperties;
}

@armResourceOperations
interface PartnerResponses {
  /**
   * Get the management partner using the partnerId, objectId and tenantId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Partner_Get")
  get is ArmResourceRead<PartnerResponse>;

  /**
   * Create a management partner for the objectId and tenantId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Partner_Create")
  create is ArmResourceCreateOrReplaceSync<PartnerResponse>;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  /**
   * Update the management partner for the objectId and tenantId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Partner_Update")
  update is ArmCustomPatchSync<PartnerResponse, {}>;

  /**
   * Delete the management partner for the objectId and tenantId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Partner_Delete")
  delete is ArmResourceDeleteSync<PartnerResponse>;
}
