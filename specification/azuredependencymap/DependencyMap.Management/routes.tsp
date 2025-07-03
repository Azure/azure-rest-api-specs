import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
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
  @action("getDependencyViewForFocusedMachine")
  getDependencyViewForFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetDependencyViewForFocusedMachineRequest
  >;
  @doc("Get network connections between machines")
  @action("getConnectionsWithConnectedMachineForFocusedMachine")
  getConnectionsWithConnectedMachineForFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetConnectionsWithConnectedMachineForFocusedMachineRequest
  >;
  @doc("Get network connections of a process")
  @action("getConnectionsForProcessOnFocusedMachine")
  getConnectionsForProcessOnFocusedMachine is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    GetConnectionsForProcessOnFocusedMachineRequest
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
