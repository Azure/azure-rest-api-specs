import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * The configuration of the instance's client-facing MCP gateway.
 * An instance supports one gateway, enforced by edge admission validation.
 * Creating a second gateway is rejected with a validation error; PUT to the existing name updates it.
 */
@added(Versions.`2026-12-01-preview`)
@parentResource(InstanceResource)
model McpGatewayResource is ProxyResource<McpGatewayProperties> {
  /** The name of the instance's MCP gateway resource. */
  @key("mcpGatewayName")
  @path
  @segment("mcpGateways")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @minLength(3)
  @maxLength(63)
  name: string;

  /** The custom location of the gateway's Kubernetes cluster. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** The desired gateway endpoint and its output-only runtime status. */
@added(Versions.`2026-12-01-preview`)
model McpGatewayProperties {
  /** The incoming HTTPS endpoint. Backend registration and trust remain connection-owned. */
  endpoint: McpGatewayEndpoint;

  /** The status of the last provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The health of the gateway itself, without aggregating backend health. */
  @visibility(Lifecycle.Read)
  status?: McpGatewayStatus;
}

/** The gateway's Service port, incoming authentication, and required serving certificate. */
@added(Versions.`2026-12-01-preview`)
model McpGatewayEndpoint {
  /** The Kubernetes Service port, distinct from the owner-managed container port. */
  @minValue(1)
  @maxValue(65535)
  servicePort?: int32 = 443;

  /** The required authentication for incoming client requests. */
  authentication: McpGatewayAuthentication;

  /** The required serving TLS configuration, using the same certificate settings as BrokerListener. */
  tls: TlsCertMethod;
}

/** The authentication configuration for clients calling the gateway. */
@added(Versions.`2026-12-01-preview`)
model McpGatewayAuthentication {
  /** The incoming authentication method. Only ServiceAccountToken is supported. */
  method: ServiceAccountTokenMethod;

  /**
   * The accepted incoming token audiences, independent of outbound backend tokens.
   * When omitted, the gateway accepts the default audience `aio-mcp-frontend`.
   */
  serviceAccountTokenSettings?: BrokerAuthenticatorMethodSat;
}

/** The output-only health of the gateway's serving, authentication, and routing subsystems. */
@added(Versions.`2026-12-01-preview`)
model McpGatewayStatus {
  /** Gateway runtime health. AIO MCP and other backend health remain on their connections. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
