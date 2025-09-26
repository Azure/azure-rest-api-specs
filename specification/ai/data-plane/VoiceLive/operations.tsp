import "./common";
import "./models.tsp";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace VoiceLive;

@doc("API versioning.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("Version 2025-10-01.")
  v2025_10_01: "2025-10-01",
}