import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AttestationService;

@@clientName(AttestationService, "AttestationClient", "!autorest");

// AutoRest -> TypeSpec migration (Option 1): keep the generated operation (REST) clients
// internal so the hand-written AttestationClient / AttestationAdministrationClient remain
// the public API surface. Names match the legacy generated REST client names that the
// existing custom code references.
//
// NOTE: @access targets operations (not interfaces) in this TCGC version, so access is
// applied per-operation. Marking every operation internal makes the generated methods
// internal and propagates internal access to the models they use.
@@access(Policy.get, Access.internal);
@@access(Policy.set, Access.internal);
@@access(Policy.reset, Access.internal);
@@clientName(Policy, "PolicyRestClient");

@@access(PolicyCertificates.get, Access.internal);
@@access(PolicyCertificates.add, Access.internal);
@@access(PolicyCertificates.remove, Access.internal);
@@clientName(PolicyCertificates, "PolicyCertificatesRestClient");

@@access(Attestation.attestOpenEnclave, Access.internal);
@@access(Attestation.attestSgxEnclave, Access.internal);
@@access(Attestation.attestAzureGuest, Access.internal);
@@access(Attestation.attestTpm, Access.internal);
@@access(Attestation.attestSevSnpVm, Access.internal);
@@access(Attestation.attestTdxVm, Access.internal);
@@clientName(Attestation, "AttestationRestClient");

@@access(TcbBaselines.get, Access.internal);
@@clientName(TcbBaselines, "TcbBaselinesRestClient");

@@access(SigningCertificates.get, Access.internal);
@@clientName(SigningCertificates, "SigningCertificatesRestClient");

@@access(MetadataConfiguration.get, Access.internal);
@@clientName(MetadataConfiguration, "MetadataConfigurationRestClient");

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

// Unix-second timestamps: float32 loses precision for large epoch values (and DateTimeOffset.Max
// overflows). Map to int64 in C# so the hand-written DateTimeOffset props round-trip exactly.
@@alternateType(AttestationResult.iat, int64, "csharp");
@@alternateType(AttestationResult.exp, int64, "csharp");
@@alternateType(AttestationResult.nbf, int64, "csharp");
