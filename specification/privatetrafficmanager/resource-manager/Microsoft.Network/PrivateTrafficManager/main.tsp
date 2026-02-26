import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/EndpointModels.tsp";
import "./models/HealthPolicyModels.tsp";
import "./models/ProfileModels.tsp";
import "./models/SiteModels.tsp";
import "./models/TopologyMapModels.tsp";
import "./interfaces/Endpoint.tsp";
import "./interfaces/HealthPolicy.tsp";
import "./interfaces/Profile.tsp";
import "./interfaces/Site.tsp";
import "./interfaces/TopologyMap.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.Network Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Private Traffic Manager Service" })
@versioned(Microsoft.Network.Versions)
namespace Microsoft.Network;

/** The available API versions. */
enum Versions {
  /** 2026-02-09-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_02_09_preview: "2026-02-09-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
