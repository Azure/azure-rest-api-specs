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
// Device capability resource
// ──────────────────────────────────────────────

/** A device capability resource. */
@added(Versions.v2026_11_02_preview)
@resource("capabilities")
@parentResource(Device)
model DeviceCapability {
  /** The unique identifier of the capability. */
  @key("capabilityId")
  @visibility(Lifecycle.Read)
  capabilityId: string;

  // TODO: Add device capability fields
}

// ──────────────────────────────────────────────
// DeviceCapabilities interface
// ──────────────────────────────────────────────

/** CRUD operations on device capabilities. */
@added(Versions.v2026_11_02_preview)
@tag("Device Capabilities")
interface DeviceCapabilities {
  /** Create or replace a device capability. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceCapability>;

  /** Get a device capability. */
  get is ResourceOperations.ResourceRead<DeviceCapability>;

  /** Update a device capability. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceCapability>;

  /** Delete a device capability. */
  delete is ResourceOperations.ResourceDelete<DeviceCapability>;

  /** List capabilities for a device. */
  list is ResourceOperations.ResourceList<DeviceCapability>;
}
