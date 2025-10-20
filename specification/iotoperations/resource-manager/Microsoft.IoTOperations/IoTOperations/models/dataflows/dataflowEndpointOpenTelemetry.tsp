import "@typespec/http";

using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

/** OpenTelemetry endpoint properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowEndpointOpenTelemetry {
  /** Host of the OpenTelemetry in the form of <host>:<port>. */
  host: string;

  /** Batching configuration. */
  batching?: BatchingConfiguration;

  /** TLS configuration. */
  tls?: TlsProperties;

  /** Authentication properties for OpenTelemetry endpoints */
  authentication: DataflowOpenTelemetryAuthentication;
}

/** Dataflow OpenTelemetry authentication properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("method")
model DataflowOpenTelemetryAuthentication {
  /** The authentication method. */
  method: DataflowOpenTelemetryAuthenticationMethod;
}

/** Dataflow OpenTelemetry authentication method values. */
@added(Versions.`2025-07-01-preview`)
union DataflowOpenTelemetryAuthenticationMethod {
  string,

  /** Uses serviceaccount token. */
  ServiceAccountToken,

  /** Uses x509 certificate. */
  X509Certificate,

  /** Connects anonymously. */
  Anonymous,
}

/** DataflowOpenTelemetryServiceAccountAuthentication properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowOpenTelemetryServiceAccountAuthentication
  extends DataflowOpenTelemetryAuthentication {
  /** The authentication method. */
  method: ServiceAccountToken;

  /** Kubernetes service account token authentication. */
  serviceAccountTokenSettings: DataflowEndpointAuthenticationServiceAccountToken;
}

/** DataflowOpenTelemetryX509CertificateAuthentication properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowOpenTelemetryX509CertificateAuthentication
  extends DataflowOpenTelemetryAuthentication {
  /** The authentication method. */
  method: X509Certificate;

  /** X.509 certificate authentication settings. */
  x509CertificateSettings: DataflowEndpointAuthenticationX509;
}

/** DataflowOpenTelemetryAnonymousAuthentication properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowOpenTelemetryAnonymousAuthentication
  extends DataflowOpenTelemetryAuthentication {
  /** The authentication method. */
  method: Anonymous;

  /** Settings for the anonymous connection */
  anonymousSettings: DataflowEndpointAuthenticationAnonymous;
}
