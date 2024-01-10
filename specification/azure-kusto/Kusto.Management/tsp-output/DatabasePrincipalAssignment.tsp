import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
@doc("Class representing a database principal assignment.")
@parentResource(Database)
model DatabasePrincipalAssignment
  is ProxyResource<DatabasePrincipalProperties> {
  @doc("The name of the Kusto principalAssignment.")
  @pattern("^.*$")
  @key("principalAssignmentName")
  @segment("principalAssignments")
  name: string;
}

@armResourceOperations
interface DatabasePrincipalAssignments {
  @doc("Gets a Kusto cluster database principalAssignment.")
  get is ArmResourceRead<DatabasePrincipalAssignment>;

  @doc("Creates a Kusto cluster database principalAssignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DatabasePrincipalAssignment>;

  @doc("Deletes a Kusto principalAssignment.")
  delete is ArmResourceDeleteAsync<DatabasePrincipalAssignment>;

  @doc("Lists all Kusto cluster database principalAssignments.")
  list is ArmResourceListByParent<DatabasePrincipalAssignment>;
}
