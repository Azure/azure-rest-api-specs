import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@service({
  title: "Microsoft Code Transparency Service",
})
@useAuth(BearerAuth)
@server(
  "{endpoint}",
  "Code Transparency Service",
  {
    endpoint: url,
  }
)
@versioned(Microsoft.CodeTransparency.Versions)
namespace Microsoft.CodeTransparency;

@doc("The Microsoft.CodeTransparency service versions.")
enum Versions {
  #deprecated "Use next version"
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2024-01-11-preview version of the Microsoft.CodeTransparency service.")
  `2024-01-11-preview`,

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-01-31-preview version of the Microsoft.CodeTransparency service.")
  `2025-01-31-preview`,
}

// Additional supported traits by the API.
alias ServiceTraits = SupportsClientRequestId;

// -----------------------------------------------------------------
// Service configuration endpoints
// -----------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the transparency configuration file, see IETF SCITT draft")
@sharedRoute
@route("/.well-known/transparency-configuration")
@get
op getTransparencyConfigCbor is Foundations.Operation<
  AcceptCborHeader,
  TransparencyConfigurationCbor,
  ServiceTraits,
  CborServerErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the transparency configuration file, see IETF SCITT draft")
@sharedRoute
@route("/.well-known/transparency-configuration")
@get
op getTransparencyConfigJson is Foundations.Operation<
  AcceptJsonHeader,
  TransparencyConfigurationJson,
  ServiceTraits,
  JsonServerErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the public keys used by the service to sign receipts")
@route("/jwks")
@get
op getPublicKeys is Foundations.Operation<
  {},
  JwksDocument,
  ServiceTraits,
  JsonServerErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get service parameters (deprecated)")
@route("/parameters")
@get
op getParameters is Foundations.Operation<{}, ParametersResult, ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get the DID configuration file (deprecated)")
@route("/.well-known/did.json")
@get
op getDidConfig is Foundations.Operation<{}, DidDocument, ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get CodeTransparency configuration information.")
@route("/configuration")
@get
op getCodeTransparencyConfig is Foundations.Operation<
  {},
  CodeTransparencyConfiguration,
  ServiceTraits,
  JsonServerErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get CodeTransparency version information.")
@route("/version")
@get
op getCodeTransparencyVersion is Foundations.Operation<
  {},
  VersionResult,
  ServiceTraits,
  JsonServerErrors
>;

// -----------------------------------------------------------------
// Service entry endpoints
// -----------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Post an entry to be registered on the CodeTransparency instance (deprecated)")
@post
@sharedRoute
@route("/entries")
op createEntryDeprecated is Foundations.Operation<
  SignedStatement,
  CreateEntryResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Post an entry to be registered on the CodeTransparency instance, see IETF SCITT draft")
@post
@sharedRoute
@route("/entries")
op createEntry is Foundations.Operation<
  SignedStatement,
  CreateEntryCreated | CreateEntryPending,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get the status the entry operation (deprecated)")
@route("/operations/{operationId}")
op getEntryStatus is Foundations.Operation<
  OperationIdParameter,
  GetOperationResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get the status of all entries operations (deprecated)")
@route("/operations")
op listEntryStatuses is Foundations.Operation<
  {},
  ListOperationResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get signed statement with or without receipt embedded in its unprotected header")
@sharedRoute
@route("/entries/{entryId}")
op getEntryDeprecated is Foundations.Operation<
  EntryIdParameter & EmbedReceiptParameter,
  SignedStatement | TransparentStatement,
  ServiceTraits
>;

// uses explicit accept header to not generate such parameter in .net sdk
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get signed statement with or without receipt embedded in its unprotected header")
@sharedRoute
@route("/entries/{entryId}")
op getEntry is Foundations.Operation<
  EntryIdParameter & EmbedReceiptParameter & AcceptCoseHeader,
  SignedStatement | TransparentStatement,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get the receipt of an entry given a specific entry id.")
@sharedRoute
@route("/entries/{entryId}/receipt")
op getEntryReceiptDeprecated is Foundations.Operation<
  EntryIdParameter,
  ReceiptEntry,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the receipt of an entry given a specific entry id.")
