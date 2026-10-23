import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/** Optional conditions for creating or updating a workspace, scenario, or scenario configuration. */
model PutPreconditionHeaders {
  /**
   * Use '*' to create the resource only if it does not exist. If the resource exists, the request fails with 412 Precondition Failed without changing it. Omit both condition headers for an unconditional create or update. Other effective conditions must be honored if supported or rejected with 412 if they cannot be verified; they must not be silently ignored. This contract does not introduce entity-tag matching.
   */
  @added(Versions.v2026_11_01)
  @header("If-None-Match")
  ifNoneMatch?: string;

  /**
   * Use '*' to update the resource only if it exists. If the resource does not exist, the request fails with 412 Precondition Failed without creating it. Omit both condition headers for an unconditional create or update. Other effective conditions must be honored if supported or rejected with 412 if they cannot be verified; they must not be silently ignored. This contract does not introduce entity-tag matching.
   */
  @added(Versions.v2026_11_01)
  @header("If-Match")
  ifMatch?: string;
}

/** An unexpected error response. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "HTTP error envelopes select status codes, not a client model inheritance hierarchy; both responses use the existing common Azure error body."
union PutPreconditionError {
  ErrorResponse,

  /** An effective request precondition failed or could not be verified. No resource change or asynchronous operation is started. */
  @added(Versions.v2026_11_01)
  preconditionFailed: PreconditionFailedResult,
}

/** An effective request precondition failed or could not be verified. No resource change or asynchronous operation is started. */
@added(Versions.v2026_11_01)
@error
model PreconditionFailedResult {
  /** The HTTP status code. */
  @statusCode
  statusCode: 412;

  /** The Azure error describing the failed precondition. */
  @body
  body: Azure.ResourceManager.CommonTypes.ErrorResponse;
}
