import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

namespace AttestationService;

/**
 * Content type for upload
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Intentionally closed for HTTP Content-Type header compliance"
union SigningCertificatesContentType {
  /**
   * Content Type 'application/jwk+json'
   */
  "application/jwk+json",

  /**
   * Content Type 'application/json'
   */
  "application/json",
}

/**
 * AttestationType
 */
union AttestationType {
  string,

  /**
   * Intel Software Guard eXtensions
   */
  SgxEnclave: "SgxEnclave",

  /**
   * OpenEnclave extensions to SGX
   */
  OpenEnclave: "OpenEnclave",

  /**
   * Azure Guest Attestation
   */
  AzureGuest: "AzureGuest",

  /**
   * AMD SEV SNP Virtual Machine
   */
  SevSnpVm: "SevSnpVm",

  /**
   * Edge TPM Virtualization Based Security
   */
  Tpm: "Tpm",

  /**
   * Intel TDX Virtual Machine
   */
  TdxVm: "TdxVm",
}

/**
 * Specifies the type of the data encoded contained within the "data" field of a
 * "RuntimeData" or "InitTimeData" object
 */
union DataType {
  string,

  /**
   * The field's content should be treated as binary and not interpreted by MAA.
   */
  Binary: "Binary",

  /**
   * The field's content should be treated as UTF-8 JSON text that may be further
   * interpreted by MAA. Refer to RFC 8259 for a description of JSON serialization
   * standards for interoperability.
   */
  JSON: "JSON",
}

/**
 * The result of the operation
 */
union CertificateModification {
  string,

  /**
   * After the operation was performed, the certificate is in the set of
   * certificates.
   */
  IsPresent: "IsPresent",

  /**
   * After the operation was performed, the certificate is no longer present in the
   * set of certificates.
   */
  IsAbsent: "IsAbsent",
}

/**
 * The result of the operation
 */
union PolicyModification {
  string,

  /**
   * The specified policy object was updated.
   */
  Updated: "Updated",

  /**
   * The specified policy object was removed.
   */
  Removed: "Removed",
}

/** Request model for adding a policy certificate */
model AddPolicyCertificateRequest {
  /** The certificate to add, as a string (e.g., PEM or JWK) */
  policyCertificateToAdd: string;
}

/** Request model for removing a policy certificate */
model RemovePolicyCertificateRequest {
  /** The certificate to remove, as a string (e.g., PEM or JWK) */
  policyCertificateToRemove: string;
}

/**
 * The response to an attestation policy operation
 */
model PolicyResponse {
  /**
   * An RFC7519 JSON Web Token structure whose body is an PolicyResult object.
   */
  @pattern("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]*\\.[A-Za-z0-9_-]*")
  token?: string;
}

/**
 * An error response from Attestation.
 */
@error
model CloudError {
  /**
   * An error response from Attestation.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from Attestation.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be
   * consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for displaying in a
   * user interface.
   */
  message?: string;
}

/**
 * The response to an attestation policy management API
 */
model PolicyCertificatesResponse {
  /**
   * An RFC7519 JSON Web Token structure containing a PolicyCertificatesResults
   * object which contains the certificates used to validate policy changes
   */
  @pattern("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]*\\.[A-Za-z0-9_-]*")
  token?: string;
}

/**
 * The response to an attestation policy management API
 */
model PolicyCertificatesModifyResponse {
  /**
   * An RFC7519 JSON Web Token structure whose body is a
   * PolicyCertificatesModificationResult object.
   */
  @pattern("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]*\\.[A-Za-z0-9_-]*")
  token?: string;
}

/**
 * Attestation request for Intel SGX enclaves
 */
model AttestOpenEnclaveRequest {
  /**
   * OpenEnclave report from the enclave to be attested
   */
  @encode(BytesKnownEncoding.base64url)
  report?: bytes;

  /**
   * Runtime data provided by the enclave at the time of report generation. The MAA
   * will verify that the first 32 bytes of the report_data field of the quote
   * contains the SHA256 hash of the decoded "data" field of the runtime data.
   */
  runtimeData?: RuntimeData;

  /**
   * Base64Url encoded "InitTime data". The MAA will verify that the init data was
   * known to the enclave. Note that InitTimeData is invalid for CoffeeLake
   * processors.
   */
  initTimeData?: InitTimeData;

  /**
   * Attest against the provided draft policy. Note that the resulting token cannot
   * be validated.
   */
  draftPolicyForAttestation?: string;

  /**
   * Nonce for incoming request - emitted in the generated attestation token
   */
  nonce?: string;
}

/**
 * Runtime data are a conduit for any information defined by the Trusted Execution
 * Environment (TEE) when actually running.
 */
