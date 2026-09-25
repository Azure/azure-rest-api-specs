import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivilegedResourceFavorite.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PrivilegedAccess;

// =============================================================================
// privilegedResources collection (GET-only, tenant-scoped).
//
// The response shape (ResourceProjection in models.tsp) intentionally
// diverges from the standard Azure resource envelope: top-level
// projectionId / scope / displayName / type / location / tags /
// parentResource / roles / isFavorite, with no
// `properties` -> `provisioningState` style wrapping. This is by design — the
// contract is a server-side aggregation projection, not a stored Azure
// resource. The operation is therefore hand-authored here rather than
// expressed via the `Azure.ResourceManager` resource templates.
// =============================================================================

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "privilegedResources is a server-side projection collection — see comment above. The list operation is the only surface; no resource type lifecycle exists."
@tag("PrivilegedResources")
interface PrivilegedResources {
  /**
   * List the calling user's privileged Azure resources.
   *
   * Returns the resources you have privileged access to, evaluated with your
   * own permissions — only resources you are authorized to see are included.
   *
   * Pagination: server-driven via `maxpagesize` (advisory) + `nextLink`.
   * Clients follow `nextLink` verbatim — do not parse, mutate, or append
   * query parameters.
   */
  @route("/providers/Microsoft.Authorization/privilegedResources")
  @get
  @list
  list(
    ...ApiVersionParameter,

    /**
     * Controls whether the response is scoped to subscriptions the caller has
     * PIM assignments on, or expanded to all readable subscriptions. Allowed
     * values today: `pimOnly` (default — only subscriptions with PIM
     * assignments) and `allAccessible` (any subscription the caller can read).
     *
     * Modeled as an extensible string so future scope expansions can be
     * added without a breaking change; clients should tolerate unknown values.
     */
    @query
    accessScope?: AccessScopeFilter,

    /**
     * Advisory maximum page-size hint. The server may return fewer items than
     * `maxpagesize` and still include a `nextLink`. Server cap: 1000. Name
     * follows the standard Azure pagination convention (`maxpagesize`)
     * rather than the strict-maximum `$top` to signal the advisory semantics.
     */
    @query("maxpagesize")
    maxpagesize?: int32,

    /**
     * OData `$filter` expression that selects resource rows. Flat, lowercase
     * `and` expression only — `or`, `not`, and grouping are rejected.
     * Supported predicates:
     *
     *   - `type` — `eq` or `in`, e.g.
     *     `type eq 'microsoft.compute/virtualmachines'` or
     *     `type in ('microsoft.compute/virtualmachines','microsoft.desktopvirtualization/hostpools')`.
     *     Every value must be a supported primary resource type.
     *   - `scope` — `eq` or `in`, using exact, case-insensitive ARM-ID
     *     membership.
     *   - `subscriptionId` — `eq`, `ne`, or `in`. It is an exact resource GUID,
     *     so `contains` / `startswith` are rejected.
     *   - `subscriptionName` — `eq`, `ne`, `contains`, or `startswith`. The
     *     human-readable subscription display name (distinct from the
     *     `subscriptionId` GUID).
     *   - `resourceGroup` — `eq`, `ne`, `contains`, `startswith`, or `in`.
     *     Matches by name across every subscription the caller can see; because
     *     resource-group names are not globally unique, combine it with
     *     `subscriptionId` to disambiguate.
     *   - `tags.<key>` (dynamic) — `eq`, `ne`, `contains`, or `startswith`.
     *     A tag predicate addresses a single key with dotted syntax
     *     (e.g. `tags.environment eq 'prod'`); the whole remainder after
     *     `tags.` is the key, matched case-insensitively. An empty key
     *     (`tags.`) is rejected.
     *   - `displayName` and `location` — `eq`, `ne`, and function-form
     *     `startswith(field,'value')` / `contains(field,'value')`.
     *   - Favorite state: `isFavorite eq|ne true|false` — accepted and
     *     validated, but does not filter rows in this revision.
     *   - Role assignment status:
     *     `roles/any(r: r/assignmentStatus eq 'active'|'eligible')`.
     *
     * The `in` membership operator is limited to `type`, `scope`,
     * `subscriptionId`, and `resourceGroup`; all other fields accept only the
     * infix (`eq` / `ne`) and function (`contains` / `startswith`) forms.
     * `endswith` is not supported. Values inside one `in` clause are
     * OR-composed and matched case-insensitively; separate clauses remain
     * AND-composed.
     *
     * A role assignment status predicate selects resource rows that have at
     * least one matching role; it does not filter the contents of `roles`.
     * Every matching resource returns its complete roles collection.
     */
    @query("$filter")
    filter?: string,

    /**
     * Sort expression. Supported values: `displayName`, `displayName asc`, or
     * `displayName desc`. Ordering is applied to the complete filtered set
     * before pagination, with `scope` as the deterministic tie-breaker.
     * Invalid expressions return `400 InvalidOrderBy`.
     */
    @query("$orderby")
    orderby?: string,

    /**
     * When `true`, the response includes the full post-filter row count in the
     * optional `count` field — the cardinality of the complete filtered set
     * before the page slice. Absent or `false` omits `count`. Any other value
     * returns `400 InvalidCount`.
     */
    @query("$count")
    count?: boolean,
  ): ArmResponse<PagedResourceProjection> | ErrorResponse;

