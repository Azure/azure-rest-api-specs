import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
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

@armResourceOperations(#{ omitTags: true })
interface MetadataEntities {
  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Metadata_GetEntity")
  @tag("Metadata")
  getEntity is ArmResourceRead<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Metadata_List")
  @tag("Metadata")
  list is ArmResourceListByParent<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = MetadataEntityListResult,
    Error = ErrorResponse
  >;
}

@@doc(MetadataEntity.name, "Name of metadata entity.");
@@doc(MetadataEntity.properties, "The metadata entity properties.");
