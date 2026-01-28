import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./supportedmodel.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.App Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Api is defined in other files."
@armProviderNamespace("Microsoft.App")
@service(#{ title: "Microsoft.App SreAgent management service" })
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

/** The available API versions. */
enum Versions {
  /** 2025-05-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_01_preview: "2025-05-01-preview",
}
