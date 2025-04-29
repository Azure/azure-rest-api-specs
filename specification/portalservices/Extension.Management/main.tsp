import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ExtensionTenantCompileFile.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Allows creation and deletion of Azure portal extensions.
 */
@armProviderNamespace
@service(#{ title: "Microsoft.PortalServices" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.PortalServices;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-04-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_04_01_preview: "2024-04-01-preview",
}
