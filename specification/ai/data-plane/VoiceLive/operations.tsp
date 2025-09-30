import "./models.tsp";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace VoiceLive;

// Service versioning is enum based
#suppress "@azure-tools/typespec-azure-core/no-enum" 
@doc("API versioning.")
enum Versions {
  @doc("Version 2025-10-01.")
  v2025_10_01: "2025-10-01",
}