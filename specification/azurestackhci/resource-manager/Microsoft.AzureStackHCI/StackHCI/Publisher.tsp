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

namespace Microsoft.AzureStackHCI;
/**
 * Publisher details.
 */
@parentResource(Cluster)
model Publisher is Azure.ResourceManager.ProxyResource<PublisherProperties> {
  ...ResourceNameParameter<
    Resource = Publisher,
    KeyName = "publisherName",
    SegmentName = "publishers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Publishers {
  /**
   * Get Publisher resource details of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<Publisher>;

  /**
   * List Publishers available for the HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByCluster is ArmResourceListByParent<
    Publisher,
    Response = ArmResponse<PublisherList>
  >;
}

@@doc(Publisher.name,
  "The name of the publisher available within HCI cluster."
);
@@doc(Publisher.properties, "Publisher properties.");

// Models

/**
 * List of Publisher proxy resources for the HCI cluster.
 */
model PublisherList is Azure.Core.Page<Publisher>;

/**
 * Publisher properties.
 */
model PublisherProperties {
  /**
   * Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}
