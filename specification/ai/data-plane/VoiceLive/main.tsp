import "@typespec/http";
import "@typespec/versioning";

import "./models.tsp";

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/auth-required" "No routes defined, so no auth to define."
@versioned(VoiceLive.Versions)
@service(#{ title: "VoiceLive" })
@versioned(Versions)
namespace VoiceLive;

/** API versioning. */
enum Versions {
  /** Version 2025-10-01. */
  v2025_10_01: "2025-10-01",
}
