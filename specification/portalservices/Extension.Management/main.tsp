import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PortalExtension.tsp";
import "./ExtensionVersion.tsp";
import "./ExtensionDeployment.tsp";
import "./ExtensionSlot.tsp";
import "./ExtensionTenantCompileFile.tsp";
import "./back-compatible.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
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
   * The 2024-10-01-preview API version.
   */
  v2024_10_01_preview: "2024-10-01-preview",
}
