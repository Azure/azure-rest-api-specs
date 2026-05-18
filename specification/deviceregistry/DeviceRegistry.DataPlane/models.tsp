import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Base models for data plane resources
// ──────────────────────────────────────────────

/** Resource metadata properties (etag). */
model DataPlaneResourceBase {
  /** The name of the resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  /** The UUID of this capability resource. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** The type of the resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type: string;

  /** The entity tag for the resource. */
  @visibility(Lifecycle.Read)
  etag?: string;
}

// ──────────────────────────────────────────────
// Namespace resource (shared root)
// ──────────────────────────────────────────────

/** A device registry namespace. */
@resource("namespaces")
model Namespace {
  /** The unique identifier of the namespace. */
  @key("namespaceUuid")
  @visibility(Lifecycle.Read)
  namespaceUuid: string;
}
