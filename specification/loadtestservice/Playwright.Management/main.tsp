import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.LoadTestService")
@service(#{ title: "Playwright Service Management API" })
@doc("Playwright service provides access to Playwright workspace resource and it's operations.")
@versioned(Versions)
namespace Playwright.Management;

@doc("Playwright service Management API Versions.")
enum Versions {
  /** 2025-07-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",
}
