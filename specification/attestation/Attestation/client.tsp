import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AttestationService;

@@clientName(AttestationService, "Attestation");

@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn");
@@clientName(AttestationResult.svn, "deprecatedSvn");

@@clientLocation(Policy.get, "Policy");
@@clientLocation(Policy.set, "Policy");
@@clientLocation(Policy.reset, "Policy");

@@clientLocation(PolicyCertificates.get, "PolicyCertificates");
@@clientLocation(PolicyCertificates.add, "PolicyCertificates");
@@clientLocation(PolicyCertificates.remove, "PolicyCertificates");

@@clientLocation(Attestation.attestOpenEnclave, "Attestation");
@@clientLocation(Attestation.attestSgxEnclave, "Attestation");
@@clientLocation(Attestation.attestAzureGuest, "Attestation");
@@clientLocation(Attestation.attestTpm, "Attestation");
@@clientLocation(Attestation.attestSevSnpVm, "Attestation");
@@clientLocation(Attestation.attestTdxVm, "Attestation");

@@clientLocation(TcbBaselines.get, "TcbBaselines");

@@clientLocation(SigningCertificates.get, "SigningCertificates");

@@clientLocation(MetadataConfiguration.get, "MetadataConfiguration");

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
