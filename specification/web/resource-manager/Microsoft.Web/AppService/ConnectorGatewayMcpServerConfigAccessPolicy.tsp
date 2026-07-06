import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConnectorGatewayMcpServerConfig.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("The principal type for an MCP server config access policy.")
union ConnectorGatewayMcpServerConfigAccessPolicyPrincipalType {
  string,

  @doc("The principal is a user.")
  User: "User",

  @doc("The principal is a group.")
  Group: "Group",
}

@added(Versions.v2026_05_01_preview)
@doc("Principal definition for an MCP server config access policy.")
model ConnectorGatewayMcpServerConfigAccessPolicyPrincipal {
  @doc("Entra ID object ID of the user or group principal.")
  objectId?: Azure.Core.uuid;

  @doc("Entra ID tenant ID.")
  tenantId?: Azure.Core.uuid;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "MCP server config access policies are provisioned synchronously and intentionally omit provisioningState. This is asymmetric with connections/accessPolicies, where policy provisioning is async."
@added(Versions.v2026_05_01_preview)
@doc("The properties of an MCP server config access policy.")
model ConnectorGatewayMcpServerConfigAccessPolicyProperties {
  @doc("""
    The kind of Entra ID principal granted access. MCP server config access
    policies do NOT carry a provisioning state — provisioning is synchronous.
    This is intentionally asymmetric with connections/accessPolicies, where the
    policy provisioning is async and carries a provisioning state.
    """)
  principalType?: ConnectorGatewayMcpServerConfigAccessPolicyPrincipalType;

  @doc("The Entra ID principal (user or group) granted access by this policy.")
  principal?: ConnectorGatewayMcpServerConfigAccessPolicyPrincipal;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGatewayMcpServerConfig)
@doc("An access policy on a connector gateway MCP server configuration.")
model ConnectorGatewayMcpServerConfigAccessPolicy
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayMcpServerConfigAccessPolicyProperties> {
  @key("accessPolicyName")
  @segment("accessPolicies")
  @doc("The name of the access policy.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateway MCP server config access policies.")
interface ConnectorGatewayMcpServerConfigAccessPolicies {
  get is ArmResourceRead<ConnectorGatewayMcpServerConfigAccessPolicy>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayMcpServerConfigAccessPolicy>;
  delete is ArmResourceDeleteSync<ConnectorGatewayMcpServerConfigAccessPolicy>;
  listByMcpServerConfig is ArmResourceListByParent<ConnectorGatewayMcpServerConfigAccessPolicy>;
}