model RuntimeData {
  /**
   * Runtime data are generated by the Trusted Execution Environment (TEE). For an
   * SGX quote (Coffeelake or Icelake), the SHA256 hash of the RuntimeData must
   * match the lower 32 bytes of the quote's "report data" attribute. For a SEV-SNP
   * quote, the SHA256 hash of the RuntimeData must match the quote's "report data"
   * attribute.
   */
  @encode(BytesKnownEncoding.base64url)
  data?: bytes;

  /**
   * The type of data contained within the "data" field
   */
  dataType?: DataType;
}

/**
 * Initialization time data are a conduit for any configuration information that
 * is unknown when building the Trusted Execution Environment (TEE) and is defined
 * at TEE launch time. This data can be used with confidential container or VM
 * scenarios to capture configuration settings such as disk volume content,
 * network configuration, etc.
 */
model InitTimeData {
  /**
   * Initialization time data are passed into the Trusted Execution Environment
   * (TEE) when it is created. For an Icelake SGX quote, the SHA256 hash of the
   * InitTimeData must match the lower 32 bytes of the quote's "config id"
   * attribute. For a SEV-SNP quote, the SHA256 hash of the InitTimeData must match
   * the quote's "host data" attribute.
   */
  @encode(BytesKnownEncoding.base64url)
  data?: bytes;

  /**
   * The type of data contained within the "data" field
   */
  dataType?: DataType;
}

/**
 * The result of an attestation operation
 */
model AttestationResponse {
  /**
   * An RFC 7519 JSON Web Token, the body of which is an AttestationResult object.
   */
  @pattern("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]*\\.[A-Za-z0-9_-]*")
  token?: string;
}

/**
 * Attestation request for Intel SGX enclaves
 */
model AttestSgxEnclaveRequest {
  /**
   * Quote of the enclave to be attested
   */
  @encode(BytesKnownEncoding.base64url)
  quote?: bytes;

  /**
   * Runtime data provided by the enclave at the time of quote generation. The MAA
   * will verify that the first 32 bytes of the report_data field of the quote
   * contains the SHA256 hash of the decoded "data" field of the runtime data.
   */
  runtimeData?: RuntimeData;

  /**
   * Initialization data provided when the enclave is created. MAA will verify that
   * the init data was known to the enclave. Note that InitTimeData is invalid for
   * CoffeeLake processors.
   */
  initTimeData?: InitTimeData;

  /**
   * Attest against the provided draft policy. Note that the resulting token cannot
   * be validated.
   */
  draftPolicyForAttestation?: string;

  /**
   * Nonce for incoming request - emitted in the generated attestation token
   */
  nonce?: string;
}

/**
 * Attestation request for Azure Guest Gen2 VMs
 */
model AttestAzureGuestRequest {
  /**
   * Attestation client information containing all artifacts required for Guest
   * Attestation.
   */
  attestationInfo?: string;
}

/**
 * The sealed result of an attestation operation
 */
model SealedAttestationResponse {
  /**
   * A sealed RFC 7519 JSON Web Token, the body of which is an AttestationResult
   * object.
   */
  token?: string;
}

/**
 * Attestation request for Trusted Platform Module (TPM) attestation.
 */
model TpmAttestationRequest {
  /**
   * Protocol data containing artifacts for attestation.
   */
  @encode(BytesKnownEncoding.base64url)
  data?: bytes;
}

/**
 * Attestation response for Trusted Platform Module (TPM) attestation.
 */
model TpmAttestationResponse {
  /**
   * Protocol data containing attestation service response.
   */
  @encode(BytesKnownEncoding.base64url)
  data?: bytes;
}

/**
 * Attestation request for AMD SEV SNP Virtual Machine
 */
model AttestSevSnpVmRequest {
  /**
   * Hardware rooted report of the virtual machine being attested along with the
   * signing certificate chain and optionally, additional endorsements
   */
  report?: string;

  /**
   * Runtime data provided by the enclave at the time of report generation. The MAA
   * will verify that the run time data is known to the attestation target.
   */
  runtimeData?: RuntimeData;

  /**
   * Initialization data provided by the enclave at the time of report generation.
   * The MAA will verify that the init time data is known to the attestation target.
   */
  initTimeData?: InitTimeData;

  /**
   * Attest against the provided draft policy. Note that the resulting token cannot
   * be validated.
   */
  draftPolicyForAttestation?: string;

  /**
   * Nonce for incoming request - emitted in the generated attestation token
   */
  nonce?: string;
}

/**
 * Attestation request for Intel TDX Virtual Machine
 */
