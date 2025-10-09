import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Asset definition.")
model Asset is TrackedResource<AssetProperties> {
  @doc("Asset name parameter.")
  @key("assetName")
  @segment("assets")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("Defines the asset properties.")
model AssetProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Resource path to asset type (model) definition.")
  @removed(Versions.v2024_09_01_preview)
  assetType?: string;

  @doc("Enabled/Disabled status of the asset.")
  enabled?: boolean;

  @doc("Asset id provided by the customer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalAssetId?: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the asset.")
  description?: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must have the format <ModuleCR.metadata.namespace>/<ModuleCR.metadata.name>.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @removed(Versions.v2024_09_01_preview)
  assetEndpointProfileUri: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must provide asset endpoint profile name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2024_09_01_preview)
  assetEndpointProfileRef: string;

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Versions.v2024_09_01_preview, int32)
  version?: int64;

  @doc("Asset manufacturer name.")
  manufacturer?: string;

  @doc("Asset manufacturer URI.")
  manufacturerUri?: string;

  @doc("Asset model name.")
  `model`?: string;

  @doc("Asset product code.")
  productCode?: string;

  @doc("Revision number of the hardware.")
  hardwareRevision?: string;

  @doc("Revision number of the software.")
  softwareRevision?: string;

  @doc("Reference to the documentation.")
  documentationUri?: string;

  @doc("Asset serial number.")
  serialNumber?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "attributes property field is custom defined by customer"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Reference to a list of discovered assets. Populated only if the asset has been created from discovery flow. Discovered asset names must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2024_09_01_preview)
  discoveredAssetRefs?: string[];

  @doc("Stringified JSON that contains protocol-specific default configuration for all data points. Each data point can have its own configuration that overrides the default settings here.")
  @removed(Versions.v2024_09_01_preview)
  defaultDataPointsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all datasets. Each dataset can have its own configuration that overrides the default settings here.")
  @added(Versions.v2024_09_01_preview)
  defaultDatasetsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here.")
  defaultEventsConfiguration?: string;

  @doc("Object that describes the default topic information for the asset.")
  @added(Versions.v2024_09_01_preview)
  defaultTopic?: Topic;

  @doc("Array of data points that are part of the asset. Each data point can reference an asset type capability and have per-data point configuration.")
  @removed(Versions.v2024_09_01_preview)
  @identifiers(#[])
  dataPoints?: DataPoint[];

  @doc("Array of datasets that are part of the asset. Each dataset describes the data points that make up the set.")
  @added(Versions.v2024_09_01_preview)
  @identifiers(#[])
  datasets?: Dataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @identifiers(#[])
  events?: Event[];

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: AssetStatus;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Defines the dataset properties.")
@added(Versions.v2024_09_01_preview)
model Dataset {
  @doc("Name of the dataset.")
  name: string;

  @doc("Stringified JSON that contains connector-specific JSON string that describes configuration for the specific dataset.")
  datasetConfiguration?: string;

  @doc("Object that describes the topic information for the specific dataset.")
  topic?: Topic;

  @doc("Array of data points that are part of the dataset. Each data point can have per-data point configuration.")
  @identifiers(#[])
  dataPoints?: DataPoint[];
}

@doc("Defines the data point properties.")
model DataPointBase {
  @doc("The name of the data point.")
  @madeRequired(Versions.v2024_09_01_preview)
  name: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  @removed(Versions.v2024_09_01_preview)
  capabilityId?: string;

  @doc("An indication of how the data point should be mapped to OpenTelemetry.")
  @removed(Versions.v2024_09_01_preview)
  observabilityMode?: DataPointsObservabilityMode = DataPointsObservabilityMode.None;

  @doc("Stringified JSON that contains connector-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  dataPointConfiguration?: string;
}

// workaround done to define a default after breaking change on enum values
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Defines the data point properties.")
model DataPoint extends DataPointBase {
  @doc("An indication of how the data point should be mapped to OpenTelemetry.")
  @added(Versions.v2024_09_01_preview)
  observabilityMode?: DataPointObservabilityMode = DataPointObservabilityMode.None;
}

@doc("Defines the data point observability mode.")
@removed(Versions.v2024_09_01_preview)
union DataPointsObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  None: "none",

  @doc("Map as counter to OpenTelemetry.")
  Counter: "counter",

  @doc("Map as gauge to OpenTelemetry.")
  Gauge: "gauge",

  @doc("Map as histogram to OpenTelemetry.")
  Histogram: "histogram",

  @doc("Map as log to OpenTelemetry.")
  Log: "log",

  string,
}

@doc("Defines the data point observability mode.")
@added(Versions.v2024_09_01_preview)
union DataPointObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  None: "None",

  @doc("Map as counter to OpenTelemetry.")
  Counter: "Counter",

  @doc("Map as gauge to OpenTelemetry.")
  Gauge: "Gauge",

  @doc("Map as histogram to OpenTelemetry.")
  Histogram: "Histogram",

  @doc("Map as log to OpenTelemetry.")
  Log: "Log",

  string,
}

@doc("Defines the event properties.")
model EventBase {
  @doc("The name of the event.")
  @madeRequired(Versions.v2024_09_01_preview)
  name: string;

  @doc("The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  @removed(Versions.v2024_09_01_preview)
  capabilityId?: string;

  @doc("An indication of how the event should be mapped to OpenTelemetry.")
  @removed(Versions.v2024_09_01_preview)
  observabilityMode?: EventsObservabilityMode = EventsObservabilityMode.None;

  @doc("Stringified JSON that contains connector-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  eventConfiguration?: string;

  @doc("Object that describes the topic information for the specific event.")
  @added(Versions.v2024_09_01_preview)
  topic?: Topic;
}

// workaround done to define a default after breaking change on enum values
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Defines the event properties.")
model Event extends EventBase {
  @doc("An indication of how the event should be mapped to OpenTelemetry.")
  @added(Versions.v2024_09_01_preview)
  observabilityMode?: EventObservabilityMode = EventObservabilityMode.None;
}

@doc("Defines the event observability mode.")
@removed(Versions.v2024_09_01_preview)
union EventsObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  @removed(Versions.v2024_09_01_preview)
  None: "none",

  @doc("Map as log to OpenTelemetry.")
  @removed(Versions.v2024_09_01_preview)
  Log: "log",

  string,
}

@doc("Defines the event observability mode.")
@added(Versions.v2024_09_01_preview)
union EventObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  @added(Versions.v2024_09_01_preview)
  None: "None",

  @doc("Map as log to OpenTelemetry.")
  @added(Versions.v2024_09_01_preview)
  Log: "Log",

  string,
}

@doc("Defines the asset status properties.")
model AssetStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: AssetStatusError[];

  @doc("A read only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (Edge) state of the Asset. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.")
  @typeChangedFrom(Versions.v2024_09_01_preview, int32)
  @visibility(Lifecycle.Read)
  version?: int64;

  @doc("Array of dataset statuses that describe the status of each dataset.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_09_01_preview)
  @identifiers(#[])
  datasets?: AssetStatusDataset[];

  @doc("Array of event statuses that describe the status of each event.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_09_01_preview)
  @identifiers(#[])
  events?: AssetStatusEvent[];
}

@doc("Defines the asset status error properties.")
model AssetStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  @visibility(Lifecycle.Read)
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “capability Id 'foo' does not exist”).")
  @visibility(Lifecycle.Read)
  message?: string;
}

@doc("Defines the asset status dataset properties.")
@added(Versions.v2024_09_01_preview)
model AssetStatusDataset {
  @doc("The name of the dataset. Must be unique within the status.datasets array. This name is used to correlate between the spec and status dataset information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The message schema reference object.")
  @visibility(Lifecycle.Read)
  messageSchemaReference?: MessageSchemaReference;
}

@doc("Defines the asset status event properties.")
@added(Versions.v2024_09_01_preview)
model AssetStatusEvent {
  @doc("The name of the event. Must be unique within the status.events array. This name is used to correlate between the spec and status event information.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The message schema reference object.")
  @visibility(Lifecycle.Read)
  messageSchemaReference?: MessageSchemaReference;
}

@doc("Defines the message schema reference properties.")
@added(Versions.v2024_09_01_preview)
model MessageSchemaReference {
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

@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Asset>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    Asset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Asset,
      AssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;
  listByResourceGroup is ArmResourceListByParent<Asset>;
  listBySubscription is ArmListBySubscription<Asset>;
}
