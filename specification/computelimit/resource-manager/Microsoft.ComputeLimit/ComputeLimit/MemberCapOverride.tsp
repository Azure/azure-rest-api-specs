import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./SharedLimitCap.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/**
 * Member cap override as a standalone child resource of `SharedLimitCap`.
 * Use this resource to read or modify a single member's cap without
 * resending the entire `memberCapOverrides` array on the parent.
 */
@added(Versions.v2026_07_01)
@parentResource(SharedLimitCap)
model MemberCapOverride is ProxyResource<MemberCapOverrideProperties> {
  ...ResourceNameParameter<
    Resource = MemberCapOverride,
    KeyName = "memberSubscriptionId",
    SegmentName = "memberCapOverrides",
    NamePattern = "^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$"
  >;
}

/** Properties of a per-member cap override. */
@added(Versions.v2026_07_01)
model MemberCapOverrideProperties {
  /** The cap value in count units for this member subscription. */
  @minValue(0)
  cap: int32;

  ...DefaultProvisioningStateProperty;
}

/** Operations for individual member cap overrides under a SharedLimitCap. */
@added(Versions.v2026_07_01)
@armResourceOperations
interface MemberCapOverrides {
  /** Gets the cap override configured for a single member subscription. */
  get is ArmResourceRead<MemberCapOverride>;

  /** Creates or replaces the cap override for a single member subscription. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MemberCapOverride>;

  /** Removes the per-member cap override for a member subscription. */
  delete is ArmResourceDeleteSync<MemberCapOverride>;

  /** Lists all per-member cap overrides configured under a SharedLimitCap. */
  listByParent is ArmResourceListByParent<MemberCapOverride>;
}
