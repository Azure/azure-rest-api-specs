import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "./client.tsp";

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/auth-required" "No routes defined, so no auth to define."
@service(#{ title: "VoiceLive" })
@versioned(Versions)
namespace VoiceLive;

/** API versioning. */
enum Versions {
  /**
   * An interim virtual API version representing backwards compatibility changes moving
   * from public preview to general availability.
   */
  PuPr: "virtual-public-preview",

  /** VoiceLive API version v1. */
  v1: "v1",
}
