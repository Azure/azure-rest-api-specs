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
@doc("The kind of custom connector.")
union ConnectorGatewayCustomConnectorKind {
  string,

  @doc("An MCP server custom connector.")
  McpServer: "McpServer",
}

@added(Versions.v2026_05_01_preview)
@doc("Backend service configuration for a custom connector.")
model CustomConnectorBackendService {
  @doc("Base URL of the backend API.")
  serviceUrl?: url;
}

@added(Versions.v2026_05_01_preview)
@doc("Bit-flag of supported connection kinds.")
union CustomConnectorSupportedConnectionKinds {
  string,

  @doc("V1 connections only.")
  V1: "V1",

  @doc("V2 connections only.")
  V2: "V2",

  @doc("Both V1 and V2 connections.")
  V1AndV2: "V1AndV2",
}

@added(Versions.v2026_05_01_preview)
@doc("The shape of the API definition.")
union CustomConnectorApiType {
  string,

  @doc("API type is not specified.")
  NotSpecified: "NotSpecified",

  @doc("REST API.")
  Rest: "Rest",

  @doc("SOAP API.")
  Soap: "Soap",
}

@added(Versions.v2026_05_01_preview)
@doc("The properties of a connector gateway custom connector.")
model ConnectorGatewayCustomConnectorProperties {
  @doc("The provisioning state of the custom connector.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Display name of the custom connector.")
  displayName?: string;

  @doc("Free-form description of the custom connector.")
  description?: string;

  @doc("MCP protocol endpoint URL (required when `kind` is `McpServer`).")
  mcpServerUrl?: url;

  @doc("Backend service configuration.")
  backendService?: CustomConnectorBackendService;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form OpenAPI / Swagger definition; accepts any JSON shape."
  @doc("OpenAPI / Swagger definition. Free-form JSON value matching the backend `Swagger` (JToken) shape.")
  swagger?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form connection authentication schema."
  @doc("Connection authentication schema.")
  connectionParameters?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form alternative connection parameter sets."
  @doc("Alternative connection parameter sets.")
  connectionParameterSets?: Record<unknown>;

  @doc("Connector capabilities (e.g., actions, triggers, tools).")
  capabilities?: string[];

  @doc("URL to the connector icon.")
  iconUri?: url;

  @doc("Brand color hex code (e.g., `#007ee5`).")
  brandColor?: string;

  @doc("Bit-flag of supported connection kinds.")
  supportedConnectionKinds?: CustomConnectorSupportedConnectionKinds;

  @doc("API Hub runtime endpoints for the connector.")
  runtimeUrls?: url[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form pointers to externalized API definitions."
  @doc("Pointers to externalized API definitions (e.g., swagger URLs stored in blob storage).")
  apiDefinitions?: Record<unknown>;

  @doc("API definition shape.")
  apiType?: CustomConnectorApiType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form WSDL definition payload."
  @doc("WSDL definition for SOAP custom connectors (when apiType is Soap).")
  wsdlDefinition?: Record<unknown>;

  @doc("""
    Inline custom connector policy XML applied to the connector at runtime
    (Logic Apps policy expressions).
    """)
  policies?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form content link pointer (e.g., blob URI)."
  @doc("External pointer to policy XML content (e.g., blob URI). Mirrors the shared ContentLinkDefinition shape.")
  policyContentLink?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form integration service environment reference."
  @doc("""
    Optional reference to a Logic Apps Integration Service Environment that
    hosts the connector runtime.
    """)
  integrationServiceEnvironment?: Record<unknown>;

  @doc("""
    Whether dynamic per-call connections are allowed on this connector.
    Mirrors the legacy `Microsoft.Web/connections` dynamic-connection flag;
    defaults to false for new connectors.
    """)
  isDynamicConnectionAllowed?: boolean;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A custom connector under a connector gateway.")
model ConnectorGatewayCustomConnector
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayCustomConnectorProperties> {
  @key("customConnectorName")
  @segment("customConnectors")
  @doc("The name of the custom connector.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "`kind` mirrors the backend resource envelope shape so callers can switch on connector type without inspecting properties."
  @doc("The kind of custom connector (e.g., McpServer).")
  kind?: ConnectorGatewayCustomConnectorKind;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of connector gateway custom connectors.")
interface ConnectorGatewayCustomConnectors {
  get is ArmResourceRead<ConnectorGatewayCustomConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayCustomConnector>;
  delete is ArmResourceDeleteSync<ConnectorGatewayCustomConnector>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayCustomConnector>;
}
