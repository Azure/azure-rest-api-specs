import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./ArcGatewayConfiguration.tsp";
import "./Configuration.tsp";
import "./ConnectivityConfiguration.tsp";
import "./DynamicConfiguration.tsp";
import "./DynamicConfigurationVersion.tsp";
import "./NetworkConfiguration.tsp";
import "./SecurityConfiguration.tsp";
import "./TimeServerConfiguration.tsp";
import "./ProvisioningConfigurations.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Edge Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "Microsoft.Edge" })
@versioned(Versions)
namespace Microsoft.Edge;

/** The available API versions. */
enum Versions {
  /** 2024-09-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_09_01_preview: "2024-09-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_01: "2025-06-01",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_01: "2025-08-01",

  /** 2025-12-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_12_01_preview: "2025-12-01-preview",
}
