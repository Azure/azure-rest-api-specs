/*
  Definitions of elements exclusively defined for pipeline group TLS configuration.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("TLS security mode defining the level of transport security.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union TlsMode {
  string,

  @doc("No TLS encryption - plain text communication.")
  Disabled: "disabled",

  @doc("Server-side TLS only - encrypts communication but doesn't validate client certificates.")
  ServerOnly: "serverOnly",

  @doc("Mutual TLS - encrypts communication and validates both server and client certificates.")
  MutualTls: "mutualTls",
}

@doc("TLS configuration that can be referenced by receivers.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TlsConfiguration {
  @doc("The name of the TLS configuration.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("The TLS security mode for receivers using this configuration. Default is 'mutualTls'.")
  mode?: TlsMode = TlsMode.MutualTls;

  @doc("TLS certificate and its private key. If not specified, default TLS certificate is used.")
  tlsCertificate?: CertificateWithKey;

  @doc("Certificate source configuration for the client CA certificate for validating client certificates. If not specified, default CA certificates are used.")
  clientCa?: CertificateSource;
}

@doc("TLS certificate and private key pair.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model CertificateWithKey {
  @doc("Source configuration for the TLS certificate.")
  certificate: CertificateSource;

  @doc("Source configuration for the private key. Private keys must be stored in Kubernetes secrets for security reasons.")
  privateKey: PrivateKeySource;
}

@doc("Configuration for certificate source location.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model CertificateSource {
  @doc("The type of certificate source.")
  type: CertificateSourceType;

  @doc("Location of the certificate source.")
  location: string;

  @doc("Sub-location within the certificate source.")
  subLocation: string;
}

@doc("Configuration for private key source location.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model PrivateKeySource {
  @doc("The type of private key source. Only kubernetesSecret is supported for security reasons.")
  type: PrivateKeySourceType;

  @doc("Location of the private key source.")
  location: string;

  @doc("Sub-location within the private key source.")
  subLocation: string;
}

@doc("The type of certificate source.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union CertificateSourceType {
  string,

  @doc("Certificate stored in a Kubernetes secret.")
  KubernetesSecret: "kubernetesSecret",

  @doc("Certificate stored in a Kubernetes configmap.")
  KubernetesConfigMap: "kubernetesConfigMap",
}

@doc("The type of private key source.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union PrivateKeySourceType {
  string,

  @doc("Private key stored in a Kubernetes secret. This is the only supported type for security reasons.")
  KubernetesSecret: "kubernetesSecret",
}
