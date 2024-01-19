import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
@doc("Class representing a database principal assignment.")
@parentResource(Database)
model DatabasePrincipalAssignment
  is ProxyResource<DatabasePrincipalProperties> {
  @doc("The name of the Kusto principalAssignment.")
  @pattern("^.*$")
  @path
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

@@projectedName(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto principalAssignments parameters supplied for the operation."
);
