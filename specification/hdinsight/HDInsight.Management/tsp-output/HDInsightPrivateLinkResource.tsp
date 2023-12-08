import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HDInsightCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HDInsight;
@doc("A private link resource")
@parentResource(HDInsightCluster)
model HDInsightPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface HDInsightPrivateLinkResources {
  @doc("Gets the specific private link resource.")
  get is ArmResourceRead<HDInsightPrivateLinkResource>;
  @doc("Lists the private link resources in a HDInsight cluster.")
  listByCluster is ArmResourceListByParent<HDInsightPrivateLinkResource>;
}
