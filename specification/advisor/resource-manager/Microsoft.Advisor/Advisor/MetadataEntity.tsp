import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Advisor;
/**
 * The metadata entity contract.
 */
@tenantResource
model MetadataEntity
  is Azure.ResourceManager.ProxyResource<MetadataEntityProperties> {
  ...ResourceNameParameter<
    Resource = MetadataEntity,
    KeyName = "name",
    SegmentName = "metadata",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MetadataEntities {
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of metadata entities.")
  get is ArmResourceRead<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ArmDefaultErrorResponse,
    Response = ArmResponse<MetadataEntity> | ArmNotFoundResponseWithBody
  >;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ArmDefaultErrorResponse
  >;
}

@@doc(MetadataEntity.name, "Name of metadata entity.");
@@doc(MetadataEntity.properties, "The metadata entity properties.");
