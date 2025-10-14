import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WindowsImage.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Windows Image Builder Client
 */
@armProviderNamespace
@service(#{ title: "WindowsImageBuilder" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.WindowsImageBuilder;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-08-22-preview API version.
   */
  v2024_08_22_preview: "2024-08-22-preview",
}
