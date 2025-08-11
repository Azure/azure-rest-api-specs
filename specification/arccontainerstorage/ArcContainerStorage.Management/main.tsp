import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgestorageconfiguration.tsp";
import "./ingestsubvolume.tsp";
import "./edgevolume.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service(#{ title: "Microsoft.ArcContainerStorage management service" })
@doc("Microsoft.ArcContainerStorage Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ArcContainerStorage;

/** API versions */
@doc("Microsoft.ArcContainerStorage Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.ArcContainerStorage Resource Provider management API version 2023-11-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_10_01_preview: "2024-10-01-preview",
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
    provider: "Microsoft.ArcContainerStorage",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
