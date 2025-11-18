import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("SslConfiguration Model.")
model SslConfiguration {
  @doc("Certificate Authority.")
  certificationAuthorityCert?: KeyVaultCertificateInfo;

  @doc("Cipher Suites configuration.")
  cipherSuites?: string;

  @doc("Whether verify the server hostname with the certificate.")
  verifyHostname?: boolean;
}
