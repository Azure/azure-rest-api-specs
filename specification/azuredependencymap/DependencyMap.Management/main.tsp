import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
//import "@azure-tools/typespec-providerhub";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace
@service({
  title: "Microsoft.DependencyMap management service",
})
@doc("Microsoft.DependencyMap management service")
@versioned(Microsoft.DependencyMap.Versions)
namespace Microsoft.DependencyMap;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_06_01_preview: "2024-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Maps resource")
model MapsResource is TrackedResource<MapsResourceProperties> {
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{2,23}$")
  @key("mapName")
  @segment("maps")
  @doc("Maps resource name")
  @visibility("read")
  @path
  name: string;
}

@doc("The properties of Maps resource")
model MapsResourceProperties {
  @doc("Provisioning state of Maps resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Provisioning state of the resource")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState, //standard terminal values

  @doc("This state indicates that the resource is being provisioned.")
  Provisioning,

  @doc("This state indicates that the resource is being updated.")
  Updating,

  @doc("This state indicates that the resource is being deleted.")
  Deleting,

  @doc("This state indicates that the operation on the resource has been accepted.")
  Accepted,
}

@armResourceOperations
interface Maps {
  get is ArmResourceRead<MapsResource>;
  //create is ArmResourceCreateOrUpdateAsync<MapsResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MapsResource>;
  update is ArmResourcePatchAsync<MapsResource, MapsResourceProperties>;
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
  exportDependencies is ArmResourceActionNoResponseContentAsync<
    MapsResource,
    ExportDependenciesRequest
  >;
}

@doc("Filters for dependency map visualization apis")
model DependencyMapVisualizationFilter {
  @doc("DateTime filter")
  dateTime?: DateTimeFilter;

  @doc("Process name filter")
  processNameFilter?: ProcessNameFilter;
}

@doc("UTC DateTime filter for dependency map visualization apis")
model DateTimeFilter {
  @doc("Start date time for dependency map visualization query")
  startDateTimeUtc?: utcDateTime;

  @doc("End date time for dependency map visualization query")
  endDateTimeUtc?: utcDateTime;
}

@doc("Process name filter for dependency map visualization apis")
model ProcessNameFilter {
  @doc("Operator for process name filter")
  operator: ProcessNameFilterOperator;

  @doc("List of process names on which the operator should be applied")
  processNames: string[];
}

@doc("Operator enum for process name filter")
enum ProcessNameFilterOperator {
  @doc("Operator to include items in the result")
  contains,

  @doc("Operator to exclude items in the result")
  notContains,
}

@doc("GetDependencyViewForFocusedMachine request model")
model GetDependencyViewForFocusedMachineRequest {
  @doc("Machine arm id")
  focusedMachineId: string;

  @doc("Filters for GetSingleMachineDependencyView")
  filters?: DependencyMapVisualizationFilter;
}

@doc("GetConnectionsWithConnectedMachineForFocusedMachine request model")
model GetConnectionsWithConnectedMachineForFocusedMachineRequest {
  @doc("Source machine arm id")
  focusedMachineId: string;

  @doc("Destination machine arm id")
  connectedMachineId: string;

  @doc("Filters for GetNetworkConnectionsBetweenMachines")
  filters?: DependencyMapVisualizationFilter;
}

@doc("GetConnectionsForProcessOnFocusedMachine request model")
model GetConnectionsForProcessOnFocusedMachineRequest {
  @doc("Machine arm id")
  focusedMachineId: string;

  @doc("Process id")
  processIdOnFocusedMachine: string;

  @doc("Filters for GetProcessNetworkConnections")
  filters?: DependencyMapVisualizationFilter;
}

@doc("ExportDependencies request model")
model ExportDependenciesRequest {
  @doc("Machine arm id")
  focusedMachineId: string;

  @doc("Filters for ExportDependencies")
  filters?: DependencyMapVisualizationFilter;
}

@doc("A Discovery Source resource")
@parentResource(MapsResource)
model DiscoverySourceResource
  is TrackedResource<DiscoverySourceResourceProperties> {
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{2,23}$")
  @key("sourceName")
  @segment("discoverySources")
  @doc("discovery source resource")
  @visibility("read")
  @path
  name: string;
}

@doc("The properties of Discovery Source resource")
@discriminator("sourceType")
model DiscoverySourceResourceProperties {
  @doc("Provisioning state of Discovery Source resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Source type of Discovery Source resource.")
  @visibility("read", "create")
  sourceType: SourceType;

  @doc("Source ArmId of Discovery Source resource")
  @visibility("read", "create")
  sourceId: string;
}

@doc("Arc discovery source resource properties")
model ArcDiscoverySourceResourceProperties
  extends DiscoverySourceResourceProperties {
  @doc("Type of discovery source resource")
  sourceType: SourceType.Arc;

  @doc("Arc details of the discoverySource resource")
  @visibility("read", "create")
  arcDetails: ArcDetails;

  @doc("Fabric details of the discoverySource resource")
  @visibility("read", "create")
  fabricDetails: FabricDetails;

  @doc("Agent settings for the discoverySource resource")
  @visibility("read", "create", "update")
  agentSettings: AgentSettings;

  @doc("Agent status for the discoverySource resource")
  @visibility("read")
  agentStatus?: AgentStatus;
}

@doc("OffAzure discovery source resource properties")
model OffAzureDiscoverySourceResourceProperties
  extends DiscoverySourceResourceProperties {
  @doc("OffAzure discovery source type")
  sourceType: SourceType.OffAzure;
}

@doc("Arc details of the discovery source")
model ArcDetails {
  @doc("Custom location corresponding to the discovery source")
  @visibility("read", "create")
  customLocation: string;
}

@doc("Fabric details of the discovery source")
model FabricDetails {
  @doc("Fabric Type")
  @visibility("read", "create")
  fabricType: FabricType;

  @doc("FQDN of the source")
  @visibility("read", "create")
  fqdn: string;

  @doc("Port number of the fabric")
  @visibility("read", "create")
  port: int32;

  @doc("ArmId of the fabric credential")
  @visibility("read", "create", "update")
  credential: string;

  @doc("Guest credentials")
  @visibility("read", "create", "update")
  guestCredentials: string[];
}

@doc("Agent settings of the discovery source")
model AgentSettings {
  @doc("Dependency mapping data upload frequency")
  @visibility("read", "create", "update")
  depMapDataUploadFrequencyInMinutes: int32;
}

@doc("Agent status of the discovery source")
model AgentStatus {
  @doc("Last upload time of dependency map data")
  @visibility("read")
  lastUploadTime: utcDateTime;

  @doc("Last depMap data upload error")
  uploadError: string;
}

@doc("Fabric type enum")
enum FabricType {
  @doc("VMware fabric type")
  VMware,
  //fill this
}

@doc("Source type enum")
enum SourceType {
  @doc("Arc source type")
  Arc,

  @doc("OffAzure source type")
  OffAzure,
}

@armResourceOperations
interface DiscoverySources {
  get is ArmResourceRead<DiscoverySourceResource>;
  //create is ArmResourceCreateOrUpdateAsync<DiscoverySourceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DiscoverySourceResource>;
  update is ArmResourcePatchAsync<
    DiscoverySourceResource,
    DiscoverySourceResourceProperties
  >;
  //update is ArmTagsPatchSync<DiscoverySourceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoverySourceResource>;
  listByResourceGroup is ArmResourceListByParent<DiscoverySourceResource>;
  listBySubscription is ArmListBySubscription<DiscoverySourceResource>;
}
