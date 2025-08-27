import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Attestation;

@@clientName(JsonWebKey.x5c, "x5C");

@@clientName(OpenIDConfigurationResponse.response_types_supported,
  "responseTypesSupported"
);
@@clientName(OpenIDConfigurationResponse.id_token_signing_alg_values_supported,
  "idTokenSigningAlgValuesSupported"
);
@@clientName(OpenIDConfigurationResponse.revocation_endpoint,
  "revocationEndpoint"
);
@@clientName(OpenIDConfigurationResponse.jwks_uri, "jwksUri");
@@clientName(OpenIDConfigurationResponse.claims_supported, "claimsSupported");

@@clientName(PolicyCertificatesResult.`x-ms-policy-certificates`,
  "policyCertificates"
);

@@clientName(PolicyCertificatesModificationResult.`x-ms-certificate-thumbprint`,
  "certificateThumbprint"
);
@@clientName(PolicyCertificatesModificationResult.`x-ms-policycertificates-result`,
  "certificateResolution"
);

@@clientName(StoredAttestationPolicy.AttestationPolicy, "attestationPolicy");

@@clientName(PolicyResult.`x-ms-policy-result`, "policyResolution");
@@clientName(PolicyResult.`x-ms-policy-token-hash`, "policyTokenHash");
@@clientName(PolicyResult.`x-ms-policy-signer`, "policySigner");
@@clientName(PolicyResult.`x-ms-policy`, "policy");

@@clientName(AttestationResult.`x-ms-ver`, "version");
@@clientName(AttestationResult.`x-ms-runtime`, "runtimeClaims");
@@clientName(AttestationResult.`x-ms-inittime`, "inittimeClaims");
@@clientName(AttestationResult.`x-ms-policy`, "policyClaims");
@@clientName(AttestationResult.`x-ms-attestation-type`, "verifierType");
@@clientName(AttestationResult.`x-ms-policy-signer`, "policySigner");
@@clientName(AttestationResult.`x-ms-policy-hash`, "policyHash");
@@clientName(AttestationResult.`x-ms-sgx-is-debuggable`, "IsDebuggable");
@@clientName(AttestationResult.`x-ms-sgx-product-id`, "productId");
@@clientName(AttestationResult.`x-ms-sgx-mrenclave`, "mrEnclave");
@@clientName(AttestationResult.`x-ms-sgx-mrsigner`, "mrSigner");
@@clientName(AttestationResult.`x-ms-sgx-svn`, "svn");
@@clientName(AttestationResult.`x-ms-sgx-ehd`, "enclaveHeldData");
@@clientName(AttestationResult.`x-ms-sgx-collateral`, "sgxCollateral");
@@clientName(AttestationResult.ver, "deprecatedVersion");
@@clientName(AttestationResult.`is-debuggable`, "deprecatedIsDebuggable");
@@clientName(AttestationResult.`maa-attestationcollateral`,
  "deprecatedSgxCollateral"
);
@@clientName(AttestationResult.`aas-ehd`, "deprecatedEnclaveHeldData");
@@clientName(AttestationResult.`maa-ehd`, "deprecatedEnclaveHeldData2");
@@clientName(AttestationResult.`product-id`, "deprecatedProductId");
@@clientName(AttestationResult.`sgx-mrenclave`, "deprecatedMrEnclave");
@@clientName(AttestationResult.`sgx-mrsigner`, "deprecatedMrSigner");
@@clientName(AttestationResult.svn, "deprecatedSvn");
@@clientName(AttestationResult.tee, "deprecatedTee");
@@clientName(AttestationResult.policy_signer, "deprecatedPolicySigner");
@@clientName(AttestationResult.policy_hash, "deprecatedPolicyHash");
@@clientName(AttestationResult.rp_data, "deprecatedRpData");

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
