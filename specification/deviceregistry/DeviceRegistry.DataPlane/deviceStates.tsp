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
}

/** A device state resource that is a device twin. */
@resource("states")
@parentResource(Device)
model DeviceState {
  ...OmitProperties<DataPlaneResourceBase, "name">;

  /** The name of the device state. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: DeviceStateName;

  /** The device twin properties. */
  properties: DeviceStateProperties;
}

@@key(DeviceState.name, "stateName");

/** Twin properties of a device state. */
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
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceState>;

  /** Get a device state. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  get is ResourceOperations.ResourceRead<DeviceState>;

  /** Update a device state. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceState>;

  /** List device states for a device. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  list is ResourceOperations.ResourceList<DeviceState>;
}
