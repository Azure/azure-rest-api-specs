import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("API Versions for Network Assessment Resource.")
enum NetworkApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2026-02-02-preview API Version.")
  v2026_02_02_preview: "2026-02-02-preview",
}
