import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft Inventory" })
@versioned(Microsoft.Inventory.Versions)
namespace Microsoft.Inventory;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01_preview: "2024-01-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-11-01-preview")
  v2024_11_01_preview: "2024-11-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-03-01-preview")
  v2025_03_01_preview: "2025-03-01-preview",
}
