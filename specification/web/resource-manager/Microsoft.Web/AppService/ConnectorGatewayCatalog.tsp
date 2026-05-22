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

// ============================================================================
// Managed APIs (catalog under a connector gateway)
// ============================================================================

@added(Versions.v2026_05_01_preview)
@doc("Connector tier.")
union ManagedApiTier {
  string,

  @doc("Tier is not specified.")
  NotSpecified: "NotSpecified",

  @doc("Standard tier connector.")
  Standard: "Standard",

  @doc("Premium tier connector.")
  Premium: "Premium",
}

@added(Versions.v2026_05_01_preview)
@doc("Display metadata for a managed API connector.")
model ManagedApiGeneralInformation {
  @doc("Display name of the managed API.")
  displayName?: string;

  @doc("Free-form description of the managed API.")
  description?: string;

  @doc("URL to the connector icon.")
  iconUri?: url;

  @doc("Connector tier.")
  tier?: ManagedApiTier;

  @doc("Release stage (e.g., GA, Preview).")
  releaseTag?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Connection parameter schemas needed to create a connection against this managed API.")
model ManagedApiConnectionInfo {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Connection parameter schema is free-form JSON, shape varies by connector."
  @doc("Connection parameter schema. Free-form JSON.")
  connectionParameters?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Alternative connection parameter sets are free-form JSON."
  @doc("Alternative connection parameter sets. Free-form JSON.")
  connectionParameterSets?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Alternative connection parameters are free-form JSON."
  @doc("Alternative connection parameters. Free-form JSON.")
  connectionAlternativeParameters?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Summary of an operation matched by fuzzy search.")
model MatchedOperationSummary {
  @doc("The matched operation ID.")
  operationId?: string;

  @doc("Operation summary text.")
  summary?: string;

  @doc("Fuzzy-search relevance score (0..1).")
  @minValue(0)
  @maxValue(1)
  score?: float64;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Managed APIs are read-only catalog entries provisioned by Microsoft and intentionally omit provisioningState."
@added(Versions.v2026_05_01_preview)
@doc("Properties of a managed API catalog entry.")
model ManagedApiProperties {
  @doc("Display metadata for the managed API.")
  generalInformation?: ManagedApiGeneralInformation;

  @doc("Connection parameter schemas needed to create a connection against this managed API.")
  connection?: ManagedApiConnectionInfo;

  @doc("Connector capabilities (e.g., actions, triggers, tools).")
  capabilities?: string[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form connector metadata. Any JSON value."
  @doc("Free-form connector metadata. Any JSON value.")
  metadata?: Record<unknown>;

  @doc("API Hub runtime endpoints for the connector.")
  runtimeUrls?: url[];

  @doc("Whether the connector swagger can be exported via `?export=true`.")
  isExportSupported?: boolean;

  @doc("""
    Fuzzy-search relevance score (0..1). Only populated when fuzzy search is
    enabled on the list endpoint; omitted otherwise.
    """)
  @minValue(0)
  @maxValue(1)
  searchScore?: float64;

  @doc("""
    Operations matched by the fuzzy search query. Only populated when
    operation-level fuzzy search is enabled; omitted otherwise.
    """)
  @identifiers(#["operationId"])
  matchedOperations?: MatchedOperationSummary[];
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A managed API connector exposed under a connector gateway. Read-only catalog entry.")
model ConnectorGatewayManagedApi
  is Azure.ResourceManager.ProxyResource<ManagedApiProperties> {
  @key("apiName")
  @segment("managedApis")
  @doc("The connector name (e.g., office365).")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("Read-only operations for the managed API catalog under a connector gateway.")
interface ConnectorGatewayManagedApis {
  get is ArmResourceRead<ConnectorGatewayManagedApi>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayManagedApi>;
}

// ============================================================================
// Managed MCP Operations (catalog under a connector gateway)
// ============================================================================

@added(Versions.v2026_05_01_preview)
@doc("Operational annotation metadata for a managed MCP operation.")
model ManagedMcpOperationAnnotation {
  @doc("The operational status (e.g., Production, Preview).")
  status?: string;

  @doc("The operation family identifier.")
  family?: string;

  @doc("The revision number of the operation.")
  revision?: int32;
}

@added(Versions.v2026_05_01_preview)
@doc("Managed API summary attached to a managed MCP operation.")
model ManagedMcpOperationApi {
  @doc("The name of the managed API.")
  name?: string;

  @doc("The display name of the managed API.")
  displayName?: string;

  @doc("URL to the API's icon.")
  iconUri?: url;

  @doc("Brand color for the API (hex format).")
  brandColor?: string;

  @doc("The category of the API (e.g., Standard).")
  category?: string;

  @doc("The resource ID of the managed API.")
  id?: Azure.Core.armResourceIdentifier;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Managed MCP operations are read-only catalog entries provisioned by Microsoft and intentionally omit provisioningState."
@added(Versions.v2026_05_01_preview)
@doc("Properties of a managed MCP operation catalog entry.")
model ManagedMcpOperationProperties {
  @doc("A brief summary of the MCP operation.")
  summary?: string;

  @doc("Detailed description of the operation.")
  description?: string;

  @doc("The managed API the operation belongs to.")
  api?: ManagedMcpOperationApi;

  @doc("Operational metadata (status, family, revision).")
  annotation?: ManagedMcpOperationAnnotation;

  @doc("The Azure region where the operation is available.")
  location?: string;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A managed MCP operation catalog entry under a connector gateway. Read-only.")
model ConnectorGatewayManagedMcpOperation
  is Azure.ResourceManager.ProxyResource<ManagedMcpOperationProperties> {
  @key("operationName")
  @segment("managedMcpOperations")
  @doc("The name of the managed MCP operation.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("Read-only operations for the managed MCP operations catalog under a connector gateway.")
interface ConnectorGatewayManagedMcpOperations {
  get is ArmResourceRead<ConnectorGatewayManagedMcpOperation>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayManagedMcpOperation>;
}

// ============================================================================
// Managed Hosted MCP Servers (catalog under a connector gateway)
// ============================================================================

@added(Versions.v2026_05_01_preview)
@doc("A single configuration input declared by a hosted MCP server registry entry.")
model HostedMcpServerInputDefinition {
  @doc("Description of the input.")
  description?: string;

  @doc("Whether the input is required.")
  isRequired?: boolean;

  @doc("""
    Input type. Determines how the configuration value is serialized into the
    sandbox. Common values include `string`, `secret`, `enum`, `int`, `bool`,
    `file`.
    """)
  type?: string;

  @doc("Allowed values for enum-type inputs.")
  allowedValues?: string[];

  @doc("Target directory inside the sandbox where a file-type input is written. Only applicable when type = file.")
  targetDirectory?: string;

  @doc("File name to use when writing a file-type input into the sandbox. Only applicable when type = file.")
  fileName?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Managed hosted MCP servers are read-only catalog entries provisioned by Microsoft and intentionally omit provisioningState."
@added(Versions.v2026_05_01_preview)
@doc("""
  Public catalog metadata for a managed hosted MCP server. The catalog
  response intentionally omits sandbox-internal fields (container image,
  server route, target port, cpu, memory) — those are sandbox
  implementation details and are not exposed to clients.
  """)
model ManagedHostedMcpServerProperties {
  @doc("Human-readable display name of the hosted MCP server.")
  displayName?: string;

  @doc("Description of the hosted MCP server.")
  description?: string;

  @doc("Publisher of the hosted MCP server.")
  publisher?: string;

  @doc("URL of the icon for the hosted MCP server.")
  iconUrl?: url;

  @doc("Category of the hosted MCP server (e.g., Productivity).")
  category?: string;

  @doc("Tags associated with the hosted MCP server.")
  tags?: string[];

  @doc("The version of the hosted MCP server. Semantic version format (`MAJOR.MINOR.PATCH`) when provided by the publisher.")
  version?: string;

  @doc("URL to the documentation for the hosted MCP server.")
  documentationUrl?: url;

  @doc("URL to the source code for the hosted MCP server.")
  sourceUrl?: url;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Configuration schema is a map of input name to input definition."
  @doc("""
    Map of input name → input definition declaring what configuration values
    may be supplied via `hostedMcpServerProperties.configuration` on the
    consuming McpServerConfig.
    """)
  configurationSchema?: Record<HostedMcpServerInputDefinition>;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("A managed hosted MCP server catalog entry under a connector gateway. Read-only.")
model ConnectorGatewayManagedHostedMcpServer
  is Azure.ResourceManager.ProxyResource<ManagedHostedMcpServerProperties> {
  @key("hostedMcpServerName")
  @segment("managedHostedMcpServers")
  @doc("The registry key for the hosted MCP server (used as hostedMcpServerId).")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("Read-only operations for the managed hosted MCP server catalog under a connector gateway.")
interface ConnectorGatewayManagedHostedMcpServers {
  get is ArmResourceRead<ConnectorGatewayManagedHostedMcpServer>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayManagedHostedMcpServer>;
}
