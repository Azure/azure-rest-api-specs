import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using Azure.Core;
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

  /** Version 2026-01-01-preview. */
  @previewVersion
  v2026_01_01_preview: "2026-01-01-preview",

  /** Version 2026-04-10. */
  v2026_04_10: "2026-04-10",
}