@sharedRoute
@route("/entries/{entryId}/receipt")
op getEntryReceipt is Foundations.Operation<
  EntryIdParameter,
  ReceiptEntry,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the receipt of an entry given a specific entry id.")
@route("/entries/{entryId}/statement")
op getEntryStatement is Foundations.Operation<
  EntryIdParameter,
  TransparentStatement,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Historical query to get a list of entries of a given range")
@route("/entries/txIds")
op listEntryIds is Foundations.Operation<
  TransactionsRange,
  EntryIds,
  ServiceTraits,
  JsonServerErrors
>;

// -----------------------------------------------------------------
// Service models
// -----------------------------------------------------------------

@removed(Versions.`2025-01-31-preview`)
@doc("The Response body of the service parameters")
model ParametersResult {
  @doc("Service certificate used in TLS and for receipt verification")
  serviceCertificate: string;

  @doc("Service identifier")
  serviceId: string;

  @doc("Signature algorithm used in receipts")
  signatureAlgorithm: string;

  @doc("Tree algorithm used in receipts")
  treeAlgorithm: string;
}

@removed(Versions.`2025-01-31-preview`)
@doc("Response of entry submission containing the operationId.")
model CreateEntryResult {
  @doc("String representing the operation id submitted")
  @pattern("^[0-9]+\\.[0-9]+$")
  operationId: string;
}

@added(Versions.`2025-01-31-preview`)
@doc("Response of entry submission if the response can be served immediately, see IETF SCITT draft")
model CreateEntryCreated {
  @doc("Status code")
  @statusCode
  statusCode: 201;

  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature.")
  @header("Content-Type")
  contentType: "application/cose";

  @doc("Location of the transparent statement")
  @header("Location")
  location: string;

  @doc("Transparent statement")
  @bodyRoot
  body: bytes;
}

@added(Versions.`2025-01-31-preview`)
@doc("Response of entry submission containing the transparent statement id, see IETF SCITT draft")
model CreateEntryPending {
  @doc("Status code")
  @statusCode
  statusCode: 202;

  @doc("Response content is CBOR")
  @header("Content-Type")
  contentType: "application/cbor";

  @doc("Location of the transparent statement")
  @header("Location")
  location: string;

  @doc("Response contains the identifier")
  @bodyRoot
  body: bytes;
}

@doc("Signed statement")
model SignedStatement {
  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature, see IETF SCITT draft")
  @header("Content-Type")
  contentType: "application/cose";

  @doc("CoseSign1 signature envelope")
  @bodyRoot
  body: bytes;
}

@doc("Transparent statement")
model TransparentStatement {
  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature, see IETF SCITT draft")
  @header("Content-Type")
  contentType: "application/cose";

  @doc("CoseSign1 signature envelope with the receipt embedded in the unprotected header")
  @bodyRoot
  body: bytes;
}

@doc("A ledger receipt, see IETF SCITT draft")
model ReceiptEntry {
  @doc("The MIME content type for receipt is application/cbor.")
  @removed(Versions.`2025-01-31-preview`)
  @header("Content-Type")
  contentTypeCbor: "application/cbor";

  @doc("The MIME content type for receipt is application/cose.")
  @added(Versions.`2025-01-31-preview`)
  @header("Content-Type")
  contentTypeCose: "application/cose";

  @doc("A raw CBOR content")
  @bodyRoot
  body: bytes;
}

@doc("A List of Entry IDs")
@pagedResult
model EntryIds {
  @doc("List of entry ids")
  @items
  transactionIds: string[];

  @doc("Path to the next page of results")
  @TypeSpec.nextLink
  nextLink?: string;
}

@doc("The EntryId parameter.")
model EntryIdParameter {
  @doc("ID of the entry to retrieve.")
  @path
  @maxLength(100)
  @pattern("^[0-9]+\\.[0-9]+$")
  entryId: string;
}

@doc("Accept application/cose header")
model AcceptCoseHeader {
  @doc("Accept header")
  @header
  accept: "application/cose";
}

@doc("Accept application/cbor header")
model AcceptCborHeader {
  @doc("Accept header")
  @header
  accept: "application/cbor";
}

@doc("Accept application/json header")
model AcceptJsonHeader {
  @doc("Accept header")
  @header
  accept: "application/json";
}

