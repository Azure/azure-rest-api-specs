import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./assets.tsp";
import "./assetEndpointProfiles.tsp";
import "./billings.tsp";
import "./discoveredAssets.tsp";
import "./discoveredAssetEndpointProfiles.tsp";
import "./schemaRegistries.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Microsoft.DeviceRegistry management service",
})
@doc("Microsoft.DeviceRegistry Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.DeviceRegistry;

/** API versions */
@doc("Microsoft.DeviceRegistry Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2023-11-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_11_01_preview: "2023-11-01-preview",

  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2024-09-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_09_01_preview: "2024-09-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.DeviceRegistry",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
