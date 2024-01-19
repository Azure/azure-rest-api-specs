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

namespace Microsoft.Kusto;
@doc("Class representing a cluster principal assignment.")
@parentResource(Cluster)
model ClusterPrincipalAssignment is ProxyResource<ClusterPrincipalProperties> {
  @doc("The name of the Kusto principalAssignment.")
  @pattern("^.*$")
  @path
  @key("principalAssignmentName")
  @segment("principalAssignments")
  name: string;
}

@armResourceOperations
interface ClusterPrincipalAssignments {
  @doc("Gets a Kusto cluster principalAssignment.")
  get is ArmResourceRead<ClusterPrincipalAssignment>;

  @doc("Create a Kusto cluster principalAssignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterPrincipalAssignment>;

  @doc("Deletes a Kusto cluster principalAssignment.")
  delete is ArmResourceDeleteAsync<ClusterPrincipalAssignment>;

  @doc("Lists all Kusto cluster principalAssignments.")
  list is ArmResourceListByParent<ClusterPrincipalAssignment>;
}

@@projectedName(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto cluster principalAssignment's parameters supplied for the operation."
);
