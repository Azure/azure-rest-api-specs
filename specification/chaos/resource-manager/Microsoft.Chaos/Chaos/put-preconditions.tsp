import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/** Optional conditions for creating or updating a workspace, scenario, or scenario configuration. */
model PutPreconditionHeaders {
  /**
   * Use '*' to create the resource only if it does not exist. If the resource exists, the request fails with HTTP 412 and error code PreconditionFailed in the standard Azure error body. A failed condition starts no resource change or asynchronous operation. Omit both condition headers for an unconditional create or update. Other effective conditions must be honored if supported or rejected with 412 if they cannot be verified; they must not be silently ignored. This contract does not introduce entity-tag matching.
   */
  @added(Versions.v2026_11_01)
  @header("If-None-Match")
  ifNoneMatch?: string;

  /**
   * Use '*' to update the resource only if it exists. If the resource does not exist, the request fails with HTTP 412 and error code PreconditionFailed in the standard Azure error body. A failed condition starts no resource change or asynchronous operation. Omit both condition headers for an unconditional create or update. Other effective conditions must be honored if supported or rejected with 412 if they cannot be verified; they must not be silently ignored. This contract does not introduce entity-tag matching.
   */
  @added(Versions.v2026_11_01)
  @header("If-Match")
  ifMatch?: string;
}
