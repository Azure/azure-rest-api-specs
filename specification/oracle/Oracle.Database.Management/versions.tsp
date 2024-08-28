using TypeSpec.Versioning;

namespace Oracle.Database;

@doc("Versions for API")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("2023-09-01")
  v20230901: "2023-09-01",

  @doc("2024-06-01-preview")
  v20240601_preview: "2024-06-01-preview",
}
