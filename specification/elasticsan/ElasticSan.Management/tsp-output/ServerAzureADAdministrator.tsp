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
@doc("Azure Active Directory administrator.")
@parentResource(Server)
model ServerAzureADAdministrator is ProxyResource<AdministratorProperties> {
  @doc("The name of server active directory administrator.")
  @path
  @key("administratorName")
  @segment("administrators")
  name: AdministratorName;
}

@armResourceOperations
interface ServerAzureADAdministrators {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a Azure Active Directory administrator.")
  @operationId("ServerAzureADAdministrators_Get")
  get is ArmResourceRead<ServerAzureADAdministrator>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an existing Azure Active Directory administrator.")
  @operationId("ServerAzureADAdministrators_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerAzureADAdministrator>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Azure Active Directory administrator with the given name.")
  @operationId("ServerAzureADAdministrators_Delete")
  delete is ArmResourceDeleteAsync<ServerAzureADAdministrator>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Azure Active Directory administrators in a server.")
  @operationId("ServerAzureADAdministrators_ListByServer")
  listByServer is ArmResourceListByParent<ServerAzureADAdministrator>;
}

@@projectedName(ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "The requested Azure Active Directory administrator Resource state."
);
