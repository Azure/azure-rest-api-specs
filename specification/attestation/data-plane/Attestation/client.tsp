import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AttestationService;

@@clientName(AttestationService, "AttestationClient", "csharp");

@@access(Policy.get, Access.internal, "csharp");
@@access(Policy.set, Access.internal, "csharp");
@@access(Policy.reset, Access.internal, "csharp");
@@clientName(Policy, "PolicyRestClient", "csharp");

@@access(PolicyCertificates.get, Access.internal, "csharp");
@@access(PolicyCertificates.add, Access.internal, "csharp");
@@access(PolicyCertificates.remove, Access.internal, "csharp");
@@clientName(PolicyCertificates, "PolicyCertificatesRestClient", "csharp");

@@access(Attestation.attestOpenEnclave, Access.internal, "csharp");
@@access(Attestation.attestSgxEnclave, Access.internal, "csharp");
@@access(Attestation.attestAzureGuest, Access.internal, "csharp");
@@access(Attestation.attestTpm, Access.internal, "csharp");
@@access(Attestation.attestSevSnpVm, Access.internal, "csharp");
@@access(Attestation.attestTdxVm, Access.internal, "csharp");
@@clientName(Attestation, "AttestationRestClient", "csharp");

@@access(TcbBaselines.get, Access.internal, "csharp");
@@clientName(TcbBaselines, "TcbBaselinesRestClient", "csharp");

@@access(SigningCertificates.get, Access.internal, "csharp");
@@clientName(SigningCertificates, "SigningCertificatesRestClient", "csharp");

@@access(MetadataConfiguration.get, Access.internal, "csharp");
@@clientName(
  MetadataConfiguration,
  "MetadataConfigurationRestClient",
  "csharp"
);

@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn", "csharp");
@@clientName(AttestationResult.svn, "deprecatedSvn", "csharp");

@@usage(CertificateModification, Usage.output, "csharp");
@@usage(PolicyModification, Usage.output, "csharp");
@@usage(AttestOpenEnclaveRequest, Usage.output, "csharp");
@@usage(AttestSgxEnclaveRequest, Usage.output, "csharp");
@@usage(JsonWebKeySet, Usage.output, "csharp");
@@usage(PolicyCertificatesResult, Usage.output, "csharp");
@@usage(PolicyCertificatesModificationResult, Usage.output, "csharp");
@@usage(StoredAttestationPolicy, Usage.output, "csharp");
@@usage(PolicyResult, Usage.output, "csharp");
@@usage(AttestationResult, Usage.output, "csharp");
@@usage(AttestationCertificateManagementBody, Usage.output, "csharp");

@@access(PolicyResult, Access.public, "csharp");
@@access(AttestationCertificateManagementBody, Access.public, "csharp");
@@access(TpmAttestationRequest, Access.public, "csharp");
@@access(CertificateModification, Access.public, "csharp");
@@usage(TpmAttestationRequest, Usage.input, "csharp");

@@alternateType(AttestationResult.iat, int64, "csharp");
@@alternateType(AttestationResult.exp, int64, "csharp");
@@alternateType(AttestationResult.nbf, int64, "csharp");
