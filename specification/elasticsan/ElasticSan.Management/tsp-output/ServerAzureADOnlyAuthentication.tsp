import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Azure Active Directory only authentication.")
@parentResource(Server)
model ServerAzureADOnlyAuthentication
  is ProxyResource<AzureADOnlyAuthProperties> {
  @doc("The name of server azure active directory only authentication.")
  @path
  @key("authenticationName")
  @segment("azureADOnlyAuthentications")
  name: AuthenticationName;
}

@armResourceOperations
interface ServerAzureADOnlyAuthentications {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a specific Azure Active Directory only authentication property.")
  @operationId("ServerAzureADOnlyAuthentications_Get")
  get is ArmResourceRead<ServerAzureADOnlyAuthentication>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Sets Server Active Directory only authentication property or updates an existing server Active Directory only authentication property.")
  @operationId("ServerAzureADOnlyAuthentications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerAzureADOnlyAuthentication>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing server Active Directory only authentication property.")
  @operationId("ServerAzureADOnlyAuthentications_Delete")
  delete is ArmResourceDeleteAsync<ServerAzureADOnlyAuthentication>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of server Azure Active Directory only authentications.")
  @operationId("ServerAzureADOnlyAuthentications_ListByServer")
  listByServer is ArmResourceListByParent<ServerAzureADOnlyAuthentication>;
}

@@projectedName(ServerAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an Active Directory only authentication property."
);
