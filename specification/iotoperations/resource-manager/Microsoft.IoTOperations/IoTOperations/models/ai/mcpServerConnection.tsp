import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** An MCP server connection resource. */
@added(Versions.`2026-11-01-preview`)
@parentResource(InstanceResource)
model McpServerConnectionResource
  is ProxyResource<McpServerConnectionProperties> {
  /** The name of the MCP server connection resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("mcpServerConnectionName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("mcpServerConnections")
  name: string;

  /** The edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** The configuration of an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionProperties {
  /** The Kubernetes service that hosts the MCP server. */
  service: McpServerConnectionService;

  /** The name of the ConfigMap that contains the trusted certificate authority bundle. */
  @minLength(1)
  @renamedFrom(Versions.`2026-11-01-preview`, "trustBundle")
  trustedCaCertificateConfigMapRef?: string;

  /** The MCP protocol version in YYYY-MM-DD format. */
  @pattern("^\\d{4}-\\d{2}-\\d{2}$")
  @renamedFrom(Versions.`2026-11-01-preview`, "protocolVersion")
  mcpProtocolVersion?: string;

  /** The authentication configuration used to connect to the MCP server. */
  @added(Versions.`2026-11-01-preview`)
  authentication?: McpServerConnectionAuthentication;

  /** The authorization configuration for the MCP server connection. */
  authorization: McpServerConnectionAuthorization;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The runtime status of the MCP server connection. */
  @visibility(Lifecycle.Read)
  status?: McpServerConnectionStatus;
}

/** A reference to the Kubernetes service that hosts an MCP server. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionService {
  /** The name of the Kubernetes service. */
  @minLength(1)
  name: string;

  /** The namespace of the Kubernetes service. */
  @added(Versions.`2026-11-01-preview`)
  @minLength(1)
  `namespace`?: string;

  /** The port of the Kubernetes service that hosts the MCP endpoint. */
  @added(Versions.`2026-11-01-preview`)
  @minValue(1)
  @maxValue(65535)
  port?: int32;

  /** The HTTP path of the MCP endpoint. */
  path?: string;
}

/** The authentication configuration used to connect to the MCP server. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionAuthentication {
  /** The authentication method. Only ServiceAccountToken is supported. */
  method: ServiceAccountTokenMethod;

  /** The Kubernetes service account token authentication settings. */
  serviceAccountTokenSettings?: McpServerConnectionServiceAccountTokenSettings;
}

/** The Kubernetes service account token settings for an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionServiceAccountTokenSettings {
  /** The audience for the service account token. */
  audience?: string;
}

/** The authorization configuration for an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
@discriminator("mode")
model McpServerConnectionAuthorization {
  /** The authorization mode. */
  mode: McpServerConnectionAuthorizationMode;
}

/** The supported authorization modes for an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
union McpServerConnectionAuthorizationMode {
  string,

  /** Authorization is evaluated using a referenced policy. */
  PolicyBased: "PolicyBased",

  /** Authorization policy evaluation is disabled. */
  Disabled: "Disabled",
}

/** Policy-based authorization for an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionPolicyBasedAuthorization
  extends McpServerConnectionAuthorization {
  /** The authorization mode. */
  mode: "PolicyBased";

  /** The authorization policy used for the connection. */
  policyRef: McpAuthorizationPolicyReference;
}

/** Disabled authorization for an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionDisabledAuthorization
  extends McpServerConnectionAuthorization {
  /** The authorization mode. */
  mode: "Disabled";
}

/** A reference to an MCP authorization policy in the same Kubernetes namespace. */
@added(Versions.`2026-11-01-preview`)
model McpAuthorizationPolicyReference {
  /** The name of the MCP authorization policy. */
  @minLength(1)
  name: string;
}

/** The runtime status of an MCP server connection. */
@added(Versions.`2026-11-01-preview`)
model McpServerConnectionStatus {
  /** The health state of the MCP server connection. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
