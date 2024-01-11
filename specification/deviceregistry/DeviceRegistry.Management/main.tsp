import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";
import "./asset.tsp";
import "./assetEndpointProfile.tsp";
import "./device.tsp";

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
/** Microsoft.DeviceRegistry Resource Provider management API. */
@versioned(Microsoft.DeviceRegistry.Versions)
namespace Microsoft.DeviceRegistry;

/** The available API versions. */
enum Versions {
  /** 2023-11-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_11_01_preview: "2023-11-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

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