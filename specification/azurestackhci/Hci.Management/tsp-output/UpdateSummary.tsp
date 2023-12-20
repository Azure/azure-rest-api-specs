import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HciCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Get the update summaries for the cluster")
@parentResource(HciCluster)
@singleton("default")
model UpdateSummary is ProxyResource<UpdateSummariesProperties> {
  @key("default")
  @segment("updateSummaries")
  name: string;
}

@armResourceOperations
interface UpdateSummaries {
  @doc("Get all Update summaries under the HCI cluster")
  get is ArmResourceRead<UpdateSummary>;
  @doc("Put Update summaries under the HCI cluster")
  put is ArmResourceCreateOrReplaceSync<UpdateSummary>;
  @doc("Delete Update Summaries")
  delete is ArmResourceDeleteAsync<UpdateSummary>;
  @doc("List all Update summaries under the HCI cluster")
  listByHciCluster is ArmResourceListByParent<UpdateSummary>;
}
