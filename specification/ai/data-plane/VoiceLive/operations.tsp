import "./common";
import "./models.tsp";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace VoiceLive;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_05_01_preview: "2025-05-01-preview",
}