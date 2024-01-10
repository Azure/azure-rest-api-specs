import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("Azure Active Directory administrator.")
@parentResource(Server)
model ServerAzureADAdministrator is ProxyResource<AdministratorProperties> {
  @doc("The name of server active directory administrator.")
  @key("administratorName")
  @segment("administrators")
  name: AdministratorName;
}

@armResourceOperations
interface ServerAzureADAdministrators {
  @doc("Gets a Azure Active Directory administrator.")
  get is ArmResourceRead<ServerAzureADAdministrator>;

  @doc("Creates or updates an existing Azure Active Directory administrator.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerAzureADAdministrator>;

  @doc("Deletes the Azure Active Directory administrator with the given name.")
  delete is ArmResourceDeleteAsync<ServerAzureADAdministrator>;

  @doc("Gets a list of Azure Active Directory administrators in a server.")
  listByServer is ArmResourceListByParent<ServerAzureADAdministrator>;
}
