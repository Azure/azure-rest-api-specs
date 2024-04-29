using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.CodeTransparency;

@doc("Service temporarily unavailable")
@error
model ServiceUnavailableError {
  @doc("Retry the same request after a suggested number of seconds")
  @header("Retry-After")
  retryAfter?: string;

  @doc("Status code is always 503 when service is unavailable")
  @statusCode
  statusCode: 503;

  ...Foundations.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@doc("The Response body of the service parameters")
model ParametersResult {
  serviceCertificate: string;
  serviceId: string;
  signatureAlgorithm: string;
  treeAlgorithm: string;
}

@doc("Response of entry submission containing the operationId.")
model CreateEntryResult {
  @doc("String representing the operation id submitted")
  @pattern("^[0-9]+\\.[0-9]+$")
  operationId: string;
}

@doc("An Entry in Cose format")
model CoseEntry {
  // defaults to json in the post method
  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature.")
  @header
  contentType: "application/cose";

  @doc("A raw CoseSign1 signature")
  @body
  body: bytes;
}

@doc("A Raw Entry in cbor format")
model RawEntry {
  @doc("The MIME content type for raw receipt is application/cbor.")
  @header
  contentType: "application/cbor";

  @doc("A raw CBOR content")
  @body
  body: bytes;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A List of Entry IDs")
@pagedResult
model EntryIds {
  @doc("List of entry ids")
  @items
  transactionIds: string[];

  @doc("Path to the next page of results")
  @nextLink
  nextLink?: string;
}

@doc("The EntryId parameter.")
model EntryIdParameter {
  @doc("ID of the entry to retrieve.")
  @path
  @pattern("^[0-9]+\\.[0-9]+$")
  entryId: string;
}

@doc("The EmbedReceipt parameter.")
model EmbedReceiptParameter {
  @doc("Embed a receipt as part of the response")
  @query
  embedReceipt?: boolean = false;

  ...EntryIdParameter;
}

@doc("Range of transactions for historical queries")
model TransactionsRange {
  @doc("Starting Transaction Id")
  @query
  @minValue(0)
  from?: int64;

  @doc("Ending Transaction Id")
  @query
  @minValue(0)
  to?: int64;
}

@doc("The OperationId parameter.")
model OperationIdParameter {
  @doc("ID of the operation to retrieve.")
  @pattern("^[0-9]+\\.[0-9]+$")
  @path
  operationId: string;
}

@doc("The Response body of the ListOperations API")
model ListOperationResult {
  @doc("List of operations")
  operations: GetOperationResult[];
}

@doc("The Response body of the GetOperationId API.")
model GetOperationResult {
  @doc("ID of the transaction. Only if status is Succeeded.")
  @pattern("^[0-9]+\\.[0-9]+$")
  entryId?: string;

  @doc("Error in json format. Only if Status is Failed.")
  @lroErrorResult
  error?: string;

  @doc("OperationId")
  @pattern("^[0-9]+\\.[0-9]+$")
  operationId: string;

  @doc("Status of the operation.")
  status: OperationStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
@doc("Possible statuses of the operation.")
@lroStatus
union OperationStatus {
  string,
  @doc("Operation is still running.") "running",
  @lroFailed @doc("Operation failed.") "failed",
  @lroSucceeded @doc("Operation succeeded.") "succeeded",
}

@doc("A DID issuer")
model DidIssuer {
  @doc("String representing a DID issuer.")
  @path
  issuer: string;
}

@doc("A DID document")
model DidDocument {
  @doc("String representing a DID issuer.")
  id: string;

  @doc("List of public keys used for receipt endorsement verification.")
  assertionMethod: DidDocumentKey[];
}

@doc("A DID document key")
model DidDocumentKey {
  @doc("Key identifier.")
  id: string;

  @doc("Key controller - similar to DID issuer.")
  controller: string;

  @doc("Key type.")
  type: "JsonWebKey2020";

  @doc("Serialized public key in JWK format.")
  publicKeyJwk: JsonWebKey;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("rfc7517 JSON Web Key representation adapted from a shared swagger definition in the common types")
model JsonWebKey {
  @doc("The \"alg\" (algorithm) parameter identifies the algorithm intended for\nuse with the key.  The values used should either be registered in the\nIANA \"JSON Web Signature and Encryption Algorithms\" registry\nestablished by [JWA] or be a value that contains a Collision-\nResistant Name.")
  alg?: string;

  @doc("The \"crv\" (curve) parameter identifies the curve type")
  crv?: string;

  @doc("RSA private exponent or ECC private key")
  d?: string;

  @doc("RSA Private Key Parameter")
  dp?: string;

  @doc("RSA Private Key Parameter")
  dq?: string;

  @doc("RSA public exponent, in Base64")
  e?: string;

  @doc("Symmetric key")
  k?: string;

  @doc("The \"kid\" (key ID) parameter is used to match a specific key.  This\nis used, for instance, to choose among a set of keys within a JWK Set\nduring key rollover.  The structure of the \"kid\" value is\nunspecified.  When \"kid\" values are used within a JWK Set, different\nkeys within the JWK Set SHOULD use distinct \"kid\" values.  (One\nexample in which different keys might use the same \"kid\" value is if\nthey have different \"kty\" (key type) values but are considered to be\nequivalent alternatives by the application using them.)  The \"kid\"\nvalue is a case-sensitive string.")
  kid?: string;

  @doc("The \"kty\" (key type) parameter identifies the cryptographic algorithm\nfamily used with the key, such as \"RSA\" or \"EC\". \"kty\" values should\neither be registered in the IANA \"JSON Web Key Types\" registry\nestablished by [JWA] or be a value that contains a Collision-\nResistant Name.  The \"kty\" value is a case-sensitive string.")
  kty: string;

  @doc("RSA modulus, in Base64")
  n?: string;

  @doc("RSA secret prime")
  p?: string;

  @doc("RSA secret prime, with p < q")
  q?: string;

  @doc("RSA Private Key Parameter")
  qi?: string;

  @doc("Use (\"public key use\") identifies the intended use of\nthe public key. The \"use\" parameter is employed to indicate whether\na public key is used for encrypting data or verifying the signature\non data. Values are commonly \"sig\" (signature) or \"enc\" (encryption).")
  use?: string;

  @doc("X coordinate for the Elliptic Curve point")
  x?: string;

  @doc("The \"x5c\" (X.509 certificate chain) parameter contains a chain of one\nor more PKIX certificates [RFC5280].  The certificate chain is\nrepresented as a JSON array of certificate value strings.  Each\nstring in the array is a base64-encoded (Section 4 of [RFC4648] --\nnot base64url-encoded) DER [ITU.X690.1994] PKIX certificate value.\nThe PKIX certificate containing the key value MUST be the first\ncertificate.")
  x5c?: Array<string>;

  @doc("Y coordinate for the Elliptic Curve point")
  y?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("The Response body of the Version API.")
model VersionResult {
  @doc("Version of the CodeTransparency service")
  scitt_version: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("The Response body of the Configuration API.")
model CodeTransparencyConfiguration {
  policy?: CodeTransparencyConfigurationPolicy;
  authentication?: CodeTransparencyConfigurationAuthentication;

  @doc("did:web identifier")
  @pattern("^did:web:.+$")
  service_identifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Configuration of CCF authentication.")
model CodeTransparencyConfigurationAuthentication {
  allow_unauthenticated: boolean;
  jwt?: CodeTransparencyConfigurationAuthenticationJwt;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Configuration of JWT claims")
model CodeTransparencyConfigurationAuthenticationJwt {
  required_claims: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Configuration of CCF Authentication policies.")
model CodeTransparencyConfigurationPolicy {
  accepted_algorithms?: string[];
  accepted_did_issuers?: string[];
}
