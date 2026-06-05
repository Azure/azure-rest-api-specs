import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../common/deviceTypes.tsp";
import "./common/provisionedRefs.tsp";
import "./deviceCapabilities.tsp";
import "./deviceAuthenticationProfiles.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device resource
// Shared types (DeviceEnabledStatus) are defined
// in specification/deviceregistry/common/deviceTypes.tsp.
// ──────────────────────────────────────────────

/** A device resource. */
@resource("devices")
@parentResource(Namespace)
model Device {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

@@key(Device.name, "deviceName");

/** Properties of a device resource. */
model DeviceProperties {
  ...OmitProperties<DevicePropertiesBase, "uuid">;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/** Response model for device lookup POST actions (excludes deviceName key). */
model DeviceResponse {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

// ──────────────────────────────────────────────
// Device operation models
// ──────────────────────────────────────────────

/** Request for looking up a device by its UUID. */
model GetDeviceByUuidRequest {
  /** The unique identifier of the device. */
  @query
  deviceUuid: string;
}

/** Request for looking up a device by its external identifier. */
model GetDeviceByExternalIdRequest {
  /** The external identifier of the device. */
  @query
  externalDeviceId: string;
}

/** Request body for querying devices in a namespace. */
model QueryDevicesRequest {
  /** The query expression to evaluate against devices in the namespace. */
  query: string;

  /** Maximum number of results to return in this page. */
  top?: int32;

  /** Opaque continuation token returned by a previous query response. */
  continuationToken?: string;
}

/** Response body for a device query: a page of projected results. */
model QueryDevicesResponse {
  /** The page of query results. Each element is a projected JSON document whose shape is determined by the query. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Query projections can return arbitrary shapes."
  value: Record<unknown>[];

  /** Continuation token for retrieving the next page of results. Present only when more results exist. */
  continuationToken?: string;
}

/** Device twin desired properties. */
model TwinProperties {
  /** The desired properties to set on the device twin. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Device twin desired properties require Record<unknown> to support arbitrary value types."
  desired?: Record<unknown>;
}

/** Initial device twin configuration to apply during provisioning. */
model DeviceTwin {
  /** Device twin tags. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Device twin tags require Record<unknown> to support arbitrary value types."
  tags?: Record<unknown>;

  /** The device twin properties. */
  properties?: TwinProperties;
}

/** Request body for the provision device endpoint. */
model ProvisionDeviceRequest {
  /** The device identity in IoT Hub. */
  iotHubDeviceId: string;

  /** The service endpoint identifier as returned by the GetNamespace API. */
  targetEndpoint: IotHubEndpoint;

  /** Operational authentication configuration. */
  authentication: AuthenticationProfileProperties;

  /** Initial device twin configuration to apply during provisioning. */
  deviceTwin?: DeviceTwin;
}

/** Result of a successful device provisioning operation. Returns nested references to the Device, Capability, and AuthenticationProfile resources written by the orchestration, plus the messaging endpoint the device was provisioned against. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model ProvisionDeviceResult {
  /** Reference to the provisioned Device resource. */
  device: ProvisionedDeviceRef;

  /** Reference to the provisioned Capability child resource. */
  capability: ProvisionedResourceRef;

  /** Reference to the provisioned AuthenticationProfile child resource. */
  authProfile: ProvisionedAuthProfileRef;

  /** Reference to the messaging endpoint the device was provisioned against. */
  endpoint: ProvisionedEndpointRef;
}

// ──────────────────────────────────────────────
// Devices interface
// ──────────────────────────────────────────────

/** Operations on devices within a namespace. */
@tag("Devices")
interface Devices {
  /** Look up a device by its unique identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getDeviceByUuid is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByUuidRequest,
    DeviceResponse
  >;

  /** Look up a device by its external identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getDeviceByExternalId is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByExternalIdRequest,
    DeviceResponse
  >;

  /** Query devices in a namespace using a query expression. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  query is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryDevicesRequest,
    QueryDevicesResponse
  >;

  /** Provision devices in a namespace. */
  @pollingOperation(Operations.get)
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  provision is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ProvisionDeviceRequest,
    ProvisionDeviceResult
  >;
}
