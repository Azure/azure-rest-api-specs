import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceRegistry;

/**
 * Returns list of operations.
 */
interface Operations extends Azure.ResourceManager.Operations {}

interface OperationStatusOperations{
  /**
   * Returns the current status of an async operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/operationStatuses/{operationId}")
  @operationId("OperationStatus_Get")
  @get
  list(
    ...LocationBaseParameters,
    ...OperationIdParameter
  ):ArmResponse<OperationListResult>
  | ErrorResponse;
}

/**
 * An indication of how the data point should be mapped to OpenTelemetry.
 */
enum DataPointsObservabilityMode {
  None: "none",
  Counter: "counter",
  Gauge: "gauge",
  Histogram: "histogram",
  Log: "log",
}

/**
 * An indication of how the event should be mapped to OpenTelemetry.
 */
enum EventsObservabilityMode {
  None: "none",
  Log: "log",
}

/**
 * Provisioning state of the resource.
 */
enum ProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation has been canceled.
   */
  Canceled,

  /**
   * Resource has been accepted by the server.
   */
  Accepted,
}

/**
 * Defines the mode to authenticate the user of the client at the server.
 */
enum Mode {
  Anonymous,
  Certificate,
  UsernamePassword,
}

/**
 * Defines the asset properties.
 */
