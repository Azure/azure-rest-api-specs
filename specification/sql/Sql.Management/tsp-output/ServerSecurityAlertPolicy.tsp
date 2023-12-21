import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server security alert policy.")
@parentResource(Server)
model ServerSecurityAlertPolicy
  is ProxyResource<SecurityAlertsPolicyProperties> {
  @doc("The name of the security alert policy.")
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;
}

@armResourceOperations
interface ServerSecurityAlertPolicies {
  @doc("Get a server's security alert policy.")
  get is ArmResourceRead<ServerSecurityAlertPolicy>;
  @doc("Creates or updates a threat detection policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerSecurityAlertPolicy>;
  @doc("Get the server's threat detection policies.")
  listByServer is ArmResourceListByParent<ServerSecurityAlertPolicy>;
}