model AttestTdxVmRequest {
  /**
   * Quote of the TDX virtual machine to be attested
   */
  @encode(BytesKnownEncoding.base64url)
  quote?: bytes;

  /**
   * Runtime data provided by the enclave at the time of quote generation. The MAA
   * will verify that the first 32 bytes of the report_data field of the quote
   * contains the SHA256 hash of the decoded "data" field of the runtime data.
   */
  runtimeData?: RuntimeData;

  /**
   * Initialization data provided when the enclave is created. MAA will verify that
   * the init data was known to the enclave.
   */
  initTimeData?: InitTimeData;

  /**
   * Nonce for incoming request - emitted in the generated attestation token
   */
  nonce?: string;
}

/**
 * A list of all Azure supported baseline details for the a TEE type along with an
 * indication of which one is in enforced for the attestation provider
 */
model TcbBaselineResult {
  /**
   * A list of all Azure supported baseline details for the a TEE type along with an
   * indication of which one is in enforced for the attestation provider
   */
  tcbBaselines?: TcbBaseline[];
}

/**
 * TEE specific Tcb baseline used in attestation, and baseline details including
 * baseline identifier, release date and minimum required software version
 */
model TcbBaseline {
  /**
   * The Tcb baseline Identifier used in attestation policy
   */
  tcbIdentifier?: string;

  /**
   * A monotonically increasing sequence number changed when Intel updates the
   * content of the TCB evaluation data set. SGX TEE specific property
   */
  tcbEvaluationDataNumber?: int32;

  /**
   * Date and time when the Tcb is released. SGX TEE specific property
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  tcbReleaseDate?: utcDateTime;

  /**
   * Minimum Linux PSW version required to support the corresponding Tcb baseline.
   * SGX TEE specific property
   */
  minimumPswLinuxVersion?: string;

  /**
   * Minimum Windows PSW version required to support the corresponding Tcb baseline.
   * SGX TEE specific property
   */
  minimumPswWindowsVersion?: string;

  /**
   * The corresponding Tcb baseline is set in attestation policy and is used in
   * attestation request if set to true
   */
  isSelectedTcb?: boolean;
}

/**
 * JsonWebKeySet
 */
model JsonWebKeySet {
  /**
   * The value of the "keys" parameter is an array of JWK values.  By
   * default, the order of the JWK values within the array does not imply
   * an order of preference among them, although applications of JWK Sets
   * can choose to assign a meaning to the order for their purposes, if
   * desired.
   */
  keys?: JsonWebKey[];
}

/**
 * JsonWebKey
 */
model JsonWebKey {
  /**
   * The "alg" (algorithm) parameter identifies the algorithm intended for
   * use with the key.  The values used should either be registered in the
   * IANA "JSON Web Signature and Encryption Algorithms" registry
   * established by [JWA] or be a value that contains a Collision-
   * Resistant Name.
   */
  alg?: string;

  /**
   * The "crv" (curve) parameter identifies the curve type
   */
  crv?: string;

  /**
   * RSA private exponent or ECC private key
   */
  d?: string;

  /**
   * RSA Private Key Parameter
   */
  dp?: string;

  /**
   * RSA Private Key Parameter
   */
  dq?: string;

  /**
   * RSA public exponent, in Base64
   */
  e?: string;

  /**
   * Symmetric key
   */
  k?: string;

  /**
   * The "kid" (key ID) parameter is used to match a specific key.  This
   * is used, for instance, to choose among a set of keys within a JWK Set
   * during key rollover.  The structure of the "kid" value is
   * unspecified.  When "kid" values are used within a JWK Set, different
   * keys within the JWK Set SHOULD use distinct "kid" values.  (One
   * example in which different keys might use the same "kid" value is if
   * they have different "kty" (key type) values but are considered to be
   * equivalent alternatives by the application using them.)  The "kid"
   * value is a case-sensitive string.
   */
  kid?: string;

  /**
   * The "kty" (key type) parameter identifies the cryptographic algorithm
   * family used with the key, such as "RSA" or "EC". "kty" values should
   * either be registered in the IANA "JSON Web Key Types" registry
   * established by [JWA] or be a value that contains a Collision-
   * Resistant Name.  The "kty" value is a case-sensitive string.
   */
  kty: string;

  /**
   * RSA modulus, in Base64
   */
  n?: string;

  /**
   * RSA secret prime
   */
  p?: string;

  /**
   * RSA secret prime, with p < q
   */
  q?: string;

  /**
   * RSA Private Key Parameter
   */
  qi?: string;

  /**
   * Use ("public key use") identifies the intended use of
   * the public key. The "use" parameter is employed to indicate whether
   * a public key is used for encrypting data or verifying the signature
   * on data. Values are commonly "sig" (signature) or "enc" (encryption).
   */
  use?: string;

  /**
   * X coordinate for the Elliptic Curve point
   */
  x?: string;

  /**
   * The "x5c" (X.509 certificate chain) parameter contains a chain of one
   * or more PKIX certificates [RFC5280].  The certificate chain is
   * represented as a JSON array of certificate value strings.  Each
   * string in the array is a base64-encoded (Section 4 of [RFC4648] --
   * not base64url-encoded) DER [ITU.X690.1994] PKIX certificate value.
   * The PKIX certificate containing the key value MUST be the first
   * certificate.
   */
  x5c?: string[];

  /**
   * Y coordinate for the Elliptic Curve point
   */
  y?: string;
}

