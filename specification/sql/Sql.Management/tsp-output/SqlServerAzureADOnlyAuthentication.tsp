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
@doc("Azure Active Directory only authentication.")
@parentResource(SqlServer)
model SqlServerAzureADOnlyAuthentication
  is ProxyResource<AzureADOnlyAuthProperties> {
  @doc("The name of server azure active directory only authentication.")
  @path
  @key("authenticationName")
  @segment("azureADOnlyAuthentications")
  name: AuthenticationName;
}

@armResourceOperations
interface SqlServerAzureADOnlyAuthentications {
  @doc("Gets a specific Azure Active Directory only authentication property.")
  get is ArmResourceRead<SqlServerAzureADOnlyAuthentication>;
  @doc("Sets Server Active Directory only authentication property or updates an existing server Active Directory only authentication property.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerAzureADOnlyAuthentication>;
  @doc("Deletes an existing server Active Directory only authentication property.")
  delete is ArmResourceDeleteAsync<SqlServerAzureADOnlyAuthentication>;
  @doc("Gets a list of server Azure Active Directory only authentications.")
  listByServer is ArmResourceListByParent<SqlServerAzureADOnlyAuthentication>;
}
