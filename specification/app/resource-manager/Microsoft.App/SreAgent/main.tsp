import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";
import "./agent.tsp";
import "./agentconnector.tsp";
import "./agentspace.tsp";
import "./agentspaceconnector.tsp";
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
  /** 2026-01-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01: "2026-01-01",
}
