import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("The properties of a connector gateway.")
model ConnectorGatewayProperties {
  @doc("The provisioning state of the connector gateway.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("System-assigned AI gateway identifier.")
  @visibility(Lifecycle.Read)
  aiGatewayId?: Azure.Core.uuid;

  @doc("System-assigned connector gateway identifier.")
  @visibility(Lifecycle.Read)
  connectorGatewayId?: Azure.Core.uuid;

  @doc("Optional GUID of an existing API Hub environment to attach to on PUT (brownfield/passthrough scenarios). When omitted, the gateway creates a new API Hub environment.")
  apiHubEnvironmentId?: Azure.Core.uuid;
}

@added(Versions.v2026_05_01_preview)
@doc("A connector gateway resource.")
model ConnectorGateway
  is Azure.ResourceManager.TrackedResource<ConnectorGatewayProperties> {
  @key("name")
  @segment("connectorGateways")
  @doc("The name of the connector gateway")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2026_05_01_preview)
@doc("Type of access key to issue or regenerate.")
union AccessKeyType {
  string,

  @doc("Primary access key.")
  Primary: "Primary",

  @doc("Secondary access key.")
  Secondary: "Secondary",
}

@added(Versions.v2026_05_01_preview)
@doc("Request body for listing an API key on a connector gateway.")
model ListApiKeyRequest {
  @doc("Type of access key to issue. Defaults to Primary when omitted.")
  keyType?: AccessKeyType;

  @doc("Absolute expiry time. Ignored when neverExpire is true. Defaults to now + 1 day if both notAfter and neverExpire are omitted.")
  notAfter?: utcDateTime;

  @doc("When true, the issued key has no expiry. notAfter must be null or omitted in that case.")
  neverExpire?: boolean;

  @doc("Optional MCP server config name to scope the key to. When set, the key may only invoke the named MCP server config; when null or empty, the key may invoke any MCP server config on the gateway.")
  scope?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Response body for listApiKey.")
model ConnectorGatewayKeyDefinition {
  @doc("Opaque, base64url-encoded credential blob. Pass as the Authorization: Bearer <key> header (or via the ?api-key=<key> query string) when invoking the MCP runtime endpoint.")
  @secret
  key: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Request body for regenerating a connector gateway access key.")
model AccessKeyRegenerateActionDefinition {
  @doc("Type of access key to regenerate.")
  keyType: AccessKeyType;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateways.")
interface ConnectorGateways {
  get is ArmResourceRead<ConnectorGateway>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGateway>;
  update is ArmTagsPatchSync<ConnectorGateway>;
  delete is ArmResourceDeleteSync<ConnectorGateway>;
  listBySubscription is ArmListBySubscription<ConnectorGateway>;
  listByResourceGroup is ArmResourceListByParent<
    ConnectorGateway,
    Azure.ResourceManager.Foundations.BaseParameters<ConnectorGateway> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;

  @doc("Issues an API key for the connector gateway. The key may be scoped to a specific MCP server config or to the entire gateway.")
  listApiKey is ArmResourceActionSync<
    ConnectorGateway,
    ListApiKeyRequest,
    ConnectorGatewayKeyDefinition
  >;

  @doc("Regenerates the primary or secondary access key on the connector gateway.")
  regenerateAccessKey is ArmResourceActionSync<
    ConnectorGateway,
    AccessKeyRegenerateActionDefinition,
    ConnectorGatewayKeyDefinition
  >;
}
