import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  /**
   * Gets the metadata entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecommendationMetadata_Get")
  get is ArmResourceRead<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecommendationMetadata_List")
  list is ArmResourceListByParent<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(MetadataEntity.name, "Name of metadata entity.");
@@doc(MetadataEntity.properties, "The metadata entity properties.");
