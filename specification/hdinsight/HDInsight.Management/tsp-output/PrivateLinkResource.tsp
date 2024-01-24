import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateLinkResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model PrivateLinkResource extends ProxyResourceBase {
  /**
   * The name of the private link resource.
   */
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkResourceProperties;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the specific private link resource.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Lists the private link resources in a HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByCluster")
  listByCluster is ArmResourceListByParent<PrivateLinkResource>;
}
