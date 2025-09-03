import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Attestation;

@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn");
@@clientName(AttestationResult.svn, "deprecatedSvn");

@@clientLocation(PolicyOperationGroup.get, "Policy");
@@clientLocation(PolicyOperationGroup.set, "Policy");
@@clientLocation(PolicyOperationGroup.reset, "Policy");

@@clientLocation(PolicyCertificatesOperationGroup.get, "PolicyCertificates");
@@clientLocation(PolicyCertificatesOperationGroup.add, "PolicyCertificates");
@@clientLocation(PolicyCertificatesOperationGroup.remove, "PolicyCertificates");

@@clientLocation(AttestationOperationGroup.attestOpenEnclave, "Attestation");
@@clientLocation(AttestationOperationGroup.attestSgxEnclave, "Attestation");
@@clientLocation(AttestationOperationGroup.attestAzureGuest, "Attestation");
@@clientLocation(AttestationOperationGroup.attestTpm, "Attestation");
@@clientLocation(AttestationOperationGroup.attestSevSnpVm, "Attestation");
@@clientLocation(AttestationOperationGroup.attestTdxVm, "Attestation");

@@clientLocation(TcbBaselinesOperationGroup.get, "TcbBaselines");

@@clientLocation(SigningCertificatesOperationGroup.get, "SigningCertificates");

@@clientLocation(MetadataConfigurationOperationGroup.get,
  "MetadataConfiguration"
);

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
