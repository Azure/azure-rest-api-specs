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

  /** Globally unique, immutable, non-reusable identifier of the resource. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** The type of the resource. */
  @visibility(Lifecycle.Read)
  type: string;

  /** The entity tag for the resource. */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/** The provisioning state of a data-plane resource. */
union ProvisioningState {
  string,

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** Resource has been accepted by the server. */
  Accepted: "Accepted",

  /** Resource is being deleted. */
  Deleting: "Deleting",
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