model AssetProperties {
  /**
   * Globally unique, immutable, non-reusable id.
   */
  @visibility("read")
  uuid?: string;

  /**
   * Resource path to asset type (model) definition.
   */
  assetType?: string;

  /**
   * Enabled/Disabled status of the asset.
   */
  enabled?: boolean;

  /**
   * Asset id provided by the customer.
   */
  @visibility("read", "create")
  externalAssetId?: string;

  /**
   * Human-readable display name.
   */
  displayName?: string;

  /**
   * Human-readable description of the asset.
   */
  description?: string;

  /**
   * A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must have the format <ModuleCR.metadata.namespace>/<ModuleCR.metadata.name>.
   */
  @visibility("read", "create")
  assetEndpointProfileUri?: string;

  /**
   * An integer that is incremented each time the resource is modified.
   */
  @visibility("read")
  version?: int32;

  /**
   * Asset manufacturer name.
   */
  manufacturer?: string;

  /**
   * Asset manufacturer URI.
   */
  manufacturerUri?: string;

  /**
   * Asset model name.
   */
  `model`?: string;

  /**
   * Asset product code.
   */
  productCode?: string;

  /**
   * Revision number of the hardware.
   */
  hardwareRevision?: string;

  /**
   * Revision number of the software.
   */
  softwareRevision?: string;

  /**
   * Reference to the documentation.
   */
  documentationUri?: string;

  /**
   * Asset serial number.
   */
  serialNumber?: string;

  /**
   * A set of key-value pairs that contain custom attributes set by the customer.
   */
  attributes?: Record<unknown>;

  /**
   * Protocol-specific default configuration for all data points. Each data point can have its own configuration that overrides the default settings here. This assumes that each asset instance has one protocol.
   */
  defaultDataPointsConfiguration?: string;

  /**
   * Protocol-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here. This assumes that each asset instance has one protocol.
   */
  defaultEventsConfiguration?: string;

  /**
   * Array of data points that are part of the asset. Each data point can reference an asset type capability and have per-data point configuration. See below for more details for the definition of the dataPoints element.
   */
  dataPoints?: AssetPropertiesDataPointsItem[];

  /**
   * Array of events that are part of the asset. Each event can reference an asset type capability and have per-event configuration. See below for more details about the definition of the events element.
   */
  events?: AssetPropertiesEventsItem[];

  /**
   * Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.
   */
  @visibility("read")
  status?: AssetPropertiesStatus;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model AssetPropertiesDataPointsItem {
  /**
   * The name of the data point.
   */
  name?: string;

  /**
   * The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.
   */
  dataSource: string;

  /**
   * The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.
   */
  capabilityId?: string;

  /**
   * An indication of how the data point should be mapped to OpenTelemetry.
   */
  observabilityMode?: DataPointsObservabilityMode = DataPointsObservabilityMode.None;

  /**
   * Protocol-specific configuration for the data point. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.
   */
  dataPointConfiguration?: string;
}

model AssetPropertiesEventsItem {
  /**
   * The name of the event.
   */
  name?: string;

  /**
   * The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.
   */
  eventNotifier: string;

  /**
   * The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.
   */
  capabilityId?: string;

  /**
   * An indication of how the event should be mapped to OpenTelemetry.
   */
  observabilityMode?: EventsObservabilityMode = EventsObservabilityMode.None;

  /**
   * Protocol-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.
   */
  eventConfiguration?: string;
}

/**
 * Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.
 */
model AssetPropertiesStatus {
  /**
   * Array object to transfer and persist errors that originate from the Edge.
   */
  errors?: AssetPropertiesStatusErrorsItem[];

  /**
   * A read only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (Edge) state of the Asset. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.
   */
  version?: int32;
}

model AssetPropertiesStatusErrorsItem {
  /**
   * Error code for classification of errors (ex: 400, 404, 500, etc.).
   */
  code?: int32;

  /**
   * Human readable helpful error message to provide additional context for error (ex: “capability Id 'foo' does not exist”).
   */
  message?: string;
}

/**
 * The extended location.
 */
model AssetExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Asset definition for Patch operation.
 */
model AssetPatchPayload {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Asset resource properties.
   */
  properties?: AssetProperties;
}

/**
 * Defines the Asset Endpoint Profile properties.
 */
model AssetEndpointProfileProperties {
  /**
   * Globally unique, immutable, non-reusable id.
   */
  @visibility("read")
  uuid?: string;

  /**
   * The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.
   */
  targetAddress: url;

  /**
   * Defines the client authentication mechanism to the server.
   */
  userAuthentication?: AssetEndpointProfilePropertiesUserAuthentication;

  /**
   * Defines the authentication mechanism for the southbound connector connecting to the shop floor/OT device.
   */
  transportAuthentication?: AssetEndpointProfilePropertiesTransportAuthentication;

  /**
   * Contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).
   */
  additionalConfiguration?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Defines the client authentication mechanism to the server.
 */
model AssetEndpointProfilePropertiesUserAuthentication {
  /**
   * Defines the mode to authenticate the user of the client at the server.
   */
  mode: Mode = Mode.Certificate;

  /**
   * Defines the username and password references when UsernamePassword user authentication mode is selected.
   */
  usernamePasswordCredentials?: AssetEndpointProfilePropertiesUserAuthenticationUsernamePasswordCredentials;

  /**
   * Defines the certificate reference when Certificate user authentication mode is selected.
   */
  x509Credentials?: AssetEndpointProfilePropertiesUserAuthenticationX509Credentials;
}

/**
 * Defines the username and password references when UsernamePassword user authentication mode is selected.
 */
model AssetEndpointProfilePropertiesUserAuthenticationUsernamePasswordCredentials {
  /**
   * A reference to secret containing the username.
   */
  usernameReference: string;

  /**
   * A reference to secret containing the password.
   */
  passwordReference: string;
}

/**
 * Defines the certificate reference when Certificate user authentication mode is selected.
 */
model AssetEndpointProfilePropertiesUserAuthenticationX509Credentials {
  /**
   * A reference to secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).
   */
  certificateReference: string;
}

/**
 * Defines the authentication mechanism for the southbound connector connecting to the shop floor/OT device.
 */
model AssetEndpointProfilePropertiesTransportAuthentication {
  /**
   * Defines a reference to a secret which contains all certificates and private keys that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.
   */
  ownCertificates: AssetEndpointProfilePropertiesTransportAuthenticationOwnCertificatesItem[];
}

model AssetEndpointProfilePropertiesTransportAuthenticationOwnCertificatesItem {
  /**
   * Certificate thumbprint.
   */
  certThumbprint?: string;

  /**
   * Secret Reference name (cert and private key).
   */
  certSecretReference?: string;

  /**
   * Secret Reference Name (Pfx or Pem password)
   */
  certPasswordReference?: string;
}

/**
 * The extended location.
 */
model AssetEndpointProfileExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * Asset Endpoint Profile definition.
 */
model AssetEndpointProfilePatchPayload {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Asset Endpoint Profile resource properties.
   */
  properties?: AssetEndpointProfileProperties;
}
