import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("The x509 certificate for authentication mode Certificate.")
@added(Versions.v2026_02_01_preview)
model X509CertificateCredentials {
  @doc("The name of the secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  certificateSecretName: string;

  @doc("The name of the secret containing the certificate private key in PEM or DER format.")
  keySecretName?: string;

  @doc("The name of the secret containing the combined intermediate certificates in PEM format.")
  intermediateCertificatesSecretName?: string;
}
