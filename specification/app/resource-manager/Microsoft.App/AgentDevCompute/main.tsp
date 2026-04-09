import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";
import "./agentcompute.tsp";
import "./sandboxgroup.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.App Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Api is defined in other files."
@armProviderNamespace("Microsoft.App")
@service(#{ title: "Microsoft.App AgentDevCompute management service" })
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

/** The available API versions. */
enum Versions {
  /** 2026-02-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_01_preview: "2026-02-01-preview",
}
