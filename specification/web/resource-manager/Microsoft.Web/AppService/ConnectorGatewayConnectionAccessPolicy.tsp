import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConnectorGatewayConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("The Entra ID identity used in a connection access policy principal.")
model ConnectorGatewayConnectionAccessPolicyIdentity {
  @doc("Entra ID object ID.")
  objectId?: Azure.Core.uuid;

  @doc("Entra ID tenant ID.")
  tenantId?: Azure.Core.uuid;
}

@added(Versions.v2026_05_01_preview)
@doc("Principal definition for a connection access policy.")
model ConnectorGatewayConnectionAccessPolicyPrincipal {
  @doc("The principal type (e.g., ActiveDirectory).")
  type?: string;

  @doc("The Entra ID identity for this principal.")
  identity?: ConnectorGatewayConnectionAccessPolicyIdentity;
}

@added(Versions.v2026_05_01_preview)
@doc("The properties of a connection access policy.")
model ConnectorGatewayConnectionAccessPolicyProperties {
  @doc("""
    The provisioning state of the connection access policy. Connection access
    policies carry a provisioning state because their provisioning is processed
    asynchronously by the gateway runtime. This is intentionally asymmetric with
    mcpServerConfigs/accessPolicies, which are synchronous and have no
    provisioning state.
    """)
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("The Entra ID principal authorized by this access policy.")
  principal?: ConnectorGatewayConnectionAccessPolicyPrincipal;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGatewayConnection)
@doc("An access policy on a connector gateway connection.")
model ConnectorGatewayConnectionAccessPolicy
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayConnectionAccessPolicyProperties> {
  @key("accessPolicyName")
  @segment("accessPolicies")
  @doc("The name of the access policy.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateway connection access policies.")
interface ConnectorGatewayConnectionAccessPolicies {
  get is ArmResourceRead<ConnectorGatewayConnectionAccessPolicy>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayConnectionAccessPolicy>;
  delete is ArmResourceDeleteSync<ConnectorGatewayConnectionAccessPolicy>;
  listByConnection is ArmResourceListByParent<ConnectorGatewayConnectionAccessPolicy>;
}
