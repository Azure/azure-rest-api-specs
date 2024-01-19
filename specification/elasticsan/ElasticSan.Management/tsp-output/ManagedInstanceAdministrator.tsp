import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("An Azure SQL managed instance administrator.")
@parentResource(ManagedInstance)
model ManagedInstanceAdministrator
  is ProxyResource<ManagedInstanceAdministratorProperties> {
  @path
  @key("administratorName")
  @segment("administrators")
  name: AdministratorName;
}

@armResourceOperations
interface ManagedInstanceAdministrators {
  @doc("Gets a managed instance administrator.")
  get is ArmResourceRead<ManagedInstanceAdministrator>;

  @doc("Creates or updates a managed instance administrator.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceAdministrator>;

  @doc("Deletes a managed instance administrator.")
  delete is ArmResourceDeleteAsync<ManagedInstanceAdministrator>;

  @doc("Gets a list of managed instance administrators.")
  listByInstance is ArmResourceListByParent<ManagedInstanceAdministrator>;
}

@@projectedName(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "The requested administrator parameters."
);
