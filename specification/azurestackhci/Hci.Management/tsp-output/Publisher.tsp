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
@parentResource(Cluster)
model Publisher is ProxyResource<PublisherProperties> {
  /**
   * The name of the publisher available within HCI cluster.
   */
  @path
  @key("publisherName")
  @segment("publishers")
  name: string;
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
