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
@singleton("default")
model McpFrontendResource is ProxyResource<McpFrontendProperties> {
  /** The fixed name of the instance's MCP frontend resource. */
  @key("mcpFrontendName")
  @path
  @segment("mcpFrontends")
  @pattern("^default$")
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
@discriminator("method")
model McpFrontendAuthentication {
  /** The incoming authentication method. Only ServiceAccountToken is supported. */
  method: McpFrontendAuthenticationMethod;
}

/** Kubernetes service account token authentication for clients calling the frontend. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendServiceAccountTokenAuthentication
  extends McpFrontendAuthentication {
  /** Selects Kubernetes service account token authentication. */
  method: "ServiceAccountToken";

  /** The accepted incoming token audiences, independent of outbound backend tokens. */
  serviceAccountTokenSettings: McpFrontendServiceAccountTokenSettings;
}

/** The authentication methods for clients calling the frontend. */
@added(Versions.`2026-11-01-preview`)
union McpFrontendAuthenticationMethod {
  string,

  /** Kubernetes service account token authentication. */
  ServiceAccountToken: "ServiceAccountToken",
}

/** The Kubernetes service account token validation settings for the frontend. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendServiceAccountTokenSettings {
  /** One to sixteen unique, non-blank audiences accepted on incoming requests. */
  @minItems(1)
  @maxItems(16)
  @Azure.Core.uniqueItems
  audiences: McpFrontendAudience[];
}

/** A non-blank incoming token audience of at most 256 characters. */
@added(Versions.`2026-11-01-preview`)
@minLength(1)
@maxLength(256)
@pattern("\\S")
scalar McpFrontendAudience extends string;

/** The output-only health of the frontend's serving, authentication, and routing subsystems. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendStatus {
  /** Frontend runtime health. AIO MCP and other backend health remain on their connections. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
