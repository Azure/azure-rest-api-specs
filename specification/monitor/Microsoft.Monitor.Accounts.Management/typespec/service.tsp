import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Monitor Management Client
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Workspaces Control Plane API" })
@versioned(Versions)
namespace Microsoft.Monitor;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-05-03-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("API Version 2025-05-03-preview")
  v2025_05_03: "2025-05-03-preview",
}
