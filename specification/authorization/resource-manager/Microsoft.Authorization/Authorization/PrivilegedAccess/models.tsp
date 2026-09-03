import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PrivilegedAccess;

// =============================================================================
// Errors — operations return the standard `Azure.ResourceManager.ErrorResponse`
// from common-types v6 (wired in main.tsp). No custom error envelope is
// defined here; this keeps the error contract consistent across the entire
// Microsoft.Authorization PrivilegedAccess surface (including
// `Microsoft.Authorization/operations`).
// =============================================================================

// =============================================================================
// Resource projection types — the response shape for
// `GET /providers/Microsoft.Authorization/privilegedResources`.
//
// The projection deliberately does NOT return the upstream resource's
// properties — the client reads those directly from Azure Resource Manager
// REST APIs at Connect time using delegated permissions; instead the
// projection carries the addressing and entitlement facts (scopes, roles,
// names, Azure Resource Manager resource IDs, active/eligible state). The
// connect-enablement dependencies are served separately by
// `GET .../privilegedResources/{privilegedResourceId}/relatedResources`.
//
// The list operation's paged response is the named `PagedResourceProjection`
// wrapper (defined after `ResourceProjection` below). It spreads the standard
// `Azure.Core.Page<ResourceProjection>` shape (`value` + `nextLink`) and adds
// the optional `count` field returned when the request sets `$count=true`.
// The autorest emitter already named the inline `Azure.Core.Page` envelope
// `PagedResourceProjection`, so the existing LintDiff suppression in
// `readme.md` (RequiredPropertiesMissingInResourceModel) continues to apply.
// =============================================================================

/**
 * A privileged resource projection — a unified view of an Azure resource the
 * caller has privileged access to, with all role information flattened onto the
 * row. Connect-enablement dependencies are retrieved separately via
 * `GET .../privilegedResources/{privilegedResourceId}/relatedResources`.
 *
 * The Azure resource-type namespace (`type`, e.g.
 * `microsoft.compute/virtualmachines`) is the discriminator — new resource
 * types are non-breaking additions and clients SHOULD tolerate unknown
 * values.
 */
