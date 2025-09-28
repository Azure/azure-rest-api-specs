import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/titan.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Titan Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Titan management service" })
@versioned(Microsoft.Titan.Versions)
namespace Microsoft.Titan;

/** The available API versions */
enum Versions {
  /** 2021-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-06-24-preview")
  v2024_06_24_preview: "2024-06-24-preview",

  /** 2025-03-01-preview version */
  @useDependency(Microsoft.Inventory.CommonTypes.Versions.v2024_01_01)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-03-01-preview")
  v2025_03_01_preview: "2025-03-01-preview",

  @useDependency(Microsoft.Inventory.CommonTypes.Versions.v2024_01_01)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-06-01-preview")
  v2025_06_01_preview: "2025-06-01-preview",
}
