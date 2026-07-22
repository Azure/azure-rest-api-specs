import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-core/experimental";

import "./models.tsp";
import "./client.tsp";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/auth-required" "No routes defined, so no auth to define."
@service(#{ title: "VoiceLive" })
@versioned(Versions)
namespace VoiceLive;

/** API versioning. */
enum Versions {
  /**
   * Public preview version of the VoiceLive API. This is the base (default) version and
   * contains the full preview surface, including preview-only features that are fenced out
   * of the stable `v1` contract with `@removed(Versions.v1)`. Clients never send this as an
   * `api-version`; preview behavior is opted into on `v1` via the `VoiceLive-Features` header.
   */
  PuPr: "virtual-public-preview",

  /** VoiceLive API version v1. The evergreen, backward-compatible GA contract. */
  v1: "v1",
}
