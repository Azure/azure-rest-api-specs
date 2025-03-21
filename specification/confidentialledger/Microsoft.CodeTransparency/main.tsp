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
@service(#{ title: "Microsoft Code Transparency Service" })
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
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  // aligns with Feb 4 2025 SCRAPI spec https://github.com/ietf-wg-scitt/draft-ietf-scitt-scrapi/blob/4fafe531c21a3d1241934330bb771f82c64e0827/draft-ietf-scitt-scrapi.md
  @doc("The 2025-01-31-preview version of the Microsoft.CodeTransparency service.")
  `2025-01-31-preview`,
}

// Additional supported traits by the API.
alias ServiceTraits = SupportsClientRequestId;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the transparency service configuration, mandatory in IETF SCITT draft")
@route("/.well-known/transparency-configuration")
@get
op getTransparencyConfigCbor is Foundations.Operation<
  AcceptCborHeader,
  TransparencyConfigurationCbor,
  ServiceTraits,
  CborServerErrors
>;

#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "cannot assign error to directive to cbor binary responses"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the public keys used by the service to sign receipts, mentioned in IETF SCITT draft as part of jwks_uri implementation")
@route("/jwks")
op getPublicKeys is Foundations.Operation<
  {},
  JwksDocument,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Post an entry to be registered on the CodeTransparency instance, mandatory in IETF SCITT draft")
@post
@route("/entries")
op createEntry is Foundations.Operation<
  SignedStatement & AcceptCoseOrCborHeader,
  CreateEntryCreated | CreateEntryPending,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get status of the long running registration operation, mandatory in IETF SCITT draft")
@route("/operations/{operationId}")
op getOperation is Foundations.Operation<
  OperationIdParameter & AcceptCborHeader,
  OperationStatusComplete | OperationStatusPending,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get receipt")
@route("/entries/{entryId}")
op getEntry is Foundations.Operation<
  EntryIdParameter & AcceptCoseHeader,
  ReceiptEntry,
  ServiceTraits,
  AnyCborError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the transparent statement consisting of the signed statement and the receipt embedded in the header")
@route("/entries/{entryId}/statement")
op getEntryStatement is Foundations.Operation<
  EntryIdParameter & AcceptCoseHeader,
  TransparentStatement,
  ServiceTraits,
  AnyCborError
>;

@added(Versions.`2025-01-31-preview`)
@doc("Response of entry submission if the response can be served immediately, mandatory in IETF SCITT draft")
model CreateEntryCreated {
  @doc("Status code")
  @statusCode
  statusCode: 201;

  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature.")
  @header("Content-Type")
  contentType: "application/cose";

  @doc("Location of the receipt")
  @header("Location")
  location?: string;

  @doc("Receipt body in COSE format")
  @bodyRoot
  body: bytes;
}

@added(Versions.`2025-01-31-preview`)
@doc("Response of entry submission containing the operation id, mandatory in IETF SCITT draft")
model CreateEntryPending {
  @doc("Status code")
  @statusCode
  statusCode: 202;

  @doc("Response content is in CBOR format")
  @header("Content-Type")
  contentType: "application/cbor";

  @doc("Location of the operation")
  @header("Location")
  location?: string;

  @doc("Retry-After seconds value to help with polling")
  @header("Retry-After")
  retryAfter?: int32;

  // Example CBOR:
  // {
  //   / locator / "OperationID": "67f89d5f0042e3ad42...35a1f190",
  //   / status /  "Status": "running",
  // }
  // Status can be "running" or "succeeded"
  @doc("Operation status response")
  @bodyRoot
  body: bytes;
}

@doc("Provides status details for long running operation, mandatory in IETF SCITT draft")
model OperationStatusComplete {
  @doc("Response content is in CBOR format")
  @header("Content-Type")
  contentType: "application/cbor";

  @doc("Location of the entry")
  @header("Location")
  location?: string;

  // A success CBOR structure:
  // {
  //   / locator / "EntryID": "67f89d5f0042e3ad42...35a1f190",
  //   / status /  "Status": "succeeded",
  // }
  // Or an error CBOR structure:
  // {
  //   / status / "Status": "failed",
  //   / error /  "Error": {
  //     / title /         -1: \
  //             "Bad Signature Algorithm",
  //     / detail /        -2: \
  //             "Signed Statement contained a non supported algorithm"
  //   }
  // }
  @doc("Operation status response")
  @bodyRoot
  body: bytes;
}

