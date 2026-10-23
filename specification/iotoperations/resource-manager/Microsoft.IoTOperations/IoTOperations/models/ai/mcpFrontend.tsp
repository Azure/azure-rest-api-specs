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
  /** The fixed name of the instance's MCP frontend resource. Only the value 'default' is allowed. */
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
  tls: McpFrontendTls;
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

/** The frontend's serving certificate configuration. Only the selected mode's settings apply. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendTls {
  /** The mode of TLS server certificate management. */
  mode: McpFrontendTlsMode;

  /** Automatic TLS server certificate management with cert-manager. */
  certManagerCertificateSpec?: McpFrontendCertificateSpec;

  /** Manual TLS server certificate management through a referenced Secret. */
  manual?: McpFrontendManualCertificate;
}

/** The frontend's TLS server certificate management modes. */
@added(Versions.`2026-11-01-preview`)
union McpFrontendTlsMode {
  string,

  /** Automatic TLS server certificate configuration. */
  Automatic: "Automatic",

  /** Manual TLS server certificate configuration. */
  Manual: "Manual",
}

/** Automatic frontend TLS server certificate management with cert-manager. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendCertificateSpec {
  /** Certificate lifetime in Go time.Duration format (h|m|s), for example 240h or 45m. */
  duration?: string;

  /** Name of the Secret for storing the server certificate. Any existing data will be overwritten. */
  secretName?: string;

  /** Time before expiry to begin renewal, in Go time.Duration format (h|m|s). */
  renewBefore?: string;

  /** The cert-manager issuer reference. */
  issuerRef: McpFrontendIssuerRef;

  /** The certificate private-key settings. */
  privateKey?: McpFrontendPrivateKey;

  /** Additional Subject Alternative Names (SANs) to include in the certificate. */
  san?: McpFrontendCertificateSan;
}

/** The issuer used to issue the frontend's serving certificate. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendIssuerRef {
  /** The API group of the issuer. */
  group?: string = "cert-manager.io";

  /** The kind of issuer. */
  kind: McpFrontendIssuerKind;

  /** The non-blank name of the issuer. */
  @minLength(1)
  @pattern("\\S")
  name: string;
}

/** The frontend certificate issuer kinds. */
@added(Versions.`2026-11-01-preview`)
union McpFrontendIssuerKind {
  string,

  /** A namespaced issuer. */
  Issuer: "Issuer",

  /** A cluster-scoped issuer. */
  ClusterIssuer: "ClusterIssuer",
}

/** The frontend certificate private-key settings. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendPrivateKey {
  /** The private-key algorithm. */
  algorithm: McpFrontendPrivateKeyAlgorithm;

  /** The cert-manager private-key rotation policy. */
  rotationPolicy: McpFrontendPrivateKeyRotationPolicy;
}

/** The frontend certificate private-key algorithms. */
@added(Versions.`2026-11-01-preview`)
union McpFrontendPrivateKeyAlgorithm {
  string,

  /** Elliptic curve with a 256-bit key. */
  Ec256: "Ec256",

  /** Elliptic curve with a 384-bit key. */
  Ec384: "Ec384",

  /** Elliptic curve with a 521-bit key. */
  Ec521: "Ec521",

  /** Ed25519. */
  Ed25519: "Ed25519",

  /** RSA with a 2048-bit key. */
  Rsa2048: "Rsa2048",

  /** RSA with a 4096-bit key. */
  Rsa4096: "Rsa4096",

  /** RSA with an 8192-bit key. */
  Rsa8192: "Rsa8192",
}

/** The frontend certificate private-key rotation policies. */
@added(Versions.`2026-11-01-preview`)
union McpFrontendPrivateKeyRotationPolicy {
  string,

  /** Rotate the private key whenever the certificate is renewed. */
  Always: "Always",

  /** Retain the existing private key when renewing the certificate. */
  Never: "Never",
}

/** Additional Subject Alternative Names (SANs) for the frontend certificate. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendCertificateSan {
  /** DNS SANs. */
  dns: string[] = #[];

  /** IP address SANs. */
  ip: string[] = #[];
}

/** A manually managed frontend TLS certificate. */
@added(Versions.`2026-11-01-preview`)
model McpFrontendManualCertificate {
  /** Non-blank name of the Kubernetes Secret containing the certificate and private key, not the Secret contents. */
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
