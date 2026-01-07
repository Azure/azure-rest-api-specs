import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("Tls revoke modes")
union TlsRevokeMode {
  @doc("Disable revoke check.")
  Off: "Off",

  @doc("CRL model.")
  CRL: "CRL",

  @doc("OCSP model.")
  OCSP: "OCSP",

  @doc("Both check model.")
  CRLAndOCSP: "CRLAndOCSP",

  string,
}

@doc("CertificateAuthentication Model.")
model CertificateAuthentication {
  @doc("Self-signed CA, null means client certificate is signed off by public well-known CA")
  certificationAuthorityCert?: KeyVaultCertificateInfo;

  @doc("Client certificate is signed off either by private CA (specified by certCa) or public well-known CA. If it's null, mTLS is turned off, i.e. server side shall be configured as not validate client.")
  clientCert?: KeyVaultCertificateInfo;

  @doc("Certificate revoke mode: off, CRL, OCSP, CRL+OCSP.")
  tlsRevokeMode?: TlsRevokeMode;
}
