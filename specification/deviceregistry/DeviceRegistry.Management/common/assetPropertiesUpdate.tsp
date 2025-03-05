import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./topicUpdate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Defines the asset update properties.")
@added(Versions.v2024_10_01_preview)
model AssetPropertiesUpdate {
  @doc("Enabled/Disabled status of the asset.")
  enabled?: boolean;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the asset.")
  description?: string;

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

  @doc("Stringified JSON that contains connector-specific default configuration for all datasets. Each dataset can have its own configuration that overrides the default settings here.")
  defaultDatasetsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here.")
  defaultEventsConfiguration?: string;

  @doc("Object that describes the default topic information for the asset.")
  defaultTopic?: TopicUpdate;

  @doc("Array of datasets that are part of the asset. Each dataset describes the data points that make up the set.")
  @Azure.ResourceManager.identifiers(#[])
  datasets?: Dataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @Azure.ResourceManager.identifiers(#[])
  events?: Event[];
}
