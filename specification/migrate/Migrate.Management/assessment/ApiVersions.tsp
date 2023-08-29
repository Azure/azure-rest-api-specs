using TypeSpec.Versioning;

namespace Microsoft.Migrate;

enum ApiVersions {
  // @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  // v2018_06_30_preview: "2019-10-01",
  // @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  // v2019_05_01: "2019-05-01",
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2019_10_01: "2019-10-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_01_01: "2020-01-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2020_05_01_preview: "2020-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_02_02_preview: "2022-02-02-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_03_03: "2023-03-03",
}
