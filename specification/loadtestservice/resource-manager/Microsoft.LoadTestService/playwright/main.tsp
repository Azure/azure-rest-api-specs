import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./typespec/routes.tsp";
import "./typespec/quotas.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.LoadTestService")
@service(#{ title: "Playwright Service Management API" })
@doc("Playwright Service Management API provides access to Playwright workspace resources and their operations through Azure Resource Manager.")
@versioned(Versions)
namespace Playwright.Management;

@doc("Available versions of the Playwright Service Management API.")
enum Versions {
  @doc("Preview version 2025-07-01-preview with experimental features for Playwright workspace management.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",

  @doc("Stable version 2025-09-01 with general availability features for Playwright workspace management.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_09_01: "2025-09-01",

  @doc("Preview version 2026-01-01-preview with experimental features for Playwright workspace management.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",

  @doc("Preview version 2026-02-01-preview with experimental features for Playwright workspace management.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_01_preview: "2026-02-01-preview",
}
