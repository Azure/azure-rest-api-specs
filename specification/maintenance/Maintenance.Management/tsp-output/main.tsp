import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./MaintenanceConfiguration.tsp";
import "./MaintenanceConfiguration.tsp";
import "./ApplyUpdate.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Maintenance Management Client
 */
@armProviderNamespace
@service({
  title: "MaintenanceManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.Maintenance;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-09-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_01_preview: "2023-09-01-preview",
}
