import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/**
 * Shared limit cap configuration for a VM family, owned by a host subscription
 * and propagated to participating guest subscriptions. The same resource type
 * is readable by host and guest subscriptions, but write operations (PUT/DELETE)
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

/** Default cap configuration applied to subscriptions participating in the shared limit. */
@added(Versions.v2026_07_01)
model DefaultCap {
  /** The default cap value in count units. A numeric value sets the default cap; null sets the default cap to unlimited. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Tri-state semantics on the request: a numeric value sets the default cap, an explicit null sets the default cap to unlimited, and omitting the parent DefaultCap object leaves the configuration unchanged. Optionality alone cannot express the 'set to unlimited' intent distinctly from 'no change'."
  value: int32 | null;
}

/** Guaranteed cap configuration for the host subscription. */
@added(Versions.v2026_07_01)
model GuaranteedCap {
  /** Whether the host subscription has a guaranteed cap reserved out of the shared limit. */
  value: boolean;
}

/** Per-subscription cap override for a single guest subscription participating in the shared limit. */
@added(Versions.v2026_07_01)
model IndividualSubscriptionCap {
  /** The guest subscription identifier this cap applies to. */
  subscriptionId: string;

  /** The cap value in count units for this guest subscription. A numeric value sets the cap; null explicitly clears any previously configured cap for this subscription. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Tri-state per-subscription semantics on the request: an entry whose 'cap' is a number sets that subscription's cap, an entry whose 'cap' is explicitly null clears that subscription's cap, and a subscription absent from the array entirely is left unchanged. The 'explicit clear' intent is distinct from 'no change' and cannot be expressed with optionality alone."
  cap: int32 | null;
}

/** Properties of a shared limit cap resource. */
@added(Versions.v2026_07_01)
model SharedLimitCapProperties {
  /** The host subscription that owns this shared limit cap configuration. */
  @visibility(Lifecycle.Read)
  hostSubscriptionId?: string;

  /** The cap configured for the caller's subscription, in count units. */
  @visibility(Lifecycle.Read)
  subscriptionCap?: int32;

  /** The current usage in the caller's subscription, in count units. */
  @visibility(Lifecycle.Read)
  subscriptionUsage?: int32;

  /** The total shared limit across all subscriptions participating in this cap, in count units. */
  @visibility(Lifecycle.Read)
  sharedLimit?: int32;

  /** The default cap configuration applied to participating subscriptions. Omitting the property leaves the existing default configuration unchanged. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  defaultCap?: DefaultCap;

  /** The guaranteed cap configuration for the host subscription. Omitting the property leaves the existing guaranteed configuration unchanged. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  guaranteedCap?: GuaranteedCap;

  /** Per-subscription cap overrides for guest subscriptions. A subscription absent from the array is left unchanged; an entry with a numeric 'cap' sets the cap; an entry with an explicit null 'cap' clears the cap. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @identifiers(#["subscriptionId"])
  individualSubscriptionCaps?: IndividualSubscriptionCap[];

  ...DefaultProvisioningStateProperty;
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
