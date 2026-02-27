import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./assets.tsp";
import "./assetEndpointProfiles.tsp";
import "./billings.tsp";
import "./devices.tsp";
import "./discoveredAssets.tsp";
import "./discoveredAssetEndpointProfiles.tsp";
import "./schemaRegistries.tsp";
import "./namespaces.tsp";
import "./credential.tsp";
import "./policy.tsp";
import "./ns_devices.tsp";
import "./ns_discoveredDevices.tsp";
import "./ns_assets.tsp";
import "./ns_discoveredAssets.tsp";
import "./ns_assetEndpointProfiles.tsp";
import "./ns_discoveredAssetEndpointProfiles.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes.Private;
using Azure.ResourceManager.Private;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service(#{ title: "Microsoft.DeviceRegistry management service" })
@doc("Microsoft.DeviceRegistry Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.DeviceRegistry;

@doc("Microsoft.DeviceRegistry Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2023-10-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_10_01_preview: "2023-10-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2024-07-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_07_01_preview: "2024-07-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2024-10-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2025-07-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_07_01_preview: "2025-07-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2025-08-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_01_preview: "2025-08-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2026-02-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_02_01_preview: "2026-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "existing api"
@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  @armUpdateProviderNamespace
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.DeviceRegistry",

    ...LocationParameter,

    @path
    @segment("operationStatuses")
    @minLength(1)
    @doc("The ID of an ongoing async operation.")
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v3
    )
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v4
    )
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v5
    )
    operationId: string,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}
