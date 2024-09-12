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
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Discovered Asset definition.")
@added(Versions.v2024_09_01_preview)
model DiscoveredAsset is TrackedResource<DiscoveredAssetProperties> {
  @doc("Discovered Asset name parameter.")
  @key("discoveredAssetName")
  @segment("discoveredAssets")
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

@doc("Defines the discovered asset properties.")
@added(Versions.v2024_09_01_preview)
model DiscoveredAssetProperties {
  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must provide asset endpoint profile name.")
  @visibility("read", "create")
  assetEndpointProfileRef: string;

  @doc("Identifier used to detect changes in the asset.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

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

  @doc("Stringified JSON that contains connector-specific default configuration for all datasets. Each dataset can have its own configuration that overrides the default settings here.")
  defaultDatasetsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here.")
  defaultEventsConfiguration?: string;

  @doc("Object that describes the default topic information for the asset.")
  defaultTopic?: Topic;

  @doc("Array of datasets that are part of the asset. Each dataset spec describes the data points that make up the set.")
  @extension("x-ms-identifiers", [])
  datasets?: DiscoveredDataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @extension("x-ms-identifiers", [])
  events?: DiscoveredEvent[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines the dataset properties.")
@added(Versions.v2024_09_01_preview)
model DiscoveredDataset {
  @doc("Name of the dataset.")
  name: string;

  @doc("Stringified JSON that contains connector-specific properties that describes configuration for the specific dataset.")
  datasetConfiguration?: string;

  @doc("Object that describes the topic information for the specific dataset.")
  topic?: Topic;

  @doc("Array of data points that are part of the dataset. Each data point can have per-data point configuration.")
  @extension("x-ms-identifiers", [])
  dataPoints?: DiscoveredDataPoint[];
}

@doc("Defines the data point properties.")
@added(Versions.v2024_09_01_preview)
model DiscoveredDataPoint {
  @doc("The name of the data point.")
  name: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("Stringified JSON that contains connector-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  dataPointConfiguration?: string;

  @doc("UTC timestamp indicating when the data point was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the event properties.")
@added(Versions.v2024_09_01_preview)
model DiscoveredEvent {
  @doc("The name of the event.")
  name: string;

  @doc("The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("Stringified JSON that contains connector-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  eventConfiguration?: string;

  @doc("Object that describes the topic information for the specific event.")
  topic?: Topic;

  @doc("UTC timestamp indicating when the event was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

// The updateable properties of the Discovered Asset.
// This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
// since otherwise it extends the ARM TrackedResource type.
alias DiscoveredAssetPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<DiscoveredAssetProperties>>;
};

@armResourceOperations
@added(Versions.v2024_09_01_preview)
interface DiscoveredAssets {
  get is ArmResourceRead<DiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAsset>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    DiscoveredAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      DiscoveredAsset,
      DiscoveredAssetPropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<DiscoveredAsset>;
  listBySubscription is ArmListBySubscription<DiscoveredAsset>;
}
