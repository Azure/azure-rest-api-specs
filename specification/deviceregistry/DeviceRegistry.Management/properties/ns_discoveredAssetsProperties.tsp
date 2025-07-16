import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../common/destination.tsp";
import "../common/extendedLocation.tsp";
import "../common/provisioningState.tsp";
import "../common/deviceRef.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Defines the discovered asset properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredAssetProperties {
  @doc("Reference to the device that provides data for this asset. Must provide device name & endpoint on the device to use.")
  deviceRef: DeviceRef;

  @doc("URIs or type definition IDs.")
  assetTypeRefs?: string[];

  @doc("Identifier used to detect changes in the asset.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Asset manufacturer.")
  manufacturer?: string;

  @doc("Asset manufacturer URI.")
  manufacturerUri?: string;

  @doc("Asset model.")
  `model`?: string;

  @doc("Asset product code.")
  productCode?: string;

  @doc("Asset hardware revision number.")
  hardwareRevision?: string;

  @doc("Asset software revision number.")
  softwareRevision?: string;

  @doc("Asset documentation reference.")
  documentationUri?: string;

  @doc("Asset serial number.")
  serialNumber?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "attributes property field is custom defined"
  @doc("A set of key-value pairs that contain custom attributes.")
  attributes?: Record<unknown>;

  @doc("Stringified JSON that contains connector-specific default configuration for all datasets. Each dataset can have its own configuration that overrides the default settings here.")
  defaultDatasetsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here.")
  defaultEventsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all streams. Each stream can have its own configuration that overrides the default settings here.")
  defaultStreamsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all management groups. Each management group can have its own configuration that overrides the default settings here.")
  defaultManagementGroupsConfiguration?: string;

  @doc("Default destinations for a dataset.")
  @identifiers(#[])
  defaultDatasetsDestinations?: DatasetDestination[];

  @doc("Default destinations for an event.")
  @identifiers(#[])
  defaultEventsDestinations?: EventDestination[];

  @doc("Default destinations for a stream.")
  @identifiers(#[])
  defaultStreamsDestinations?: StreamDestination[];

  @doc("Array of datasets that are part of the asset. Each dataset spec describes the data points that make up the set.")
  @Azure.ResourceManager.identifiers(#[])
  datasets?: NamespaceDiscoveredDataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @Azure.ResourceManager.identifiers(#[])
  events?: NamespaceDiscoveredEvent[];

  @doc("Array of streams that are part of the asset. Each stream can have a per-stream configuration.")
  @identifiers(#[])
  streams?: NamespaceDiscoveredStream[];

  @doc("Array of management groups that are part of the asset. Each management group can have a per-group configuration.")
  @identifiers(#[])
  managementGroups?: NamespaceDiscoveredManagementGroup[];

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Defines the dataset properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDataset {
  @doc("Name of the dataset.")
  name: string;

  @doc("Reference to a data source for a given dataset.")
  dataSource?: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Stringified JSON that contains connector-specific properties that describes configuration for the specific dataset.")
  datasetConfiguration?: string;

  @doc("Destinations for a dataset.")
  @identifiers(#[])
  destinations?: DatasetDestination[];

  @doc("Array of data points that are part of the dataset. Each data point can have per-data point configuration.")
  @Azure.ResourceManager.identifiers(#[])
  dataPoints?: NamespaceDiscoveredDatasetDataPoint[];

  @doc("Timestamp (in UTC) indicating when the dataset was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDataPoint {
  @doc("The name of the data point.")
  name: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("Stringified JSON that contains connector-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  dataPointConfiguration?: string;

  @doc("UTC timestamp indicating when the data point was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the discovered dataset data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDatasetDataPoint is NamespaceDiscoveredDataPoint {
  @doc("URI or type definition ID.")
  typeRef?: string;
}

@doc("Defines the discovered event data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredEventDataPoint is NamespaceDiscoveredDataPoint;

@doc("Defines the event properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredEvent {
  @doc("The name of the event.")
  name: string;

  @doc("The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("Stringified JSON that contains connector-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  eventConfiguration?: string;

  @doc("Destinations for an event.")
  @identifiers(#[])
  destinations?: EventDestination[];

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Array of data points that are part of the event. Each data point can have a per-data point configuration.")
  @identifiers(#[])
  dataPoints?: NamespaceDiscoveredEventDataPoint[];

  @doc("UTC timestamp indicating when the event was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the stream properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredStream {
  @doc("Name of the stream definition.")
  name: string;

  @doc("Stringified JSON that contains connector-specific configuration for the specific stream.")
  streamConfiguration?: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Destinations for a stream.")
  @identifiers(#[])
  destinations?: StreamDestination[];

  @doc("Timestamp (in UTC) indicating when the stream was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the management group properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredManagementGroup {
  @doc("Name of the management group.")
  name: string;

  @doc("Stringified JSON that contains connector-specific configuration for the management group.")
  managementGroupConfiguration?: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Default MQTT topic path on which a client will receive the request for all actions that are part of the management group.")
  defaultTopic?: string;

  @doc("Default response timeout for all actions that are part of the management group.")
  defaultTimeoutInSeconds?: int32 = 100;

  @doc("Array of actions that are part of the management group. Each action can have an individual configuration.")
  @Azure.ResourceManager.identifiers(#[])
  actions?: NamespaceDiscoveredManagementAction[];

  @doc("Timestamp (in UTC) indicating when the management group was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the action properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredManagementAction {
  @doc("Name of the action.")
  name: string;

  @doc("Stringified JSON that contains connector-specific configuration for the action.")
  actionConfiguration?: string;

  @doc("The target URI on which a client can invoke the specific action.")
  targetUri: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("The MQTT topic path on which a client will receive the request for the action.")
  topic?: string;

  @doc("The type of the action.")
  actionType?: NamespaceDiscoveredManagementActionType = NamespaceDiscoveredManagementActionType.Call;

  @doc("Response timeout for the action.")
  timeoutInSeconds?: int32;

  @doc("Timestamp (in UTC) indicating when the management action was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the ManagementAction's type.")
@added(Versions.v2025_07_01_preview)
union NamespaceDiscoveredManagementActionType {
  @doc("Call action type.")
  Call: "Call",

  @doc("Read action type.")
  Read: "Read",

  @doc("Write action type.")
  Write: "Write",

  string,
}
