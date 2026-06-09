import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/**
 * Shared limit cap configuration for a VM family, owned by a host subscription
 * and propagated to its member subscriptions. The same resource type is
 * readable by host and member subscriptions, but write operations (PUT/DELETE)
 * are scoped to the caller's subscription as the host.
 */
@added(Versions.v2026_07_01)
@subscriptionResource
model SharedLimitCap is ProxyResource<SharedLimitCapProperties> {
  ...ResourceNameParameter<
    Resource = SharedLimitCap,
    KeyName = "vmFamilyName",
    SegmentName = "sharedLimitCaps"
  >;
}

/** Properties of a shared limit cap resource. */
@added(Versions.v2026_07_01)
model SharedLimitCapProperties {
  /**
   * Baseline cap value (in count units) applied to member subscriptions that
   * do not have an explicit per-member cap. Uses the `OptionalInt32` wrapper
   * so PUT requests can distinguish three intents: omit the property to leave
   * the existing value unchanged, supply `{}` to clear it, or supply
   * `{ "value": N }` to set it to N. GET responses return the same wrapper
   * shape (`{ "value": N }` when configured, omitted when unset).
   */
  baselineCap?: OptionalInt32;

  /**
   * Whether the cap is enforced as a hard bound. When true the configured
   * caps are enforced; when false they are advisory only.
   */
  isBoundedCap?: boolean;

  /**
   * Per-member cap overrides. Returned on GET; omitted on list responses to
   * keep payloads small. On create/replace via PUT, supplying this array
   * replaces the full set of member caps; omit it to leave the existing set
   * unchanged. To edit a single member without sending the full list, use
   * the `Member` child resource.
   */
  @maxItems(1000)
  @identifiers(#["memberSubscriptionId"])
  members?: MemberCap[];

  ...DefaultProvisioningStateProperty;
}

/**
 * Per-member cap entry embedded inside `SharedLimitCap.properties.members[]`.
 * Each entry pairs a member subscription with its bounded cap value.
 */
@added(Versions.v2026_07_01)
model MemberCap {
  /** The member subscription identifier this cap applies to. */
  memberSubscriptionId: string;

  /** The cap value in count units for this member subscription. */
  @minValue(0)
  boundedCap: int32;
}

/**
 * Wrapper that lets callers distinguish three intents for an integer field:
 * omit the wrapper to leave the value unchanged, supply `{}` to clear it,
 * or supply `{ "value": N }` to set it to N. GET responses return the same
 * shape (`{ "value": N }` when configured, omitted when unset).
 */
@added(Versions.v2026_07_01)
model OptionalInt32 {
  /** The integer value. Omit to clear the field on the server. */
  @minValue(0)
  value?: int32;
}

/** Subscription-scoped operations for shared limit cap resources. */
@added(Versions.v2026_07_01)
@armResourceOperations
interface SharedLimitCaps {
  /** Gets the shared limit cap configuration for a VM family, as visible to the caller's subscription. */
  get is ArmResourceRead<SharedLimitCap>;

  /** Creates or updates the shared limit cap configuration for a VM family. The caller's subscription is treated as the host subscription. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SharedLimitCap>;

  /** Deletes the shared limit cap configuration for a VM family. The caller's subscription is treated as the host subscription. */
  delete is ArmResourceDeleteSync<SharedLimitCap>;

  /** Lists all shared limit cap configurations visible to the caller's subscription. */
  listBySubscription is ArmListBySubscriptionScope<SharedLimitCap>;
}
