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
@added(Versions.v2026_11_02_preview)
union DeviceStateName {
  string,

  /** The default state of a device. */
  default: "default",

  /** The update state of a device. */
  update: "update",
}

/** A device state resource. */
@added(Versions.v2026_11_02_preview)
@resource("states")
@parentResource(Device)
model DeviceState {
  /** The name of the state. Must be a well-known value ("default" or "update"). */
  @key("stateName")
  @visibility(Lifecycle.Read)
  stateName: DeviceStateName;

  // TODO: Add state fields
}

// ──────────────────────────────────────────────
// Device states interface
// ──────────────────────────────────────────────

/** CRUD operations on device states. */
@added(Versions.v2026_11_02_preview)
@tag("Device States")
interface DeviceStates {
  /** Create or replace a device state. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceState>;

  /** Get a device state. */
  get is ResourceOperations.ResourceRead<DeviceState>;

  /** Update a device state. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceState>;
}
