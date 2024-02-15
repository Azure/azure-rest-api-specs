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

namespace Microsoft.Edge;
/**
 * Displays all the resource types which support Sites.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  SiteAwareResourceTypesProperties
)
model SiteAwareResourceTypes extends ProxyResourceBase {
  /**
   * Name of the resource
   */
  @path
  @key("siteAwareResourceType")
  @segment("siteAwareResourceTypes")
  @visibility("read")
  name: string;

  /**
   * The properties for this resource type.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteAwareResourceTypesProperties;
}

@armResourceOperations
@projectedName("client", "SiteAwareResourceTypes")
interface SiteAwareResourceTypesOperationGroup {
  /**
   * Get Site Aware Resource Types
   */
  get is ArmResourceRead<SiteAwareResourceTypes>;

  /**
   * List Singleton SiteAwareResourceTypes Object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SiteAwareResourceTypes_List")
  list is ArmResourceListByParent<SiteAwareResourceTypes>;
}
