import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BareMetalConnection.tsp";
import "./NetworkInterfaceAttachment.tsp";
import "./PeeringSetting.tsp";
import "./routes.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Microsoft BareMetal Azure Resource Provider specification
 */
@armProviderNamespace
@service(#{ title: "BootstrapRP" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.BareMetal;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-02-01-preview API version.
   */
  v2025_02_01_preview: "2025-02-01-preview",

  /**
   * The 2025-08-01-preview API version.
   */
  v2025_08_01_preview: "2025-08-01-preview",
}
