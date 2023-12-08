import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("Class representing a database principal assignment.")
@parentResource(KustoDatabase)
model KustoDatabasePrincipalAssignment
  is ProxyResource<DatabasePrincipalProperties> {
  @doc("The name of the Kusto principalAssignment.")
  @pattern("^.*$")
  @path
  @key("principalAssignmentName")
  @segment("principalAssignments")
  name: string;
}

@armResourceOperations
interface KustoDatabasePrincipalAssignments {
  @doc("Gets a Kusto cluster database principalAssignment.")
  get is ArmResourceRead<KustoDatabasePrincipalAssignment>;
  @doc("Creates a Kusto cluster database principalAssignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoDatabasePrincipalAssignment>;
  @doc("Deletes a Kusto principalAssignment.")
  delete is ArmResourceDeleteAsync<KustoDatabasePrincipalAssignment>;
  @doc("Lists all Kusto cluster database principalAssignments.")
  list is ArmResourceListByParent<KustoDatabasePrincipalAssignment>;
}
