import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Group resource
// ──────────────────────────────────────────────

/** A group resource. */
@resource("groups")
@parentResource(Namespace)
model Group {
  /** The unique identifier of the group. */
  @key("groupUuid")
  @visibility(Lifecycle.Read)
  groupUuid: string;

  // TODO: Add group fields
}

// ──────────────────────────────────────────────
// Group operation models
// ──────────────────────────────────────────────

/** Request body for looking up a group by its UUID. */
model GetGroupByUuidRequest {
  /** The unique identifier of the group. */
  groupUuid: string;
}

// ──────────────────────────────────────────────
// Groups interface
// ──────────────────────────────────────────────

/** Operations on groups within a namespace. */
@tag("Groups")
interface Groups {
  /** Look up a group by its unique identifier. */
  getGroupByUuid is ResourceOperations.ResourceCollectionAction<
    Group,
    GetGroupByUuidRequest,
    Group
  >;
}