/**
 * The response to the OpenID metadata description document API
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "backwards compatibility"
model OpenIDConfigurationResponse {
  /**
   * Types supported in the OpenID metadata API
   */
  @encodedName("application/json", "response_types_supported")
  responseTypesSupported?: string[];

  /**
   * List of the supported signing algorithms
   */
  @encodedName("application/json", "id_token_signing_alg_values_supported")
  idTokenSigningAlgValuesSupported?: string[];

  /**
   * Revocation endpoint
   */
  @encodedName("application/json", "revocation_endpoint")
  revocationEndpoint?: string;

  /**
   * Issuer tenant base endpoint
   */
  issuer?: string;

  /**
   * The URI to retrieve the signing keys
   */
  @encodedName("application/json", "jwks_uri")
  jwksUri?: string;

  /**
   * Set of claims supported by the OpenID metadata endpoint
   */
  @encodedName("application/json", "claims_supported")
  claimsSupported?: string[];
}

/**
 * The body of the JWT used for the PolicyCertificates APIs
 */
model AttestationCertificateManagementBody {
  /**
   * RFC 7517 Json Web Key describing the certificate.
   */
  policyCertificate?: JsonWebKey;
}

/**
 * The result of a call to retrieve policy certificates.
 */
model PolicyCertificatesResult {
  /**
   * SHA256 Hash of the binary representation certificate which was added or removed
   */
  @encodedName("application/json", "x-ms-policy-certificates")
  policyCertificates?: JsonWebKeySet;
}

/**
 * The result of a policy certificate modification
 */
model PolicyCertificatesModificationResult {
  /**
   * Hex encoded SHA1 Hash of the binary representation certificate which was added
   * or removed
   */
  @encodedName("application/json", "x-ms-certificate-thumbprint")
  certificateThumbprint?: string;

  /**
   * The result of the operation
   */
  @encodedName("application/json", "x-ms-policycertificates-result")
  certificateResolution?: CertificateModification;
}

/**
 * StoredAttestationPolicy
 */
model StoredAttestationPolicy {
  /**
   * Policy text to set as a sequence of UTF-8 encoded octets.
   */
  @encodedName("application/json", "AttestationPolicy")
  @encode(BytesKnownEncoding.base64url)
  attestationPolicy?: bytes;
}

/**
 * The result of a policy certificate modification
 */
model PolicyResult {
  /**
   * The result of the operation
   */
  @encodedName("application/json", "x-ms-policy-result")
  policyResolution?: PolicyModification;

  /**
   * The SHA256 hash of the policy object modified
   */
  @encodedName("application/json", "x-ms-policy-token-hash")
  @encode(BytesKnownEncoding.base64url)
  policyTokenHash?: bytes;

  /**
   * The certificate used to sign the policy object, if specified
   */
  @encodedName("application/json", "x-ms-policy-signer")
  policySigner?: JsonWebKey;

  /**
   * A JSON Web Token containing a StoredAttestationPolicy object with the
   * attestation policy
   */
  @encodedName("application/json", "x-ms-policy")
  @pattern("[A-Za-z0-9_-]+\\.[A-Za-z0-9_-]*\\.[A-Za-z0-9_-]*")
  policy?: string;
}

/**
 * A Microsoft Azure Attestation response token body - the body of a response
 * token issued by MAA
 */
