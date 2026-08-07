import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DeploymentExtensionRuntime.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/**
 * Deployment Extension Runtimes provider for Microsoft.Resources. Manages the
 * regional runtime infrastructure that hosts Azure Deployments server-side
 * extensions.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The Operations API for Microsoft.Resources is defined by another service in the shared provider namespace."
@armProviderNamespace("Microsoft.Resources")
@service(#{ title: "DeploymentExtensionRuntimesClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Resources.DeploymentExtensionRuntimes;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-10-01-preview API version.
   */
  v2026_10_01_preview: "2026-10-01-preview",
}
