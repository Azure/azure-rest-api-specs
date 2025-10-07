import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(VoiceLive.Versions)
@service(#{ title: "VoiceLive" })
@versioned(Versions)
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | AadOauth2Auth<[
    "https://ai.azure.com/.default"
  ]>
)
namespace VoiceLive;

/** API versioning. */
enum Versions {
  /** Version 2025-10-01. */
  v2025_10_01: "2025-10-01",
}
