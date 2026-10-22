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

  /** The required serving TLS configuration. */
  tls: McpFrontendTls;
}

/** The authentication configuration for clients calling the frontend. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendAuthentication {
  /** The incoming authentication method. Only ServiceAccountToken is supported. */
  method: ServiceAccountTokenMethod;

  /** The accepted incoming token audiences, independent of outbound backend tokens. */
  serviceAccountTokenSettings: McpFrontendServiceAccountTokenSettings;
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

/** The serving certificate mode. Only the configuration for the selected mode is valid. */
@added(Versions.`2026-11-01-preview`)
@discriminator("mode")
model McpFrontendTls {
  /** Automatic certificate issuance or a manually managed serving Secret. */
  mode: TlsCertMethodMode;
}

/** Automatic serving certificate issuance using cert-manager. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendAutomaticTls extends McpFrontendTls {
  /** Selects automatic certificate issuance. */
  mode: "Automatic";

  /** The issuer used for the frontend Service's DNS names. Manual settings are not permitted. */
  certManagerCertificateSpec: McpFrontendCertificateSpec;
}

/** The certificate issuance settings exposed for the frontend. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendCertificateSpec {
  /** The cert-manager issuer; this reference does not distribute CA trust to clients. */
  issuerRef: McpFrontendIssuerRef;
}

/** A cert-manager issuer reference with an explicit group and non-blank name. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendIssuerRef {
  /** The non-blank name of the issuer. */
  @minLength(1)
  @pattern("\\S")
  name: string;

  /** The issuer kind. Only Issuer and ClusterIssuer are supported. */
  kind: CertManagerIssuerKind;

  /** The API group of the issuer. */
  group: "cert-manager.io";
}

/** A manually managed frontend serving certificate and key. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendManualTls extends McpFrontendTls {
  /** Selects a manually managed certificate. */
  mode: "Manual";

  /** The serving Secret reference. Automatic issuance settings are not permitted. */
  manual: McpFrontendManualCertificate;
}

/** A same-namespace Kubernetes TLS Secret containing tls.crt and tls.key. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendManualCertificate {
  /** The non-blank name of the customer-managed serving Secret, not its contents. */
  @minLength(1)
  @pattern("\\S")
  secretRef: string;
}

/** The output-only health of the frontend's serving, authentication, and routing subsystems. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendStatus {
  /** Frontend runtime health. AIO MCP and other backend health remain on their connections. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