@doc("The EmbedReceipt parameter.")
model EmbedReceiptParameter {
  @doc("Embed a receipt as part of the response")
  @query
  embedReceipt?: boolean = false;
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

@removed(Versions.`2025-01-31-preview`)
@doc("The OperationId parameter.")
model OperationIdParameter {
  @doc("ID of the operation to retrieve.")
  @pattern("^[0-9]+\\.[0-9]+$")
  @path
  operationId: string;
}

@removed(Versions.`2025-01-31-preview`)
@doc("The Response body of the ListOperations API")
model ListOperationResult {
  @doc("List of operations")
  operations: GetOperationResult[];
}

@removed(Versions.`2025-01-31-preview`)
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

@removed(Versions.`2025-01-31-preview`)
@doc("Possible statuses of the operation.")
@lroStatus
union OperationStatus {
  string,
  @doc("Operation is still running.") "running",
  @lroFailed @doc("Operation failed.") "failed",
  @lroSucceeded @doc("Operation succeeded.") "succeeded",
}

@added(Versions.`2025-01-31-preview`)
@doc("Transparency configuration, see IETF SCITT draft.")
model TransparencyConfigurationCbor {
  @doc("Default content type is application/cbor.")
  @header
  contentType: "application/cbor";

  @doc("CBOR content of the configuration object")
  @body
  body: bytes;
}

@added(Versions.`2025-01-31-preview`)
@doc("Transparency configuration, see IETF SCITT draft.")
model TransparencyConfigurationJson {
  @doc("Content type header")
  @header
  contentType: "application/json";

  @doc("Configured issuer string")
  @example("https://transparency.example")
  issuer: string;

  @doc("Location of the JWKS document")
  @example("https://transparency.example/jwks")
  jwksUri: string;
}

@removed(Versions.`2025-01-31-preview`)
@doc("A DID issuer")
model DidIssuer {
  @doc("String representing a DID issuer.")
  @path
  issuer: string;
}

@removed(Versions.`2025-01-31-preview`)
@doc("A DID document")
model DidDocument {
  @doc("String representing a DID issuer.")
  id: string;

  @doc("List of public keys used for receipt endorsement verification.")
  assertionMethod: DidDocumentKey[];
}

@removed(Versions.`2025-01-31-preview`)
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

@added(Versions.`2025-01-31-preview`)
@doc("A JWKS like document")
model JwksDocument {
  @doc("List of public keys used for receipt verification.")
  keys: JsonWebKey[];
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

@doc("The Response body of the Version API.")
model VersionResult {
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Version of the CodeTransparency service")
  scitt_version: string;

  @added(Versions.`2025-01-31-preview`)
  @doc("Version of the CodeTransparency service")
  version: string;
}

@doc("The Response body of the Configuration API.")
model CodeTransparencyConfiguration {
  @doc("Policy configuration")
  policy?: CodeTransparencyConfigurationPolicy;

  @doc("Authentication configuration")
  authentication?: CodeTransparencyConfigurationAuthentication;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Issuer used in receipts")
  service_identifier?: string;
}

@doc("Configuration of CCF authentication.")
model CodeTransparencyConfigurationAuthentication {
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Disable API authentication and rely on signed statement verification only")
  allow_unauthenticated: boolean;

  @added(Versions.`2025-01-31-preview`)
  @doc("Disable API authentication and rely on signed statement verification only")
  allowUnauthenticated: boolean;

  @doc("JWT requirements if authentication is enabled")
  jwt?: CodeTransparencyConfigurationAuthenticationJwt;
}

@doc("Configuration of JWT claims")
model CodeTransparencyConfigurationAuthenticationJwt {
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Claims that must be present in the JWT")
  required_claims: Record<string>;

  @added(Versions.`2025-01-31-preview`)
  @doc("Claims that must be present in the JWT")
  requiredClaims: Record<string>;
}

@doc("Policy configuration listing accepted algorithms and the the policy script")
model CodeTransparencyConfigurationPolicy {
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Accepted COSE signature algorithms when verifying signed statements")
  accepted_algorithms?: string[];

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.`2025-01-31-preview`)
  @doc("Accepted COSE signature did:web issuers when verifying signed statements")
  accepted_did_issuers?: string[];

  @added(Versions.`2025-01-31-preview`)
  @doc("Accepted COSE signature algorithms when verifying signed statements")
  acceptedAlgorithms?: string[];

  @added(Versions.`2025-01-31-preview`)
  @doc("COSE signature verification script in Javascript")
  policyScript: string;
}

// -----------------------------------------------------------------
// Error responses as per IETF draft
// -----------------------------------------------------------------

alias ConciseProblemDetailsCbor = bytes;

@added(Versions.`2025-01-31-preview`)
@doc("Not found error response")
model NotFoundErrorCborResponse {
  @doc("Status code")
  @statusCode
  statusCode: 404;

  @doc("The MIME content type for error is application/concise-problem-details+cbor, see RFC9290")
  @header
  contentType: "application/concise-problem-details+cbor";

  @doc("CBOR content of the error object")
  @body
  error: ConciseProblemDetailsCbor;
}

@added(Versions.`2025-01-31-preview`)
@doc("Validation error response")
model ValidationErrorCborResponse {
  @doc("Status code")
  @statusCode
  statusCode: 400;

  @doc("The MIME content type for error is application/concise-problem-details+cbor, see RFC9290")
  @header
  contentType: "application/concise-problem-details+cbor";

  @doc("CBOR content of the error object")
  @body
  error: ConciseProblemDetailsCbor;
}

@added(Versions.`2025-01-31-preview`)
@doc("Server error response")
model ServerErrorCborResponse {
  @doc("Status code")
  @statusCode
  statusCode: 500;

  @doc("The MIME content type for error is application/concise-problem-details+cbor, see RFC9290")
  @header
  contentType: "application/concise-problem-details+cbor";

  @doc("CBOR content of the error object")
  @body
  error: ConciseProblemDetailsCbor;
}

@added(Versions.`2025-01-31-preview`)
@doc("Service unavailable error response")
model ServiceUnavailableErrorCborResponse {
  @doc("Retry the same request after a suggested number of seconds")
  @header("Retry-After")
  retryAfter?: string;

  @doc("Status code")
  @statusCode
  statusCode: 503;

  @doc("The MIME content type for error, see RFC9290")
  @header
  contentType: "application/concise-problem-details+cbor";

  @doc("CBOR content of the error object")
  @body
  error: ConciseProblemDetailsCbor;
}

alias AnyCborError =
  | NotFoundErrorCborResponse
  | ValidationErrorCborResponse
  | ServerErrorCborResponse
  | ServiceUnavailableErrorCborResponse;
alias CborServerErrors = ServerErrorCborResponse | ServiceUnavailableErrorCborResponse;

@doc("Not found error response")
model NotFoundErrorJsonResponse {
  @doc("Status code")
  @statusCode
  statusCode: 404;

  @doc("Content type header application/json")
  @header
  contentType: "application/json";

  @doc("Error response")
  @bodyRoot
  error: ErrorResponse;
}

@doc("Validation error response")
model ValidationErrorJsonResponse {
  @doc("Status code")
  @statusCode
  statusCode: 400;

  @doc("Content type header application/json")
  @header
  contentType: "application/json";

  @doc("Error response")
  @bodyRoot
  error: ErrorResponse;
}

@doc("Server error response")
model ServerErrorJsonResponse {
  @doc("Status code")
  @statusCode
  statusCode: 500;

  @doc("Content type header application/json")
  @header
  contentType: "application/json";

  @doc("Error response")
  @bodyRoot
  error: ErrorResponse;
}

@doc("Service temporarily unavailable")
@error
model ServiceUnavailableError {
  @doc("Retry the same request after a suggested number of seconds")
  @header("Retry-After")
  retryAfter?: string;

  @doc("Status code is always 503 when service is unavailable")
  @statusCode
  statusCode: 503;

  @doc("Content type header application/json")
  @header
  contentType: "application/json";

  @doc("Error response")
  @bodyRoot
  error: ErrorResponse;
}

alias AnyJsonError =
  | NotFoundErrorJsonResponse
  | ValidationErrorJsonResponse
  | ServerErrorJsonResponse
  | ServiceUnavailableError;
alias JsonServerErrors = ServerErrorJsonResponse | ServiceUnavailableError;
