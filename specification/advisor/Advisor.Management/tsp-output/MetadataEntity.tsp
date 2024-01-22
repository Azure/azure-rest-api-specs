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

namespace Microsoft.Advisor;
/**
 * The metadata entity contract.
 */
@tenantResource
model MetadataEntity is ProxyResource<MetadataEntityProperties> {
  /**
   * Name of metadata entity.
   */
  @path
  @key("name")
  @segment("metadata")
  name: string;
}

@armResourceOperations
interface MetadataEntities {
  /**
   * Gets the metadata entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecommendationMetadata_Get")
  get is ArmResourceRead<MetadataEntity>;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecommendationMetadata_List")
  list is ArmResourceListByParent<MetadataEntity>;
}
