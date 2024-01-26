import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Used for getting ResourceHealthCheck settings.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model ResourceHealthMetadata extends ProxyOnlyResource {
  @key("resourceHealthMetadatum")
  @segment("resourceHealthMetadata")
  @visibility("read")
  name: string;

  /**
   * ResourceHealthMetadata resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ResourceHealthMetadataProperties;
}

@armResourceOperations
@projectedName("client", "ResourceHealthMetadata")
interface ResourceHealthMetadataOperationGroup {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  getBySite is ArmResourceRead<ResourceHealthMetadata>;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceHealthMetadata_ListBySite")
  listBySite is ArmResourceListByParent<ResourceHealthMetadata>;
}
