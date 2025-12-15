import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Attestation;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Status of attestation service.
 */
union AttestationServiceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotReady: "NotReady",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * The public network access type for API calls to the Attestation Provider.
 */
union PublicNetworkAccessType {
  string,

  /**
   * Enables public network connectivity to the Attestation Provider REST APIs.
   */
  Enabled: "Enabled",

  /**
   * Disables public network connectivity to the Attestation Provider REST APIs.
   */
  Disabled: "Disabled",
}

/**
 * The type for specifying the requirement of authentication for TPM Attestation REST APIs.
 */
union TpmAttestationAuthenticationType {
  string,

  /**
   * Enables the requirement of authentication for TPM Attestation REST APIs.
   */
  Enabled: "Enabled",

  /**
   * Disables the requirement of authentication for TPM Attestation REST APIs.
   */
  Disabled: "Disabled",
}

/**
 * Definition object with the name and properties of an operation.
 */
model OperationsDefinition {
  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Display object with properties of the operation.
   */
  display?: OperationsDisplayDefinition;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Display object with properties of the operation.
 */
model OperationsDisplayDefinition {
  /**
   * Resource provider of the operation.
   */
  provider?: string;

  /**
   * Resource for the operation.
   */
  resource?: string;

  /**
   * Short description of the operation.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Microsoft Azure Attestation
   */
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Specifications of the Log for Microsoft Azure Attestation
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;
}

/**
 * An error response from Attestation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * An error response from Attestation.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from Attestation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for displaying in a user interface.
   */
  message?: string;
}

/**
 * Status of attestation service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StatusResult {
  /**
   * Trust model for the attestation provider.
   */
  trustModel?: string;

  /**
   * Status of attestation service.
   */
  status?: AttestationServiceStatus;

  /**
   * Gets the uri of attestation service
   */
  attestUri?: string;

  /**
   * Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * List of private endpoint connections associated with the attestation provider.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The setting that controls whether authentication is enabled or disabled for TPM Attestation REST APIs.
   */
  tpmAttestationAuthentication?: TpmAttestationAuthenticationType = TpmAttestationAuthenticationType.Enabled;
}

/**
 * Parameters for creating an attestation provider
 */
model AttestationServiceCreationParams {
  /**
   * The supported Azure location where the attestation provider should be created.
   */
  location: string;

  /**
   * The tags that will be assigned to the attestation provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the attestation provider
   */
  properties: AttestationServiceCreationSpecificParams;
}

/**
 * Client supplied parameters used to create a new attestation provider.
 */
model AttestationServiceCreationSpecificParams {
  /**
   * Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * JSON Web Key Set defining a set of X.509 Certificates that will represent the parent certificate for the signing certificate used for policy operations
   */
  policySigningCertificates?: JsonWebKeySet;

  /**
   * The setting that controls whether authentication is enabled or disabled for TPM Attestation REST APIs.
   */
  tpmAttestationAuthentication?: TpmAttestationAuthenticationType = TpmAttestationAuthenticationType.Enabled;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JsonWebKeySet {
  /**
   * The value of the "keys" parameter is an array of JWK values.  By
   * default, the order of the JWK values within the array does not imply
   * an order of preference among them, although applications of JWK Sets
   * can choose to assign a meaning to the order for their purposes, if
   * desired.
   */
  @identifiers(#[])
  keys?: JsonWebKey[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Parameters for patching an attestation provider
 */
model AttestationServicePatchParams {
  /**
   * The tags that will be assigned to the attestation provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the attestation provider
   */
  properties?: AttestationServicePatchSpecificParams;
}

/**
 * Client supplied parameters used to patch an existing attestation provider.
 */
model AttestationServicePatchSpecificParams {
  /**
   * Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The setting that controls whether authentication is enabled or disabled for TPM Attestation REST APIs.
   */
  tpmAttestationAuthentication?: TpmAttestationAuthenticationType = TpmAttestationAuthenticationType.Enabled;
}

/**
 * Attestation Providers List.
 */
model AttestationProviderListResult {
  /**
   * The system metadata relating to this resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Attestation Provider array.
   */
  @pageItems
  value?: AttestationProvider[];
}

/**
 * List of supported operations.
 */
model OperationList {
  /**
   * The system metadata relating to this resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * List of supported operations.
   */
  @pageItems
  @identifiers(#["name"])
  value?: OperationsDefinition[];
}
