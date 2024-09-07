import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

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
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Defines the asset properties.")
model AssetProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Resource path to asset type (model) definition.")
  assetType?: string;

  @doc("Enabled/Disabled status of the asset.")
  enabled?: boolean;

  @doc("Asset id provided by the customer.")
  @visibility("read", "create")
  externalAssetId?: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the asset.")
  description?: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must have the format <ModuleCR.metadata.namespace>/<ModuleCR.metadata.name>.")
  @visibility("read", "create")
  assetEndpointProfileUri: string;

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility("read")
  version?: int32;

  @doc("Asset manufacturer name.")
  manufacturer?: string;

  @doc("Asset manufacturer URI.")
  manufacturerUri?: string;

  @doc("Asset model name.")
  // `model` is a reserved keyname. Wrap in double quotes
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

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "attributes property field is custom defined by customer"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Protocol-specific default configuration for all data points. Each data point can have its own configuration that overrides the default settings here. This assumes that each asset instance has one protocol.")
  defaultDataPointsConfiguration?: string;

  @doc("Protocol-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here. This assumes that each asset instance has one protocol.")
  defaultEventsConfiguration?: string;

  @doc("Array of data points that are part of the asset. Each data point can reference an asset type capability and have per-data point configuration. See below for more details for the definition of the dataPoints element.")
  @extension("x-ms-identifiers", [])
  dataPoints?: DataPoint[];

  @doc("Array of events that are part of the asset. Each event can reference an asset type capability and have per-event configuration. See below for more details about the definition of the events element.")
  @extension("x-ms-identifiers", [])
  events?: Event[];

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility("read")
  status?: AssetStatus;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines the data point properties.")
model DataPoint {
  @doc("The name of the data point.")
  name?: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  capabilityId?: string;

  @doc("An indication of how the data point should be mapped to OpenTelemetry.")
  observabilityMode?: DataPointsObservabilityMode = DataPointsObservabilityMode.None;

  @doc("Protocol-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  dataPointConfiguration?: string;
}

@doc("Defines the data point observability mode.")
union DataPointsObservabilityMode {
  string,

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
}

@doc("Defines the event properties.")
model Event {
  @doc("The name of the event.")
  name?: string;

  @doc("The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  capabilityId?: string;

  @doc("An indication of how the event should be mapped to OpenTelemetry.")
  observabilityMode?: EventsObservabilityMode = EventsObservabilityMode.None;

  @doc("Protocol-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  eventConfiguration?: string;
}

@doc("Defines the event observability mode.")
union EventsObservabilityMode {
  string,

  @doc("No mapping to OpenTelemetry.")
  None: "none",

  @doc("Map as log to OpenTelemetry.")
  Log: "log",
}

@doc("Defines the asset status properties.")
model AssetStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @extension("x-ms-identifiers", [])
  errors?: AssetStatusError[];

  @doc("A read only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (Edge) state of the Asset. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.")
  version?: int32;
}

@doc("Defines the asset status error properties.")
model AssetStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “capability Id 'foo' does not exist”).")
  message?: string;
}

@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    Asset,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

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
