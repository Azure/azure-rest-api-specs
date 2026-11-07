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

/** The configuration of the instance's client-facing MCP frontend. */
@added(Versions.`2026-11-01-preview`)
@parentResource(InstanceResource)
model McpFrontendResource is ProxyResource<McpFrontendProperties> {
  /** The name of the instance's MCP frontend resource. */
  @key("mcpFrontendName")
  @path
  @segment("mcpFrontends")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  name: string;

  /** The custom location of the frontend's Kubernetes cluster. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports only CustomLocation, consistent with the existing MCP resources."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** The desired frontend endpoint and its output-only runtime status. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendProperties {
  /** The incoming HTTPS endpoint. Backend registration and trust remain connection-owned. */
  endpoint: McpFrontendEndpoint;

  /** The status of the last provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The health of the frontend itself, without aggregating backend health. */
  @visibility(Lifecycle.Read)
  status?: McpFrontendStatus;
}

/** The frontend's Service port, incoming authentication, and required serving certificate. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendEndpoint {
  /** The Kubernetes Service port, distinct from the owner-managed container port. */
  @minValue(1)
  @maxValue(65535)
  servicePort?: int32 = 443;

  /** The required authentication for incoming client requests. */
  authentication: McpFrontendAuthentication;

  /** The required serving TLS configuration, using the same certificate settings as BrokerListener. */
  tls: TlsCertMethod;
}

/** The authentication configuration for clients calling the frontend. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendAuthentication {
  /** The incoming authentication method. Only ServiceAccountToken is supported. */
  method: ServiceAccountTokenMethod;

  /** The accepted incoming token audiences, independent of outbound backend tokens. */
  serviceAccountTokenSettings?: BrokerAuthenticatorMethodSat;
}

/** The output-only health of the frontend's serving, authentication, and routing subsystems. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendStatus {
  /** Frontend runtime health. AIO MCP and other backend health remain on their connections. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
