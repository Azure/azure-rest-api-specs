import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PolicyGroup.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

namespace Microsoft.NetApp;

/**
 * Extended Snapshot Retention Policy resource.
 * Defines labeled snapshot retention rules (Hourly, Daily, Weekly, Monthly, Yearly) for volumes attached to an
 * extended snapshot retention policy. The data protection destination in volume replication references this
 * Extended Snapshot Retention Policy resource. Each rule sets how many snapshots to keep for that label. Managed under a
 * policy group (create, update, delete, list).
 */
@added(Versions.v2026_08_15_preview)
@parentResource(PolicyGroup)
model ExtendedSnapshotRetentionPolicy is Azure.ResourceManager.TrackedResource<
  ExtendedSnapshotRetentionPolicyProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = ExtendedSnapshotRetentionPolicy,
    KeyName = "extendedSnapshotRetentionPolicyName",
    SegmentName = "extendedSnapshotRetentionPolicies",
    NamePattern = "^[a-zA-Z0-9-]{1,63}"
  >;
}

/**
 * Extended Snapshot Retention Policy Properties
 */
@added(Versions.v2026_08_15_preview)
model ExtendedSnapshotRetentionPolicyProperties {
  /**
   * Extended Snapshot Retention Policy Rules
   */
  rules: ExtendedSnapshotRetentionPolicyRules;

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;
}

/**
 * Extended Snapshot Retention Policy Rules.
 * Rules for retaining labeled snapshots on volumes attached to an extended snapshot retention policy.
 * Each optional property is the rule for that label.
 */
@added(Versions.v2026_08_15_preview)
model ExtendedSnapshotRetentionPolicyRules {
  /**
   * Rule for keeping 'hourly' labeled snapshots.
   */
  hourly?: ExtendedSnapshotRetentionPolicyRule;

  /**
   * Rule for keeping 'daily' labeled snapshots.
   */
  daily?: ExtendedSnapshotRetentionPolicyRule;

  /**
   * Rule for keeping 'weekly' labeled snapshots.
   */
  weekly?: ExtendedSnapshotRetentionPolicyRule;

  /**
   * Rule for keeping 'monthly' labeled snapshots.
   */
  monthly?: ExtendedSnapshotRetentionPolicyRule;

  /**
   * Rule for keeping 'yearly' labeled snapshots.
   */
  yearly?: ExtendedSnapshotRetentionPolicyRule;
}

/**
 * Extended Snapshot Retention Policy Rule.
 * This model defines the rule for retaining snapshots with a specific label (Hourly, Daily, Weekly, Monthly, Yearly)
 * for volumes attached to an extended snapshot retention policy. `snapshotsToKeep` specifies how many snapshots to
 * retain for that label before older copies rotate out.
 */
@added(Versions.v2026_08_15_preview)
model ExtendedSnapshotRetentionPolicyRule {
  /**
   * How many snapshot copies are retained for this label on volumes attached to the linked Extended Snapshot Retention Policy
   * before older copies rotate out.
   */
  @minValue(1)
  snapshotsToKeep?: int32;
}

/**
 * Extended Snapshot Retention Policy Properties for patch
 */
@added(Versions.v2026_08_15_preview)
model ExtendedSnapshotRetentionPolicyPropertiesPatch {
  /**
   * Extended Snapshot Retention Policy Rules
   */
  rules?: ExtendedSnapshotRetentionPolicyRules;
}

/**
 * Volume resource IDs associated with an Extended Snapshot Retention Policy
 */
@added(Versions.v2026_08_15_preview)
model ExtendedSnapshotRetentionPolicyListVolumes is Azure.Core.Page<VolumeId>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ExtendedSnapshotRetentionPolicies {
  /**
   * Get the specified Extended Snapshot Retention Policy.
   */
  get is ArmResourceRead<ExtendedSnapshotRetentionPolicy>;

  /**
   * Create the specified Extended Snapshot Retention Policy.
   */
  create is ArmResourceCreateOrReplaceAsync<ExtendedSnapshotRetentionPolicy>;

  /**
   * Patch the specified Extended Snapshot Retention Policy.
   */
  update is ArmCustomPatchAsync<
    ExtendedSnapshotRetentionPolicy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ExtendedSnapshotRetentionPolicy,
      ExtendedSnapshotRetentionPolicyPropertiesPatch
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ExtendedSnapshotRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the specified Extended Snapshot Retention Policy.
   * Delete fails while the policy is still referenced by a volume replication that uses it.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExtendedSnapshotRetentionPolicy>;

  /**
   * List Extended Snapshot Retention Policies inside a Policy Group
   */
  listByPolicyGroup is ArmResourceListByParent<ExtendedSnapshotRetentionPolicy>;

  /**
   * List volume resource IDs associated with an Extended Snapshot Retention Policy
   */
  @list
  @action("listVolumes")
  listVolumes is ArmResourceActionSync<
    ExtendedSnapshotRetentionPolicy,
    void,
    ArmResponse<ExtendedSnapshotRetentionPolicyListVolumes>
  >;
}
