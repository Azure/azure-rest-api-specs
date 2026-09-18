import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Monitor Agents Management Client
 */
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Agents Control Plane API" })
@versioned(Versions)
namespace Microsoft.Monitor;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-05-01-preview API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("API Version 2026-05-01-preview")
  v2026_05_01: "2026-05-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