  /**
   * List the connect-enablement related resources for a privileged resource.
   *
   * Returns the resources you must additionally access to connect to the
   * privileged resource identified by `{privilegedResourceId}` — for example,
   * for a virtual machine: the NIC, NSG, public IP, and Bastion host.
   *
   * Each entry is itself a projection (`RelatedResourceProjection`): the related
   * resource's own `projectionId` and `scope`, plus the `roles` you hold
   * (active or eligible) on that related resource. Clients drive activation
   * against those roles to enable connect. Resource properties themselves are
   * NOT returned — read them directly from the Azure Resource Manager REST APIs
   * at Connect time.
   *
   * Returns an empty page when the privileged resource has no connect-enablement
   * dependencies.
   */
  @route("/providers/Microsoft.Authorization/privilegedResources/{privilegedResourceId}/relatedResources")
  @get
  @list
  listRelatedResources(
    ...ApiVersionParameter,

    /**
     * Opaque projection identifier of the parent privileged resource — the
     * `projectionId` returned by the `privilegedResources` list operation.
     * Clients MUST treat this as opaque — do not parse.
     */
    @path
    @pattern("^[A-Za-z0-9_-]{1,2048}$")
    privilegedResourceId: string,
  ): ArmResponse<Azure.Core.Page<RelatedResourceProjection>> | ErrorResponse;
}

// =============================================================================
// privilegedResourceFavorites — tenant-scoped proxy resource.
//
// Hand-authored routes to keep the surface predictable: idempotent PUT,
// idempotent DELETE, and per-caller scoping driven by the validated token
// rather than path parameters.
// =============================================================================

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom routes for tenant-scoped per-caller proxy resource — caller identity is taken from the validated token, not from a path parameter, so the standard `@armResourceOperations` interface doesn't fit."
@tag("PrivilegedResourceFavorites")
interface PrivilegedResourceFavorites {
  /**
   * List the calling user's favorites.
   *
   * The caller's principal id is taken from the validated user token, never
   * from the request. There is no API surface for one user to list another
   * user's favorites — favorites are partitioned per caller.
   */
  @route("/providers/Microsoft.Authorization/privilegedResourceFavorites")
  @get
  @list
  list(...ApiVersionParameter):
    | ArmResponse<Azure.Core.Page<PrivilegedResourceFavorite>>
    | ErrorResponse;

  /**
   * Get one of the calling user's favorites by id.
   *
   * Returns `404` if the calling user has not favorited this resource, even
   * if another user has.
   */
  @route("/providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * Favorite identifier — `base64url(lowercased Azure resource ID)`. Because
     * the derivation is deterministic, the client may compute it locally
     * from the resource id.
     */
    @path
    @pattern("^[A-Za-z0-9_-]{1,2048}$")
    favoriteId: string,
  ): ArmResponse<PrivilegedResourceFavorite> | ErrorResponse;

  /**
   * Add (or re-add) a favorite for the calling user.
   *
   * Idempotent: re-favoriting an already-favorited resource returns the
   * existing record with status `200 OK` rather than creating a duplicate;
   * a new favorite returns `201 Created`. The service validates that
   * `{favoriteId}` equals `base64url(lowercased(properties.resourceId))`
   * (`400 InvalidRequest` on mismatch) and that the caller has read
   * permission on the resource (`403 Forbidden` otherwise).
   */
  @route("/providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,

    /**
     * Favorite identifier — `base64url(lowercased Azure resource ID)`. Because
     * the derivation is deterministic, the client may compute it locally
     * from the resource id.
     */
    @path
    @pattern("^[A-Za-z0-9_-]{1,2048}$")
    favoriteId: string,

    /**
     * The favorite to create or update.
     */
    @bodyRoot
    resource: PrivilegedResourceFavorite,
  ):
    | ArmResponse<PrivilegedResourceFavorite>
    | ArmCreatedResponse<PrivilegedResourceFavorite, {}>
    | ErrorResponse;

  /**
   * Remove the calling user's favorite.
   *
   * Idempotent. Returns `200 OK` when an existing favorite was removed and
   * `204 No Content` when no matching favorite existed for the caller.
   */
  @route("/providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}")
  @delete
  delete(
    ...ApiVersionParameter,

    /**
     * Favorite identifier — `base64url(lowercased Azure resource ID)`. Because
     * the derivation is deterministic, the client may compute it locally
     * from the resource id.
     */
    @path
    @pattern("^[A-Za-z0-9_-]{1,2048}$")
    favoriteId: string,
  ): ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse;
}

// =============================================================================
// Extensible filter unions for the privilegedResources list operation.
// =============================================================================

/**
 * Controls how broadly the response is scoped across the caller's readable
 * subscriptions. Used by `PrivilegedResources.list#accessScope`.
 */
union AccessScopeFilter {
  string,

  /**
   * Scope the response to subscriptions the caller has PIM assignments on.
   */
  PimOnly: "pimOnly",

  /**
   * Expand the response to all subscriptions the caller can read.
   */
  AllAccessible: "allAccessible",
}
