import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AttestationService;

@@clientName(AttestationService, "AttestationClient", "!autorest");

@@access(Policy.get, Access.internal);
@@access(Policy.set, Access.internal);
@@access(Policy.reset, Access.internal);
@@clientName(Policy, "PolicyRestClient", "!autorest");

@@access(PolicyCertificates.get, Access.internal);
@@access(PolicyCertificates.add, Access.internal);
@@access(PolicyCertificates.remove, Access.internal);
@@clientName(PolicyCertificates, "PolicyCertificatesRestClient", "!autorest");

@@access(Attestation.attestOpenEnclave, Access.internal);
@@access(Attestation.attestSgxEnclave, Access.internal);
@@access(Attestation.attestAzureGuest, Access.internal);
@@access(Attestation.attestTpm, Access.internal);
@@access(Attestation.attestSevSnpVm, Access.internal);
@@access(Attestation.attestTdxVm, Access.internal);
@@clientName(Attestation, "AttestationRestClient", "!autorest");

@@access(TcbBaselines.get, Access.internal);
@@clientName(TcbBaselines, "TcbBaselinesRestClient", "!autorest");

@@access(SigningCertificates.get, Access.internal);
@@clientName(SigningCertificates, "SigningCertificatesRestClient", "!autorest");

@@access(MetadataConfiguration.get, Access.internal);
@@clientName(
  MetadataConfiguration,
  "MetadataConfigurationRestClient",
  "!autorest"
);

@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn", "!autorest");
@@clientName(AttestationResult.svn, "deprecatedSvn", "!autorest");

@@usage(CertificateModification, Usage.output);
@@usage(PolicyModification, Usage.output);
@@usage(AttestOpenEnclaveRequest, Usage.output);
@@usage(AttestSgxEnclaveRequest, Usage.output);
@@usage(JsonWebKeySet, Usage.output);
@@usage(PolicyCertificatesResult, Usage.output);
@@usage(PolicyCertificatesModificationResult, Usage.output);
@@usage(StoredAttestationPolicy, Usage.output);
@@usage(PolicyResult, Usage.output);
@@usage(AttestationResult, Usage.output);
@@usage(AttestationCertificateManagementBody, Usage.output);

@@access(PolicyResult, Access.public);
@@access(AttestationCertificateManagementBody, Access.public);
@@access(TpmAttestationRequest, Access.public);
@@access(CertificateModification, Access.public);
@@usage(TpmAttestationRequest, Usage.input);

@@alternateType(AttestationResult.iat, int64, "csharp");
@@alternateType(AttestationResult.exp, int64, "csharp");
@@alternateType(AttestationResult.nbf, int64, "csharp");
