import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConnectorGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("Overall status of a connector gateway connection.")
union ConnectorGatewayConnectionStatus {
  string,

  @doc("Connection is established and healthy.")
  Connected: "Connected",

  @doc("Connection requires user consent.")
  Unauthenticated: "Unauthenticated",

  @doc("Connection is in an error state.")
  Error: "Error",
}

@added(Versions.v2026_05_01_preview)
@doc("Status entry for a connector gateway connection.")
model ConnectorGatewayConnectionStatusEntry {
  @doc("Status code or label.")
  status?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Identifies the user that created a connection.")
model ConnectorGatewayConnectionCreatedBy {
  @doc("Entra ID object ID of the user.")
  objectId?: Azure.Core.uuid;

  @doc("Entra ID tenant ID of the user.")
  tenantId?: Azure.Core.uuid;
}

@added(Versions.v2026_05_01_preview)
@doc("The properties of a connector gateway connection.")
model ConnectorGatewayConnectionProperties {
  @doc("The provisioning state of the connection.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Display name of the connection.")
  displayName?: string;

  @doc("The managed API connector name (e.g., Office365).")
  connectorName?: string;

  @doc("The API Hub runtime URL for this connection.")
  @visibility(Lifecycle.Read)
  connectionRuntimeUrl?: url;

  @doc("Overall connection status.")
  @visibility(Lifecycle.Read)
  overallStatus?: ConnectorGatewayConnectionStatus;

  @doc("Detailed status entries for the connection.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  statuses?: ConnectorGatewayConnectionStatusEntry[];

  @doc("Identifies the user that created the connection.")
  @visibility(Lifecycle.Read)
  createdBy?: ConnectorGatewayConnectionCreatedBy;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A connection under a connector gateway.")
model ConnectorGatewayConnection
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayConnectionProperties> {
  @key("connectionName")
  @segment("connections")
  @doc("The name of the connection.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@doc("A consent parameter entry for listConsentLinks.")
model ListConsentLinksParameter {
  @doc("The Entra ID object ID of the user.")
  objectId?: Azure.Core.uuid;

  @doc("The consent parameter name (e.g., token).")
  parameterName?: string;

  @doc("The URL to redirect to after consent.")
  redirectUrl?: url;

  @doc("The Entra ID tenant ID.")
  tenantId?: Azure.Core.uuid;
}

@added(Versions.v2026_05_01_preview)
@doc("Request body for listing consent links on a connection.")
model ListConsentLinksRequest {
  @doc("Consent parameter entries.")
  @identifiers(#["objectId"])
  parameters?: ListConsentLinksParameter[];
}

@added(Versions.v2026_05_01_preview)
@doc("A single consent link entry.")
model ConnectorGatewayConsentLink {
  @doc("The OAuth consent URL to open in a browser.")
  link?: url;

  @doc("First-party login URI for the consent flow.")
  firstPartyLoginUri?: url;

  @doc("Display name for the consent link.")
  displayName?: string;

  @doc("Consent flow status.")
  status?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Response for listConsentLinks.")
model ConsentLinkListResult {
  @doc("The consent link entries.")
  @identifiers(#["link"])
  value?: ConnectorGatewayConsentLink[];
}

@added(Versions.v2026_05_01_preview)
@doc("Request body for confirmConsentCode.")
model ConfirmConsentCodeRequest {
  @doc("The consent code from the redirect URL.")
  code?: string;

  @doc("The Entra ID object ID of the user.")
  objectId?: Azure.Core.uuid;

  @doc("The Entra ID tenant ID.")
  tenantId?: Azure.Core.uuid;
}

@added(Versions.v2026_05_01_preview)
@doc("Response for confirmConsentCode.")
model ConfirmConsentCodeResponse {
  @doc("Authentication status after confirming consent.")
  status?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Response for listConnectionKeys.")
model ConnectionKeysResponse {
  @doc("The connection access key.")
  @secret
  connectionKey?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("HTTP method for a dynamic-invoke request.")
union DynamicInvokeHttpMethod {
  string,

  @doc("HTTP GET method.")
  GET: "GET",

  @doc("HTTP POST method.")
  POST: "POST",

  @doc("HTTP PUT method.")
  PUT: "PUT",

  @doc("HTTP PATCH method.")
  PATCH: "PATCH",

  @doc("HTTP DELETE method.")
  DELETE: "DELETE",

  @doc("HTTP HEAD method.")
  HEAD: "HEAD",

  @doc("HTTP OPTIONS method.")
  OPTIONS: "OPTIONS",
}

@added(Versions.v2026_05_01_preview)
@doc("Describes the upstream HTTP request to forward to the connector for dynamicInvoke.")
model DynamicInvokeRequestDefinition {
  @doc("HTTP method to use against the upstream connector.")
  method?: DynamicInvokeHttpMethod;

  @doc("Upstream request path, starting with /.")
  path?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form query parameter map; values vary by upstream connector."
  @doc("Query string parameters as a string-to-string map.")
  queries?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form header map; values vary by upstream connector."
  @doc("Extra request headers as a string-to-string map. Authentication headers are added by the gateway and should not be set here.")
  headers?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form request body; shape matches the upstream operation's content schema."
  @doc("Optional request body. Any JSON value matching the upstream operation's content schema.")
  body?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Request body for dynamicInvoke.")
model DynamicInvokeRequest {
  @doc("The upstream HTTP request to forward.")
  request: DynamicInvokeRequestDefinition;
}

@added(Versions.v2026_05_01_preview)
@doc("Envelope describing the upstream HTTP response.")
model DynamicInvokeResponseDefinition {
  @doc("Upstream HTTP status code. May be a numeric code or the .NET HttpStatusCode enum member name.")
  statusCode?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form response body from the upstream connector."
  @doc("Upstream response body — any JSON value.")
  body?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form header collection from the upstream connector."
  @doc("Upstream response headers. Modeled as an arbitrary JSON object because the backend may emit either a flat string-to-string map or a richer header collection.")
  headers?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Response envelope for dynamicInvoke.")
model DynamicInvokeResponse {
  @doc("The upstream HTTP response.")
  response?: DynamicInvokeResponseDefinition;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateway connections.")
interface ConnectorGatewayConnections {
  get is ArmResourceRead<ConnectorGatewayConnection>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayConnection>;
  delete is ArmResourceDeleteSync<ConnectorGatewayConnection>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayConnection>;

  @doc("Lists OAuth consent links for the connection.")
  listConsentLinks is ArmResourceActionSync<
    ConnectorGatewayConnection,
    ListConsentLinksRequest,
    ConsentLinkListResult
  >;

  @doc("Confirms an OAuth consent code returned from the redirect URL.")
  confirmConsentCode is ArmResourceActionSync<
    ConnectorGatewayConnection,
    ConfirmConsentCodeRequest,
    ConfirmConsentCodeResponse
  >;

  @doc("Lists the access keys for the connection.")
  listConnectionKeys is ArmResourceActionSync<
    ConnectorGatewayConnection,
    void,
    ConnectionKeysResponse
  >;

  @doc("Forwards a dynamic HTTP invocation through the connection.")
  dynamicInvoke is ArmResourceActionSync<
    ConnectorGatewayConnection,
    DynamicInvokeRequest,
    DynamicInvokeResponse
  >;
}
