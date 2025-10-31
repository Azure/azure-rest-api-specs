import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AttestationService;

@@clientName(AttestationService, "AttestationClient");

@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn");
@@clientName(AttestationResult.svn, "deprecatedSvn");

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
