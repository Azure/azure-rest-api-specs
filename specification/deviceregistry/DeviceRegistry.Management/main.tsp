import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./assets.tsp";
import "./assetEndpointProfiles.tsp";

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
@versioned(Microsoft.DeviceRegistry.Versions)
@doc("Microsoft.DeviceRegistry Resource Provider management API.")
namespace Microsoft.DeviceRegistry;

/** API versions */
@doc("Microsoft.DeviceRegistry Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.DeviceRegistry Resource Provider management API version 2023-11-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_11_01_preview: "2023-11-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@@Autorest.example(Operations.list,
  "./examples/List_Operations.json",
  "Returns list of operations."
);

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  @armUpdateProviderNamespace
  @Autorest.example(
    "./examples/Get_OperationStatus.json",
    "Get the status of an async operation."
  )
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
