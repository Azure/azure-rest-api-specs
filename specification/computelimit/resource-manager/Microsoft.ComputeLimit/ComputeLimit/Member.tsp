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
 * Per-member cap as a standalone child resource of `SharedLimitCap`. Use this
 * resource to read or modify a single member's bounded cap without resending
 * the entire `members` array on the parent.
 */
@added(Versions.v2026_07_01)
@parentResource(SharedLimitCap)
model Member is ProxyResource<MemberProperties> {
  ...ResourceNameParameter<
    Resource = Member,
    KeyName = "memberSubscriptionId",
    SegmentName = "members",
    NamePattern = "^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$"
  >;
}

/** Properties of a per-member cap. */
@added(Versions.v2026_07_01)
model MemberProperties {
  /** The cap value in count units for this member subscription. */
  @minValue(0)
  boundedCap: int32;

  ...DefaultProvisioningStateProperty;
}

/** Operations for individual member caps under a SharedLimitCap. */
@added(Versions.v2026_07_01)
@armResourceOperations
interface Members {
  /** Gets the cap configured for a single member subscription. */
  get is ArmResourceRead<Member>;

  /** Creates or replaces the cap for a single member subscription. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Member>;

  /** Removes the per-member cap override for a member subscription. */
  delete is ArmResourceDeleteSync<Member>;

  /** Lists all per-member caps configured under a SharedLimitCap. */
  listByParent is ArmResourceListByParent<Member>;
}
