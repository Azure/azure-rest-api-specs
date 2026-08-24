import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";
import "./agent.tsp";
import "./agentconnector.tsp";
import "./agentspace.tsp";
import "./agentspaceconnector.tsp";
import "./supportedagentmodel.tsp";
import "./agentsession.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.App Resource Provider management API. */
@armProviderNamespace("Microsoft.App")
@service(#{ title: "Microsoft.App SreAgent management service" })
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

/** Lists the operations supported by the Microsoft.App resource provider. */
@added(Versions.v2026_11_01_preview)
interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2026-01-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01: "2026-01-01",

  /** 2026-11-01-preview version */
  @Azure.Core.previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_11_01_preview: "2026-11-01-preview",
}
