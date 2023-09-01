import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2022_12_01: "2022-12-01",

    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2023_05_15: "2023-05-15",

    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2023_06_01_Preview: "2023-06-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2023_07_01_Preview: "2023-07-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2023_08_01_Preview: "2023-08-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2023_09_01_Preview: "2023-09-01-preview",
}
