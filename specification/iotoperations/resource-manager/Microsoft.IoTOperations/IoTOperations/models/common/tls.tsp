import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

@doc("Collection of different TLS types, NOTE- Enum at a time only one of them needs to be supported")
model TlsCertMethod {
  @doc("Mode of TLS server certificate management.")
  mode: TlsCertMethodMode;

  @doc("Option 1 - Automatic TLS server certificate management with cert-manager.")
  certManagerCertificateSpec?: CertManagerCertificateSpec;

  @doc("Option 2 - Manual TLS server certificate management through a defined secret.")
  manual?: X509ManualCertificate;
}

@doc("Broker Authentication Mode")
union TlsCertMethodMode {
  string,

  @doc("Automatic TLS server certificate configuration.")
  Automatic: "Automatic",

  @doc("Manual TLS server certificate configuration.")
  Manual: "Manual",
}

@doc("Automatic TLS server certificate management with cert-manager")
model CertManagerCertificateSpec {
  @doc("Lifetime of certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  duration?: string;

  @doc("Secret for storing server certificate. Any existing data will be overwritten. This is a reference to the secret through an identifying name, not the secret itself.")
  secretName?: string;

  @doc("When to begin renewing certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  renewBefore?: string;

  @doc("cert-manager issuerRef.")
  issuerRef: CertManagerIssuerRef;

  @doc("Type of certificate private key.")
  privateKey?: CertManagerPrivateKey;

  @doc("Additional Subject Alternative Names (SANs) to include in the certificate.")
  san?: SanForCert;
}

@doc("Subject Alternative Names (SANs) for certificate.")
model SanForCert {
  @doc("DNS SANs.")
  dns: string[] = #[];

  @doc("IP address SANs.")
  ip: string[] = #[];
}

@doc("Cert-Manager issuerRef properties")
model CertManagerIssuerRef {
  @doc("group of issuer.")
  @madeOptional(Versions.`2026-10-01`)
  group?: string = "cert-manager.io";

  @doc("kind of issuer (Issuer or ClusterIssuer).")
  kind: CertManagerIssuerKind;

  @doc("name of issuer.")
  name: string;
}

@doc("CertManagerIssuerKind properties")
union CertManagerIssuerKind {
  string,

  @doc("Issuer kind.")
  Issuer: "Issuer",

  @doc("ClusterIssuer kind.")
  ClusterIssuer: "ClusterIssuer",
}

@doc("Cert Manager private key properties")
model CertManagerPrivateKey {
  @doc("algorithm for private key.")
  algorithm: PrivateKeyAlgorithm;

  @doc("cert-manager private key rotationPolicy.")
  rotationPolicy: PrivateKeyRotationPolicy;
}

@doc("Private key algorithm types.")
union PrivateKeyAlgorithm {
  string,

  @doc("Algorithm - ec256.")
  Ec256: "Ec256",

  @doc("Algorithm - ec384.")
  Ec384: "Ec384",

  @doc("Algorithm - ec521.")
  Ec521: "Ec521",

  @doc("Algorithm - ed25519.")
  Ed25519: "Ed25519",

  @doc("Algorithm - rsa2048.")
  Rsa2048: "Rsa2048",

  @doc("Algorithm - rsa4096.")
  Rsa4096: "Rsa4096",

  @doc("Algorithm - rsa8192.")
  Rsa8192: "Rsa8192",
}

@doc("Private key rotation policy.")
union PrivateKeyRotationPolicy {
  string,

  @doc("Rotation Policy - Always.")
  Always: "Always",

  @doc("Rotation Policy - Never.")
  Never: "Never",
}

@doc("X509 Certificate Authentication properties.")
model X509ManualCertificate {
  @doc("Kubernetes secret containing an X.509 client certificate. This is a reference to the secret through an identifying name, not the secret itself.")
  secretRef: string;
}
