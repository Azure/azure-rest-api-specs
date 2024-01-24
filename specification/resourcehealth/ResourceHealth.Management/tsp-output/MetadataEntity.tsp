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

namespace Microsoft.ResourceHealth;
/**
 * The metadata entity contract.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(MetadataEntityProperties)
@includeInapplicableMetadataInPayload(false)
model MetadataEntity extends ProxyResourceBase {
  /**
   * Name of metadata entity.
   */
  @path
  @key("name")
  @segment("metadata")
  name: string;

  /**
   * The metadata entity properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MetadataEntityProperties;
}

@armResourceOperations
interface MetadataEntities {
  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Metadata_GetEntity")
  getEntity is ArmResourceRead<MetadataEntity>;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Metadata_List")
  list is ArmResourceListByParent<MetadataEntity>;
}
