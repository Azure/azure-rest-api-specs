import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Base models for data plane resources
// ──────────────────────────────────────────────

/** Resource metadata properties (etag and systemData). */
model ResourceMetadata {
  /** The entity tag for the resource. */
  etag?: string;

  /** Metadata containing createdBy and modifiedBy information. */
  systemData?: SystemData;
}

/** Common properties shared by all data plane resources. */
model DataPlaneResourceBase {
  ...ResourceMetadata;
}

/** Metadata pertaining to creation and last modification of the resource. */
model SystemData {
  /** The identity that created the resource. */
  createdBy?: string;

  /** The type of identity that created the resource. */
  createdByType?: string;

  /** The timestamp of resource creation (UTC). */
  createdAt?: utcDateTime;

  /** The identity that last modified the resource. */
  lastModifiedBy?: string;

  /** The type of identity that last modified the resource. */
  lastModifiedByType?: string;

  /** The timestamp of resource last modification (UTC). */
  lastModifiedAt?: utcDateTime;
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
