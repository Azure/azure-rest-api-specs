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

namespace Microsoft.AzureStackHCI;
/**
 * Publisher details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PublisherProperties)
model Publisher extends ProxyResourceBase {
  /**
   * The name of the publisher available within HCI cluster.
   */
  @path
  @key("publisherName")
  @segment("publishers")
  @visibility("read")
  name: string;

  /**
   * Publisher properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PublisherProperties;
}

@armResourceOperations
interface Publishers {
  /**
   * Get Publisher resource details of HCI Cluster.
   */
  get is ArmResourceRead<Publisher>;

  /**
   * List Publishers available for the HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Publishers_ListByCluster")
  listByCluster is ArmResourceListByParent<Publisher>;
}
