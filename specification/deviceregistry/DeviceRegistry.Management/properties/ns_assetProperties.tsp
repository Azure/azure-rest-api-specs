import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../common/destination.tsp";
import "../common/extendedLocation.tsp";
import "../common/provisioningState.tsp";
import "../common/deviceRef.tsp";
import "../common/status.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Defines the asset properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Enabled/disabled status of the asset.")
  enabled?: boolean;

  @doc("Asset ID provided by the customer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalAssetId?: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the asset.")
  description?: string;

  @doc("Reference to the device that provides data for this asset. Must provide device name & endpoint on the device to use.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceRef: DeviceRef;

  @doc("URIs or type definition IDs.")
  assetTypeRefs?: string[];

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility(Lifecycle.Read)
  version?: int64;

  @doc("A timestamp (in UTC) that is updated each time the resource is modified.")
  @visibility(Lifecycle.Read)
  lastTransitionTime?: utcDateTime;

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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "attributes property field is custom defined by customer"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Reference to a list of discovered assets. Populated only if the asset has been created from discovery flow. Discovered asset names must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  discoveredAssetRefs?: string[];

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

  @doc("Array of datasets that are part of the asset. Each dataset describes the data points that make up the set.")
  @Azure.ResourceManager.identifiers(#[])
  datasets?: NamespaceDataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @Azure.ResourceManager.identifiers(#[])
  events?: NamespaceEvent[];

  @doc("Array of streams that are part of the asset. Each stream can have a per-stream configuration.")
  @identifiers(#[])
  @added(Versions.v2025_07_01_preview)
  streams?: NamespaceStream[];

  @doc("Array of management groups that are part of the asset. Each management group can have a per-group configuration.")
  @identifiers(#[])
  @added(Versions.v2025_07_01_preview)
  managementGroups?: ManagementGroup[];

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: NamespaceAssetStatus;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Defines the dataset properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDataset {
  @doc("Name of the dataset.")
  name: string;

  @doc("Reference to a data source for a given dataset.")
  dataSource?: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Stringified JSON that contains connector-specific JSON string that describes configuration for the specific dataset.")
  datasetConfiguration?: string;

  @doc("Destinations for a dataset.")
  @identifiers(#[])
  destinations?: DatasetDestination[];

  @doc("Array of data points that are part of the dataset. Each data point can have per-data point configuration.")
  @Azure.ResourceManager.identifiers(#[])
  dataPoints?: NamespaceDatasetDataPoint[];
}

@doc("Defines the data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDataPoint {
  @doc("The name of the data point.")
  name: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("Stringified JSON that contains connector-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  dataPointConfiguration?: string;
}

@doc("Defines the dataset data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDatasetDataPoint is NamespaceDataPoint {
  @doc("URI or type definition ID.")
  @added(Versions.v2025_07_01_preview)
  typeRef?: string;
}

@doc("Defines the event data point properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceEventDataPoint is NamespaceDataPoint;

@doc("Defines the event properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceEvent {
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
  dataPoints?: NamespaceEventDataPoint[];
}

@doc("Defines the stream properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceStream {
  @doc("Name of the stream definition.")
  name: string;

  @doc("Stringified JSON that contains connector-specific configuration for the specific stream.")
  streamConfiguration?: string;

  @doc("URI or type definition ID.")
  typeRef?: string;

  @doc("Destinations for a stream.")
  @identifiers(#[])
  destinations?: StreamDestination[];
}

@doc("Defines the management group properties.")
@added(Versions.v2025_07_01_preview)
model ManagementGroup {
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
  actions?: ManagementAction[];
}

@doc("Defines the action properties.")
@added(Versions.v2025_07_01_preview)
model ManagementAction {
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
  actionType?: ManagementActionType = ManagementActionType.Call;

  @doc("Response timeout for the action.")
  timeoutInSeconds?: int32;
}

@doc("Defines the ManagementAction's type.")
@added(Versions.v2025_07_01_preview)
union ManagementActionType {
  @doc("Call action type.")
  Call: "Call",

  @doc("Read action type.")
  Read: "Read",

  @doc("Write action type.")
  Write: "Write",

  string,
}

@doc("Defines the asset status properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatus {
  @doc("Defines the asset status config properties.")
  @visibility(Lifecycle.Read)
  config?: StatusConfig;

  @doc("Array of dataset statuses that describe the status of each dataset.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  datasets?: NamespaceAssetStatusDataset[];

  @doc("Array of event statuses that describe the status of each event.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  events?: NamespaceAssetStatusEvent[];

  @doc("Array of stream statuses that describe the status of each stream.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  streams?: NamespaceAssetStatusStream[];

  @doc("Array of management group statuses that describe the status of each management group.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  managementGroups?: NamespaceAssetStatusManagementGroup[];
}

@doc("Defines the asset status dataset properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatusDataset {
  @doc("The name of the dataset. Must be unique within the status.datasets array. This name is used to correlate between the spec and status dataset information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The message schema reference object.")
  @visibility(Lifecycle.Read)
  messageSchemaReference?: NamespaceMessageSchemaReference;

  @doc("Object to transfer and persist errors that originate from the edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the asset status event properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatusEvent {
  @doc("The name of the event. Must be unique within the status.events array. This name is used to correlate between the spec and status event information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The message schema reference object.")
  @visibility(Lifecycle.Read)
  messageSchemaReference?: NamespaceMessageSchemaReference;

  @doc("Object to transfer and persist errors that originate from the edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the asset status stream properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatusStream {
  @doc("The name of the stream. Must be unique within the status.streams array. This name is used to correlate between the spec and status event information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The message schema reference object.")
  @visibility(Lifecycle.Read)
  messageSchemaReference?: NamespaceMessageSchemaReference;

  @doc("Object to transfer and persist errors that originate from the edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the asset status management group properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatusManagementGroup {
  @doc("The name of the management group. Must be unique within the status.managementGroups array. This name is used to correlate between the spec and status event information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Array of action statuses that describe the status of each action.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  actions?: NamespaceAssetStatusManagementAction[];
}

@doc("Defines the asset status action properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceAssetStatusManagementAction {
  @doc("The name of the action. Must be unique within the status.actions array. This name is used to correlate between the spec and status event information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The request message schema reference object for the action.")
  @visibility(Lifecycle.Read)
  requestMessageSchemaReference?: NamespaceMessageSchemaReference;

  @doc("The response message schema reference object for the action.")
  @visibility(Lifecycle.Read)
  responseMessageSchemaReference?: NamespaceMessageSchemaReference;

  @doc("Object to transfer and persist errors that originate from the edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the message schema reference properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceMessageSchemaReference {
  @doc("The message schema registry namespace.")
  @visibility(Lifecycle.Read)
  schemaRegistryNamespace: string;

  @doc("The message schema name.")
  @visibility(Lifecycle.Read)
  schemaName: string;

  @doc("The message schema version.")
  @visibility(Lifecycle.Read)
  schemaVersion: string;
}
