import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BareMetalConnection.tsp";
import "./routes.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Microsoft BareMetal Azure Resource Provider specification
 */
@armProviderNamespace
@service({
  title: "BootstrapRP",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.BareMetal;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_06_01_preview: "2024-06-01-preview",
}
