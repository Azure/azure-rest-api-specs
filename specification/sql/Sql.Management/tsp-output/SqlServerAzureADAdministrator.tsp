import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Azure Active Directory administrator.")
@parentResource(SqlServer)
model SqlServerAzureADAdministrator is ProxyResource<AdministratorProperties> {
  @doc("The name of server active directory administrator.")
  @path
  @key("administratorName")
  @segment("administrators")
  name: AdministratorName;
}

@armResourceOperations
interface SqlServerAzureADAdministrators {
  @doc("Gets a Azure Active Directory administrator.")
  get is ArmResourceRead<SqlServerAzureADAdministrator>;
  @doc("Creates or updates an existing Azure Active Directory administrator.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerAzureADAdministrator>;
  @doc("Deletes the Azure Active Directory administrator with the given name.")
  delete is ArmResourceDeleteAsync<SqlServerAzureADAdministrator>;
  @doc("Gets a list of Azure Active Directory administrators in a server.")
  listByServer is ArmResourceListByParent<SqlServerAzureADAdministrator>;
}
