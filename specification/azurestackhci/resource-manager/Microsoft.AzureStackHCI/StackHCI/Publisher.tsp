import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;
/**
 * Publisher details.
 */
@parentResource(Cluster)
@removed(Versions.v2026_02_01)
model Publisher is Azure.ResourceManager.ProxyResource<PublisherProperties> {
  ...ResourceNameParameter<
    Resource = Publisher,
    KeyName = "publisherName",
    SegmentName = "publishers",
    NamePattern = ""
  >;
}

@armResourceOperations
@removed(Versions.v2026_02_01)
interface Publishers {
  /**
   * Get Publisher resource details of HCI Cluster.
   */
  get is ArmResourceRead<Publisher>;

  /**
   * List Publishers available for the HCI Cluster.
   */
  listByCluster is ArmResourceListByParent<
    Publisher,
    Response = ArmResponse<PublisherList>
  >;
}

@@doc(Publisher.name,
  "The name of the publisher available within HCI cluster."
);
@@doc(Publisher.properties, "Publisher properties.");