model ResourceProjection {
  /**
   * Opaque server-generated identifier for this projection row. Stable per
   * (caller, resource) pair. Clients MUST treat this as opaque — do not parse.
   *
   * Distinct from the conventional Azure resource `id`: the full Azure
   * resource path lives on `scope` below.
   */
  @visibility(Lifecycle.Read)
  projectionId: string;

  /**
   * Fully-qualified Azure resource path (e.g.,
   * `/subscriptions/{subId}/resourceGroups/my-rg/providers/Microsoft.Compute/virtualMachines/my-vm`).
   *
   * In the privileged-access model every resource is also a scope at which
   * role assignments can be granted, so this field uses the ARM-standard
   * `scope` name rather than `resourceId`.
   */
  scope: armResourceIdentifier;

  /**
   * Human-readable resource name.
   */
  displayName: string;

  /**
   * Azure resource provider type (lowercased), e.g.
   * `microsoft.compute/virtualmachines`. This is the ARM-standard `type`
   * field and also serves as the resource-kind discriminator — new resource
   * types are non-breaking additions.
   */
  type: string;

  /**
   * Azure region (e.g. `eastus`).
   */
  location: string;

  /**
   * Azure resource tags, mirrored verbatim from the upstream Azure resource.
   * Free-form user-defined key/value pairs, not validated — identical semantics
   * to standard Azure Resource Manager `TrackedResource.tags`.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Pass-through user-defined data: tags are mirrored verbatim from the upstream Azure resource with no service-side validation, matching the open key/value bag of the standard Azure Resource Manager TrackedResource template."
  tags: Record<string>;

  /**
   * Scope ancestor chain — innermost (resource group) first, outermost
   * (subscription, future management group) at the chain's tail. Navigation
   * only; carries no access information.
   *
   * Inheritance of role assignments is recorded directly on each entry of
   * `roles` (each role's `scope` field), not by walking this chain. Clients
   * do not need to walk `parentResource` to discover inherited roles.
   */
  parentResource: ParentResource;

  /**
   * Every role granting access to this resource — direct or inherited from
   * any ancestor scope, and direct or via group membership (active or eligible).
   * Each entry's `scope` field records the actual assignment scope.
   *
   * Inherited and group-sourced roles are already included and fully resolved
   * here: clients do NOT need to walk `parentResource` or resolve group
   * membership themselves.
   */
  @identifiers(#["roleId"])
  roles: RoleAssignmentSummary[];

  /**
   * Whether you have favorited this resource (see
   * `privilegedResourceFavorites`). Always populated on every row.
   */
  isFavorite: boolean;
}

/**
 * Paging envelope for the `privilegedResources` list operation.
 *
 * Spreads the standard `Azure.Core.Page<ResourceProjection>` shape (`value` +
 * `nextLink`) and adds the optional `count` field. The envelope itself is not
 * an ARM resource — the ARM resource invariants are enforced on the page's
 * items (`ResourceProjection`), not on the wrapper.
 */
model PagedResourceProjection {
  ...Azure.Core.Page<ResourceProjection>;

  /**
   * Full post-filter row count — the cardinality of the complete filtered set
   * before the page slice. Present only when the request sets `$count=true`;
   * omitted otherwise.
   */
  count?: int32;
}

// =============================================================================
// RelatedResourceProjection — one connect-enablement resource for a privileged
// resource, returned by
// `GET .../privilegedResources/{privilegedResourceId}/relatedResources`.
//
// Each entry is itself a projection: the related resource's own stable
// `projectionId`, its Azure Resource Manager `scope`, and the flattened `roles`
// the caller holds (active or eligible) on that related resource. This mirrors
// the shape of `ResourceProjection` (minus the metadata fields) so a client can
// drive the same activation flow against a connect-enablement resource — e.g.
// for a virtual machine, the NIC, NSG, public IP, or Bastion host.
//
// Resource properties themselves are NOT returned — the client reads them
// directly from Azure Resource Manager REST APIs at Connect time using the
// caller's delegated permissions.
// =============================================================================

/**
 * A connect-enablement resource for a privileged resource — an Azure resource
 * the caller must be able to access to connect to the primary resource (for a
 * virtual machine, typically the NIC, NSG, public IP, or Bastion host),
 * projected with its own scope and the roles the caller holds on it.
 */
model RelatedResourceProjection {
  /**
   * Opaque server-generated identifier for this related-resource projection.
   * Stable per (caller, related resource) pair. Clients MUST treat this as
   * opaque — do not parse.
   */
  @visibility(Lifecycle.Read)
  projectionId: string;

  /**
   * Fully-qualified Azure resource path of the related (connect-enablement)
   * resource — e.g. the virtual machine's NIC, NSG, public IP, or Bastion host.
   *
   * As with `ResourceProjection.scope`, every resource is also a scope at which
   * role assignments can be granted, so this field uses the ARM-standard
   * `scope` name.
   */
  scope: armResourceIdentifier;

  /**
   * Every role granting the caller access to this related resource — direct or
   * inherited, direct-source or group-source, active or eligible. Each entry's
   * `scope` field records the actual assignment scope. The caller activates the
   * appropriate role here to enable connect to the primary resource.
   */
  @identifiers(#["roleId"])
  roles: RoleAssignmentSummary[];
}

// =============================================================================
// ParentResource — recursive scope ancestor chain.
//
// Generic shape — same extensibility model as the open metadata bags elsewhere
// in this contract: `type` is a free-form classification tag (NOT a strict
// schema discriminator); scope-tier-specific metadata lives inside the open
// `properties` bag. New scope tiers (`managementGroup`, `tenant`, future
// sub-resource hierarchies) extend `properties` with their own field set
// without a contract break.
// =============================================================================

/**
 * Scope ancestor entry. Navigation only — carries no access information.
 *
 * Generic shape: `type` classifies the scope tier; scope-type-specific metadata
 * lives inside the open `properties` bag and is mirrored from the upstream
 * scope without validation. Recursive: each entry has its own
 * `parentResource` pointing at the next scope up. Present on every entry
 * except the outermost (root) scope.
 */
model ParentResource {
  /**
   * Scope tier classification. Allowed values today: `resourceGroup`,
   * `subscription`. Future tiers (e.g., `managementGroup`, `tenant`, future
   * sub-resource hierarchies) are non-breaking additions — the `properties`
   * bag carries their per-type metadata.
   */
  type: ScopeKind;

  /**
   * Scope identifier for the parent scope. For Azure Resource Manager-addressable
   * scopes this is the full Azure Resource Manager resource path (e.g.,
   * `/subscriptions/{subId}/resourceGroups/my-rg`). Typed as `string` (not
   * `armResourceIdentifier`) because higher scope tiers — management groups,
   * tenants, and future non–Azure Resource Manager hierarchies — do not have
   * Azure Resource Manager resource identifiers. Format is determined by the
   * sibling `type` value.
   */
  scope: string;

  /**
   * Human-readable scope name. For subscriptions, may be the subscription id
   * when a display name is unavailable.
   */
  displayName: string;

  /**
   * Scope-type-specific metadata bag, mirrored from the upstream Azure scope
   * for the given `type`, without validation. The set of fields inside is
   * determined by the sibling `type` value. Always emitted (possibly empty
   * `{}`) so clients can safely read it. Intentionally untyped at the API
   * contract layer so new scope tiers (`managementGroup`, `tenant`, future
   * sub-resource hierarchies) can be added without a contract break.
   *
   * Examples today (informative, not enforced by schema):
   *
   *   - `type = "resourceGroup"`: `{}` (no scope-specific metadata in v1).
   *   - `type = "subscription"`:  `{ managementGroupPath: string[] }`
   *     (ordered root-to-direct-parent).
   *
   * Clients SHOULD treat the bag as opaque unless they know the `type`.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Pass-through user-defined data: same extensibility model as the open metadata bags elsewhere in this contract. Mirrors fields from the upstream Azure scope without service-side validation. Intentionally untyped at the schema layer so new scope tiers (managementGroup, tenant, future sub-resource hierarchies) can be added server-side without an API contract break or SDK regeneration."
  properties: Record<unknown>;

  /**
   * The next ancestor in the chain. Present on every entry except the
   * outermost (root) scope, which omits the field.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Renamed to `parent` for C# in client.tsp (@@clientName) to avoid the enclosing-model name collision; spec name stays `parentResource` for all other languages."
  parentResource?: ParentResource;
}

/**
 * Scope-tier classification for `ParentResource`. Extensible union — `type`
 * is a classification tag (NOT a strict schema discriminator); per-type
 * metadata lives in the `properties` bag.
 */
union ScopeKind {
  string,

  /**
   * Azure resource group.
   */
  ResourceGroup: "resourceGroup",

  /**
   * Azure subscription.
   */
  Subscription: "subscription",
}

// =============================================================================
// RoleAssignmentSummary — flat per-role entry on each resource row.
// =============================================================================

/**
 * A single role grant on the resource. Roles for a row are flattened: direct
 * and inherited assignments, direct-source and group-source assignments
 * (whether active or eligible), all appear as separate entries with their
 * actual assignment scope recorded in `scope`. The same role at the same
 * scope from the same source MUST NOT appear twice on the same row.
 */
model RoleAssignmentSummary {
  /**
   * Opaque, stable identifier for this role grant. Stable per assignment, so it
   * is safe to use as a client-side collection key. Clients MUST treat this as
   * opaque — do not parse.
   */
  roleId: string;

  /**
   * The identifier of the parent role, if this role has a parent.
   */
  parentRoleId?: string;

  /**
   * Azure role definition id (full path).
   */
  roleDefinitionId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/roleDefinitions";
    }
  ]>;

  /**
   * Human-readable display name of the role definition (e.g.
   * `Network Contributor`). Provided as a convenience so clients can render the
   * role without a separate lookup on `roleDefinitionId`.
   */
  roleDisplayName: string;

  /**
   * Azure scope path where the assignment is granted (resource, resource
   * group, subscription, or future management-group id). Inheritance is
   * implicit: if `scope` differs from the row's `scope` (the resource's
   * own path), the role is inherited.
   */
  scope: armResourceIdentifier;

  /**
   * The caller's current status against this role on this resource:
   *
   *   - `active`   — the user effectively has this role active right now.
   *   - `eligible` — the user can activate this role (one-step or two-step
   *                  activation, depending on `source.membershipState`).
   *
   * Modeled as an extensible string so future statuses (e.g. additional
   * lifecycle states) can be added without a breaking change; clients should
   * tolerate unknown values.
   */
  assignmentStatus: AssignmentStatus;

  /**
   * Schedule (start time and expiration) backing this role grant. Populated for
   * both `active` and `eligible` entries. A permanent (no-expiry) assignment is
   * represented by `expiration.type` = `NoExpiration`; a time-bound assignment
   * by `AfterDuration` (with `duration`) or `AfterDateTime` (with `endDateTime`).
   */
  scheduleInfo: ScheduleInfo;

  /**
   * Origin of the role grant — direct user assignment or via group membership.
   */
  source: RoleSource;

  /**
   * Whether this role is a least-privilege role for the resource. A value of
   * `true` indicates the role grants the minimum permissions needed and is the
   * recommended choice; `false` indicates a broader-privilege role. Provided as
   * a recommendation so clients can guide users toward the least-privilege
   * option.
   */
  isLeastPrivilege: boolean;
}

/**
 * Origin of a role grant. Discriminated by `memberType`.
 */
@discriminator("memberType")
model RoleSource {
  /**
   * Membership type: `direct` (direct user assignment) or `group` (granted via
   * a group the user is a member of).
   */
  memberType: MemberType;
}

/**
 * Membership type of a role grant. Extensible union — clients SHOULD treat
 * unknown values as "unsupported membership type".
 */
union MemberType {
  string,

  /**
   * Direct user assignment.
   */
  Direct: "direct",

  /**
   * Role granted via a group the user is a member of.
   */
  Group: "group",
}

/**
 * Direct user role assignment.
 */
model DirectRoleSource extends RoleSource {
  /**
   * Discriminator value for direct user assignments.
   */
  memberType: "direct";
}

/**
 * Group-sourced role assignment. The role is granted via `group`;
 * the user's membership state in that group is recorded in `membershipState`.
 */
model GroupRoleSource extends RoleSource {
  /**
   * Discriminator value for group-sourced assignments.
   */
  memberType: "group";

  /**
   * The group through which this role is granted.
   */
  group: GroupReference;

  /**
   * The user's membership state in the group. Drives client activation routing:
   *
   *   - `active`   → one-step (activate the role).
   *   - `eligible` → two-step (activate your group membership first, then
   *                  activate the role).
   */
  membershipState: GroupMembershipState;
}

/**
 * A reference to a Microsoft Entra ID group through which a role is granted.
 */
model GroupReference {
  /**
   * Microsoft Entra ID object id of the group.
   */
  id: string;

  /**
   * Group display name.
   */
  displayName: string;
}

/**
 * User membership state in a group, used to discriminate one-step vs two-step
 * activation flows for group-sourced roles.
 */
union GroupMembershipState {
  string,

  /**
   * The user is an active member of the group.
   */
  Active: "active",

  /**
   * The user is an eligible member of the group — group membership must be
   * activated first before the inherited role can be activated.
   */
  Eligible: "eligible",
}

/**
 * Status of a role assignment from the caller's perspective. Used by
 * `RoleAssignmentSummary.assignmentStatus` and by role status predicates in
 * the `PrivilegedResources.list` `$filter` expression.
 *
 * Extensible string union — additional statuses can be added without a
 * breaking change; clients should tolerate unknown values.
 */
union AssignmentStatus {
  string,

  /**
   * The user effectively has this role active right now.
   */
  Active: "active",

  /**
   * The user can activate this role (one-step or two-step activation,
   * depending on the source's membership state).
   */
  Eligible: "eligible",
}

/**
 * Schedule info backing a role grant — start time and expiration.
 */
model ScheduleInfo {
  /**
   * Start DateTime of the schedule.
   */
  startDateTime?: utcDateTime;

  /**
   * Expiration of the schedule. Absent implies no expiration is expressed.
   */
  expiration?: ScheduleExpiration;
}

/**
 * Expiration of a role grant schedule.
 */
model ScheduleExpiration {
  /**
   * Type of expiration: `AfterDuration` (time-bound by `duration`),
   * `AfterDateTime` (time-bound by `endDateTime`), or `NoExpiration`
   * (permanent).
   */
  type?: ScheduleExpirationType;

  /**
   * End DateTime of the schedule. Set when `type` is `AfterDateTime`.
   */
  endDateTime?: utcDateTime;

  /**
   * Duration of the schedule as an ISO-8601 TimeSpan. Set when `type` is
   * `AfterDuration`.
   */
  duration?: duration;
}

/**
 * Expiration kind of a role grant schedule. Extensible string union.
 */
union ScheduleExpirationType {
  string,

  /**
   * Time-bound assignment expiring after a duration — `duration` is set.
   */
  AfterDuration: "AfterDuration",

  /**
   * Time-bound assignment expiring at an explicit end date — `endDateTime` is
   * set.
   */
  AfterDateTime: "AfterDateTime",

  /**
   * Permanent assignment — no expiry.
   */
  NoExpiration: "NoExpiration",
}

// =============================================================================
// Privileged Resource Favorites — resource type properties.
// =============================================================================

/**
 * Properties of a `PrivilegedResourceFavorite`. The favorite's identity
 * (`favoriteId` / `name`) is the URL-segment derivation of `resourceId`:
 * `favoriteId = base64url(lowercased Azure resource ID)`.
 *
 * Favorites are created synchronously — a successful PUT or DELETE takes effect
 * immediately, with no long-running operation to poll.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Favorites are synchronous proxy resources (no LRO, no polling). Per the Azure Resource Manager Resource Provider Contract, provisioningState is required only on tracked and async proxy resources; it is OPTIONAL on sync proxy resources. Including it would emit a misleading async-flavored field on a synchronous PUT/DELETE surface."
model PrivilegedResourceFavoriteProperties {
  /**
   * The favorited Azure resource id. The `favoriteId` URL segment MUST equal
   * `base64url(lowercased(resourceId))`; the service rejects mismatches with
   * `400 InvalidRequest` on PUT.
   *
   * Effectively immutable: set on create and never changed afterward — there is
   * no PATCH, and PUT validates the `favoriteId`-from-`resourceId` derivation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId: armResourceIdentifier;
}