model AttestationResult {
  /**
   * Unique Identifier for the token
   */
  jti?: string;

  /**
   * The Principal who issued the token
   */
  iss?: string;

  /**
   * The time at which the token was issued, in the number of seconds since
   * 1970-01-0T00:00:00Z UTC
   */
  iat?: float32;

  /**
   * The expiration time after which the token is no longer valid, in the number of
   * seconds since 1970-01-0T00:00:00Z UTC
   */
  exp?: float32;

  /**
   * The not before time before which the token cannot be considered valid, in the
   * number of seconds since 1970-01-0T00:00:00Z UTC
   */
  nbf?: float32;

  /**
   * An RFC 7800 Proof of Possession Key
   */
  cnf?: Record<string>;

  /**
   * The Nonce input to the attestation request, if provided.
   */
  nonce?: string;

  /**
   * The Schema version of this structure. Current Value: 1.0
   */
  @encodedName("application/json", "x-ms-ver")
  version?: string;

  /**
   * Runtime Claims
   */
  @encodedName("application/json", "x-ms-runtime")
  runtimeClaims?: Record<string>;

  /**
   * Inittime Claims
   */
  @encodedName("application/json", "x-ms-inittime")
  inittimeClaims?: Record<string>;

  /**
   * Policy Generated Claims
   */
  @encodedName("application/json", "x-ms-policy")
  policyClaims?: Record<string>;

  /**
   * The Attestation type being attested.
   */
  @encodedName("application/json", "x-ms-attestation-type")
  verifierType?: string;

  /**
   * The certificate used to sign the policy object, if specified.
   */
  @encodedName("application/json", "x-ms-policy-signer")
  policySigner?: JsonWebKey;

  /**
   * The SHA256 hash of the BASE64URL encoded policy text used for attestation
   */
  @encodedName("application/json", "x-ms-policy-hash")
  @encode(BytesKnownEncoding.base64url)
  policyHash?: bytes;

  /**
   * True if the enclave is debuggable, false otherwise
   */
  @encodedName("application/json", "x-ms-sgx-is-debuggable")
  isDebuggable?: boolean;

  /**
   * The SGX Product ID for the enclave.
   */
  @encodedName("application/json", "x-ms-sgx-product-id")
  productId?: float32;

  /**
   * The HEX encoded SGX MRENCLAVE value for the enclave.
   */
  @encodedName("application/json", "x-ms-sgx-mrenclave")
  mrEnclave?: string;

  /**
   * The HEX encoded SGX MRSIGNER value for the enclave.
   */
  @encodedName("application/json", "x-ms-sgx-mrsigner")
  mrSigner?: string;

  /**
   * The SGX SVN value for the enclave.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Renamed in client.tsp for SDK casing"
  `x-ms-sgx-svn`?: float32;

  /**
   * A copy of the RuntimeData specified as an input to the attest call.
   */
  @encodedName("application/json", "x-ms-sgx-ehd")
  @encode(BytesKnownEncoding.base64url)
  enclaveHeldData?: bytes;

  /**
   * The SGX SVN value for the enclave.
   */
  @encodedName("application/json", "x-ms-sgx-collateral")
  sgxCollateral?: Record<string>;

  /**
   * DEPRECATED: Private Preview version of x-ms-ver claim.
   */
  @encodedName("application/json", "ver")
  deprecatedVersion?: string;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-is-debuggable claim.
   */
  @encodedName("application/json", "is-debuggable")
  deprecatedIsDebuggable?: boolean;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-collateral claim.
   */
  @encodedName("application/json", "maa-attestationcollateral")
  deprecatedSgxCollateral?: Record<string>;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-ehd claim.
   */
  @encodedName("application/json", "aas-ehd")
  @encode(BytesKnownEncoding.base64url)
  deprecatedEnclaveHeldData?: bytes;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-ehd claim.
   */
  @encodedName("application/json", "maa-ehd")
  @encode(BytesKnownEncoding.base64url)
  deprecatedEnclaveHeldData2?: bytes;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-product-id
   */
  @encodedName("application/json", "product-id")
  deprecatedProductId?: float32;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-mrenclave.
   */
  @encodedName("application/json", "sgx-mrenclave")
  deprecatedMrEnclave?: string;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-mrsigner.
   */
  @encodedName("application/json", "sgx-mrsigner")
  deprecatedMrSigner?: string;

  /**
   * DEPRECATED: Private Preview version of x-ms-sgx-svn.
   */
  svn?: float32;

  /**
   * DEPRECATED: Private Preview version of x-ms-tee.
   */
  @encodedName("application/json", "tee")
  deprecatedTee?: string;

  /**
   * DEPRECATED: Private Preview version of x-ms-policy-signer
   */
  @encodedName("application/json", "policy_signer")
  deprecatedPolicySigner?: JsonWebKey;

  /**
   * DEPRECATED: Private Preview version of x-ms-policy-hash
   */
  @encodedName("application/json", "policy_hash")
  deprecatedPolicyHash?: bytes;

  /**
   * DEPRECATED: Private Preview version of nonce
   */
  @encodedName("application/json", "rp_data")
  deprecatedRpData?: string;
}
