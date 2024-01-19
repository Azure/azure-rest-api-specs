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
@doc("Publisher details.")
@parentResource(Cluster)
model Publisher is ProxyResource<PublisherProperties> {
  @doc("The name of the publisher available within HCI cluster.")
  @path
  @key("publisherName")
  @segment("publishers")
  name: string;
}

@armResourceOperations
interface Publishers {
  @doc("Get Publisher resource details of HCI Cluster.")
  get is ArmResourceRead<Publisher>;

  @doc("List Publishers available for the HCI Cluster.")
  listByCluster is ArmResourceListByParent<Publisher>;
}
