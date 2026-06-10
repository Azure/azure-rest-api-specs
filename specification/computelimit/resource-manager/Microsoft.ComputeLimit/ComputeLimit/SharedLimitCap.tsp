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
  /** The Default member cap value (in count units) */
  defaultMemberCap?: OptionalInt32;

  /**
   * Controls whether the service validates the aggregate cap against the
   * group limit for the VM family.
   *
   * SUM(caps) is the sum of all `memberCapOverrides[].cap` values plus
   * `defaultMemberCap` multiplied by the number of member subscriptions without an override.
   *
   * When true, the service rejects any configuration where SUM(caps)
   * exceeds the group limit. When false, SUM(caps) is permitted to exceed
   * the group limit.
   *
   * Enabling this flag is rejected if the current configuration already breaches the group limit;
   * reduce caps first, then enable.
   */
  isBoundedCap?: boolean;

  /** The member cap overrides. */
  @maxItems(1000)
  @identifiers(#["subscriptionId"])
  memberCapOverrides?: MemberCap[];

  ...DefaultProvisioningStateProperty;
}

/**
 * Per-member cap override embedded inside
 * `SharedLimitCap.properties.memberCapOverrides[]`. Each entry pairs a member
 * subscription with its cap value.
 */
@added(Versions.v2026_07_01)
model MemberCap {
  /** The member subscription identifier this cap applies to. */
  subscriptionId: string;

  /** The cap value in count units for this member subscription. */
  @minValue(0)
  cap: int32;
}

/**
 * Wrapper that lets callers distinguish three intents for an integer field:
 * omit the wrapper to leave the value unchanged,
 * supply `{}` to clear it,
 * or supply `{ "value": N }` to set it to N.
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

  /**
   * Creates or updates the shared limit cap configuration.
   * Note: this PUT uses merge semantics, not the standard ARM replace semantics.
   * Properties omitted from the request body are left unchanged on the server.
   *  To clear a value, supply the explicit clear shape (e.g. `defaultMemberCap: {}`
   * or `memberCapOverrides: []`).
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SharedLimitCap>;

  /** Deletes the shared limit cap configuration for a VM family. The caller's subscription is treated as the host subscription. */
  delete is ArmResourceDeleteSync<SharedLimitCap>;

  /** Lists all shared limit cap configurations visible to the caller's subscription. */
  listBySubscription is ArmListBySubscriptionScope<SharedLimitCap>;
}
