import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.DependencyMap;

@armResourceOperations
interface Maps {
  get is ArmResourceRead<MapsResource>;
  //create is ArmResourceCreateOrUpdateAsync<MapsResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MapsResource>;
  update is ArmTagsPatchAsync<MapsResource>;
  //update is ArmTagsPatchSync<MapsResource>;
  delete is ArmResourceDeleteWithoutOkAsync<MapsResource>;
  listByResourceGroup is ArmResourceListByParent<MapsResource>;
  listBySubscription is ArmListBySubscription<MapsResource>;
  @doc("Get dependency map of single machine")
  @sharedRoute
  @action("getDependencyViewForFocusedMachine")
  @removed(Versions.v2026_03_01_preview)
  getDependencyViewForFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetDependencyViewForFocusedMachineRequest
  >;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId set to maintain consistent naming across versions"
  @doc("Get dependency map of single machine")
  @sharedRoute
  @action("getDependencyViewForFocusedMachine")
  @added(Versions.v2026_03_01_preview)
  @operationId("Maps_GetDependencyViewForFocusedMachine")
  getDependencyViewForFocusedMachineAsync is ArmResourceActionAsync<
    MapsResource,
    GetDependencyViewForFocusedMachineRequest,
    GetDependencyViewForFocusedMachineOperationResult,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GetDependencyViewForFocusedMachineOperationResult> &
      ArmLroLocationHeader<FinalResult = GetDependencyViewForFocusedMachineOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Get network connections between machines")
  @sharedRoute
  @action("getConnectionsWithConnectedMachineForFocusedMachine")
  @removed(Versions.v2026_03_01_preview)
  getConnectionsWithConnectedMachineForFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetConnectionsWithConnectedMachineForFocusedMachineRequest
  >;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId set to maintain consistent naming across versions"
  @doc("Get network connections between machines")
  @sharedRoute
  @action("getConnectionsWithConnectedMachineForFocusedMachine")
  @added(Versions.v2026_03_01_preview)
  @operationId("Maps_GetConnectionsWithConnectedMachineForFocusedMachine")
  getConnectionsWithConnectedMachineForFocusedMachineAsync is ArmResourceActionAsync<
    MapsResource,
    GetConnectionsWithConnectedMachineForFocusedMachineRequest,
    GetConnectionsWithConnectedMachineForFocusedMachineOperationResult,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GetConnectionsWithConnectedMachineForFocusedMachineOperationResult> &
      ArmLroLocationHeader<FinalResult = GetConnectionsWithConnectedMachineForFocusedMachineOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Get network connections of a process")
  @sharedRoute
  @action("getConnectionsForProcessOnFocusedMachine")
  @removed(Versions.v2026_03_01_preview)
  getConnectionsForProcessOnFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetConnectionsForProcessOnFocusedMachineRequest
  >;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId set to maintain consistent naming across versions"
  @doc("Get network connections of a process")
  @sharedRoute
  @action("getConnectionsForProcessOnFocusedMachine")
  @added(Versions.v2026_03_01_preview)
  @operationId("Maps_GetConnectionsForProcessOnFocusedMachine")
  getConnectionsForProcessOnFocusedMachineAsync is ArmResourceActionAsync<
    MapsResource,
    GetConnectionsForProcessOnFocusedMachineRequest,
    GetConnectionsForProcessOnFocusedMachineOperationResult,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GetConnectionsForProcessOnFocusedMachineOperationResult> &
      ArmLroLocationHeader<FinalResult = GetConnectionsForProcessOnFocusedMachineOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Export dependencies")
  @action("exportDependencies")
  exportDependencies is ArmResourceActionAsync<
    MapsResource,
    ExportDependenciesRequest,
    ExportDependenciesOperationResult,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ExportDependenciesOperationResult> &
      ArmLroLocationHeader<FinalResult = ExportDependenciesOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Get dependencies for all machines")
  @action("GetDependencyViewForAllMachines")
  @added(Versions.v2025_07_01_preview)
  getDependencyViewForAllMachines is ArmResourceActionAsync<
    MapsResource,
    GetDependencyViewForAllMachinesRequest,
    GetDependencyViewForAllMachinesOperationResult,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GetDependencyViewForAllMachinesOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = GetDependencyViewForAllMachinesOperationResult>
  >;
}

@armResourceOperations
interface DiscoverySources {
  get is ArmResourceRead<DiscoverySourceResource>;
  //create is ArmResourceCreateOrUpdateAsync<DiscoverySourceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DiscoverySourceResource>;
  update is ArmTagsPatchAsync<DiscoverySourceResource>;
  //update is ArmTagsPatchSync<DiscoverySourceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoverySourceResource>;
  listByMapsResource is ArmResourceListByParent<DiscoverySourceResource>;
}
