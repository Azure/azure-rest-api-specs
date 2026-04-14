import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device state resource
// ──────────────────────────────────────────────

/** Well-known device state names. */
union DeviceStateName {
  string,

  /** The default state of a device. */
  default: "default",

  /** The update state of a device. */
  update: "update",
}

/** A device state resource. */
@resource("states")
@parentResource(Device)
model DeviceState {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this state. */
  properties?: DeviceStateProperties;
}

@@key(DeviceState.name, "stateName");

/** Properties of a device state resource. */
model DeviceStateProperties {
  /** The desired state values. */
  desired?: Record<string>;

  /** The reported state values. */
  reported?: Record<string>;
}

// ──────────────────────────────────────────────
// Device states interface
// ──────────────────────────────────────────────

/** CRUD operations on device states. */
@tag("Device States")
interface DeviceStates {
  /** Create or replace a device state. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceState>;

  /** Get a device state. */
  get is ResourceOperations.ResourceRead<DeviceState>;

  /** Update a device state. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceState>;
}