@doc("Pending response if the operation was not complete, mandatory in IETF SCITT draft")
model OperationStatusPending {
  @doc("Status code")
  @statusCode
  statusCode: 202;

  @doc("Location of the operation")
  @header("Location")
  location?: string;

  @doc("Retry-After seconds value to help with polling")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Signed statement")
model SignedStatement {
  @doc("The MIME content type a Cose body is application/cose, containing a CoseSign1 signature, see IETF SCITT draft")
  @header("Content-Type")
  contentType: "application/cose";

  // Example CBOR:
  // 18([              / COSE Sign1         /
  //   h'a101382...',  / Protected Header   /
  //   {},             / Unprotected Header /
  //   h'8f4211d...',  / Payload            /
  //   h'269cd68...'   / Signature          /
  // ])
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
  @doc("The MIME content type for receipt is application/cose.")
  @added(Versions.`2025-01-31-preview`)
  @header("Content-Type")
  contentType: "application/cose";

  @doc("Location of the receipt")
  @header("Location")
  location?: string;

  // Example CBOR:
  // 18([              / COSE Sign1         /
  //   h'a101382...',  / Protected Header   /
  //   {},             / Unprotected Header /
  //   null,           / Payload            /
  //   h'269cd68...'   / Signature          /
  // ])
  @doc("A receipt structure in COSE format")
  @bodyRoot
  body: bytes;
}

@doc("The OperationId parameter.")
model OperationIdParameter {
  @doc("ID of the operation to retrieve.")
  @path
  @maxLength(100)
  operationId: string;
}

@doc("The EntryId parameter.")
model EntryIdParameter {
  @doc("ID of the entry to retrieve.")
  @path
  @maxLength(100)
  entryId: string;
}

@doc("Accept application/cose header")
model AcceptCoseOrCborHeader {
  @doc("Accept header")
  @header
  accept: "application/cose; application/cbor";
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

@added(Versions.`2025-01-31-preview`)
@doc("Transparency configuration, see IETF SCITT draft.")
model TransparencyConfigurationCbor {
  @doc("Default content type is application/cbor.")
  @header
  contentType: "application/cbor";

  // Example CBOR:
  // {
  //   "issuer": "https://transparency.example",
  //   "jwks_uri": "https://transparency.example/jwks"
  // }
  @doc("CBOR content of the configuration object")
  @body
  body: bytes;
}

@added(Versions.`2025-01-31-preview`)
@doc("A JWKS like document")
model JwksDocument {
  @doc("Content type header")
  @header
  contentType: "application/json";

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

// -----------------------------------------------------------------
// Error responses as per IETF draft
// -----------------------------------------------------------------

// Example CBOR:
// {
//   / title /         -1: \
//           "Operation Not Found",
//   / detail /        -2: \
//           "No running operation was found matching the requested ID"
// }
alias ConciseProblemDetailsCbor = bytes;

@added(Versions.`2025-01-31-preview`)
@doc("Validation error response")
model Response400Cbor {
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
@doc("Not found error response")
model Response404Cbor {
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
@doc("Not found error response")
model Response429Cbor {
  @doc("Status code")
  @statusCode
  statusCode: 429;

  @doc("The MIME content type for error is application/concise-problem-details+cbor, see RFC9290")
  @header
  contentType: "application/concise-problem-details+cbor";

  @doc("Retry-After seconds value to help with polling")
  @header("Retry-After")
  retryAfter?: int32;

  @doc("CBOR content of the error object")
  @body
  error: ConciseProblemDetailsCbor;
}

@added(Versions.`2025-01-31-preview`)
@doc("Server error response")
model Response500Cbor {
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
model Response503Cbor {
  @doc("Retry the same request after a suggested number of seconds")
  @header("Retry-After")
  retryAfter?: int32;

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
  | Response400Cbor
  | Response404Cbor
  | Response429Cbor
  | Response500Cbor
  | Response503Cbor;
alias CborServerErrors = Response500Cbor | Response503Cbor;
