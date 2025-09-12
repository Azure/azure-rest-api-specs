import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
/**
 * The Azure Edge Copilot API.
 */
@armProviderNamespace
// @useAuth(AadOauth2Auth<["user_impersonation"]>)
@service(#{ title: "Edge Copilot" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.EdgeManagement;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-03-01-preview API version.
   */
  v2025_03_01_preview: "2025-03-01-preview",

  /**
   * The 2025-06-01-preview API version.
   */
  v2025_06_01_preview: "2025-06-01-preview",
}
