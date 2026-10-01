import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/**
 * Shared limit cap configuration for a VM family, owned by a host subscription
 * and propagated to its member subscriptions. The same resource type is
 * readable by host and member subscriptions, but write operations (PUT/DELETE)
 * are scoped to the caller's subscription as the host.
 */
@added(Versions.v2026_07_01)
@parentResource(SubscriptionLocationResource)
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
   * The default member cap value (in count units).
   * Set to a non-negative integer to apply a cap to all member subscriptions
   * that do not have a per-member override. Omit the property to leave no
   * default cap in effect.
   */
  @minValue(0)
  defaultMemberCap?: int32;

  /**
   * Controls whether the service validates the aggregate cap against the
   * group limit for the VM family.
   *
   * SUM(caps) is the sum of all per-member overrides' cap values plus
   * `defaultMemberCap` multiplied by the number of member subscriptions without an override.
   *
   * When true, the service rejects any configuration where SUM(caps)
   * exceeds the group limit. When false, SUM(caps) is permitted to exceed
   * the group limit.
   *
   * Enabling this flag is rejected if the current configuration already breaches the group limit;
   * reduce caps first, then enable.
   */
  isBoundedCap: boolean;

  ...DefaultProvisioningStateProperty;
}

/**
 * Per-member cap override. Pairs a member subscription with its cap value.
 */
@added(Versions.v2026_07_01)
model MemberCap {
  /** The member subscription identifier this cap applies to. */
  @pattern("^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$")
  subscriptionId: string;

  /** The cap value in count units for this member subscription. */
  @minValue(0)
  cap: int32;
}

/** Request body for the `setMemberCapOverrides` action. */
@added(Versions.v2026_07_01)
model SetMemberCapOverridesRequest {
  /**
   * The full set of per-member cap overrides to persist for this resource.
   * This call replaces the existing set entirely; supply an empty array
   * (`[]`) to clear all overrides.
   */
  @identifiers(#["subscriptionId"])
  memberCapOverrides: MemberCap[];
}

/** Response body for the `setMemberCapOverrides` action. */
@added(Versions.v2026_07_01)
model SetMemberCapOverridesResult {
  /** The per-member cap overrides as persisted after the action completed. */
  @identifiers(#["subscriptionId"])
  memberCapOverrides: MemberCap[];
}

/** Operations for shared limit cap resources. */
@added(Versions.v2026_07_01)
@armResourceOperations
interface SharedLimitCaps {
  /** Gets the shared limit cap configuration for a VM family, as visible to the caller's subscription. */
  get is ArmResourceRead<SharedLimitCap>;

  /**
   * Creates or replaces the shared limit cap configuration for a VM family.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SharedLimitCap>;

  /** Deletes the shared limit cap configuration for a VM family. The caller's subscription is treated as the host subscription. */
  delete is ArmResourceDeleteSync<SharedLimitCap>;

  /** Lists all shared limit cap configurations visible to the caller's subscription. */
  list is ArmResourceListAtScope<SharedLimitCap>;

  /**
   * Replaces the full set of per-member cap overrides for this shared limit
   * cap. The supplied array becomes the new complete set of overrides;
   * supplying an empty array clears all existing overrides.
   */
  setMemberCapOverrides is ArmResourceActionSync<
    SharedLimitCap,
    SetMemberCapOverridesRequest,
    SetMemberCapOverridesResult
  >;
}
