import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("Class representing a cluster principal assignment.")
@parentResource(KustoCluster)
model KustoClusterPrincipalAssignment
  is ProxyResource<ClusterPrincipalProperties> {
  @doc("The name of the Kusto principalAssignment.")
  @pattern("^.*$")
  @path
  @key("principalAssignmentName")
  @segment("principalAssignments")
  name: string;
}

@armResourceOperations
interface KustoClusterPrincipalAssignments {
  @doc("Gets a Kusto cluster principalAssignment.")
  get is ArmResourceRead<KustoClusterPrincipalAssignment>;
  @doc("Create a Kusto cluster principalAssignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoClusterPrincipalAssignment>;
  @doc("Deletes a Kusto cluster principalAssignment.")
  delete is ArmResourceDeleteAsync<KustoClusterPrincipalAssignment>;
  @doc("Lists all Kusto cluster principalAssignments.")
  list is ArmResourceListByParent<KustoClusterPrincipalAssignment>;
}
