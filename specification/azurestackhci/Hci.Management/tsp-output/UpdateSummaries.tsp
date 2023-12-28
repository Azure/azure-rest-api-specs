import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Get the update summaries for the cluster")
@singleton("default")
@parentResource(Cluster)
model UpdateSummaries is ProxyResource<UpdateSummariesProperties> {
  @key("default")
  @segment("updateSummaries")
  name: string;
}

@armResourceOperations
interface UpdateSummaries {
  @doc("Get all Update summaries under the HCI cluster")
  get is ArmResourceRead<UpdateSummaries>;
  @doc("Put Update summaries under the HCI cluster")
  put is ArmResourceCreateOrReplaceSync<UpdateSummaries>;
  @doc("Delete Update Summaries")
  delete is ArmResourceDeleteAsync<UpdateSummaries>;
  @doc("List all Update summaries under the HCI cluster")
  list is ArmResourceListByParent<UpdateSummaries>;
}
