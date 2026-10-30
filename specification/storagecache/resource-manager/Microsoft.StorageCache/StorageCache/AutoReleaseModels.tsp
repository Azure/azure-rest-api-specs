import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.StorageCache;

/** Result of a request to list AutoRelease jobs. */
@added(Versions.v2027_01_01)
model AutoReleaseJobsListResult {
  /** The AutoRelease jobs. */
  @pageItems
  value?: AutoReleaseJob[];

  /** URL to retrieve the next page of results, if available. */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/** Azure Resource Manager provisioning state for an AutoRelease job. */
@added(Versions.v2027_01_01)
@Azure.Core.lroStatus
union AutoReleaseJobProvisioningState {
  /** Terminal provisioning states shared by ARM resources. */
  Azure.ResourceManager.ResourceProvisioningState,

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

/** Administrative status requested for an AutoRelease job. */
@added(Versions.v2027_01_01)
union AutoReleaseJobAdminStatus {
  string,

  /** Enables AutoRelease. */
  Enable: "Enable",

  /** Disables AutoRelease while retaining the resource. */
  Disable: "Disable",
}

/** Operational state of an AutoRelease job. */
@added(Versions.v2027_01_01)
union AutoReleaseJobState {
  string,

  /** AutoRelease is disabled. */
  Disabled: "Disabled",

  /** AutoRelease is enabled and idle. */
  Enabled: "Enabled",

  /** AutoRelease is running a release pass. */
  InProgress: "InProgress",
}

/** Scheduling state of an AutoRelease policy. */
@added(Versions.v2027_01_01)
union AutoReleasePolicyState {
  string,

  /** The policy is waiting for its start trigger. */
  Waiting: "Waiting",

  /** The policy is ready to run. */
  Ready: "Ready",

  /** The policy is running. */
  Running: "Running",

  /** The policy was skipped. */
  Skipped: "Skipped",

  /** The one-time policy completed. */
  Done: "Done",
}

/** AutoRelease trigger kinds. */
@added(Versions.v2027_01_01)
union AutoReleaseTriggerType {
  string,

  /** Starts when capacity is above a percentage. */
  CapacityPercentAbove: "CapacityPercentAbove",

  /** Stops when capacity is below a percentage. */
  CapacityPercentBelow: "CapacityPercentBelow",

  /** Triggers at times selected by a UTC five-field cron expression. */
  CronTime: "CronTime",

  /** Triggers immediately. */
  Immediate: "Immediate",

  /** Triggers once at a UTC timestamp. */
  OnceAt: "OnceAt",

  /** Stops after the specified amount of data has been released. */
  ReleasedSizeAbove: "ReleasedSizeAbove",
}

/** AutoRelease filter inclusion mode. */
@added(Versions.v2027_01_01)
union AutoReleaseFilterMode {
  string,

  /** Includes matching files. */
  Include: "Include",

  /** Excludes matching files. */
  Exclude: "Exclude",
}

/** AutoRelease filter kinds. */
@added(Versions.v2027_01_01)
union AutoReleaseFilterType {
  string,

  /** Matches file-name suffixes. */
  Suffix: "Suffix",

  /** Matches files larger than a formatted size. */
  SizeAbove: "SizeAbove",

  /** Matches files whose last access is older than a formatted duration. */
  LastAccessOlderThan: "LastAccessOlderThan",

  /** Matches files whose last change is older than a formatted duration. */
  LastChangeOlderThan: "LastChangeOlderThan",

  /** Matches files whose last restore is older than a formatted duration. */
  LastRestoreOlderThan: "LastRestoreOlderThan",
}

/** A file-name suffix used by an AutoRelease filter. */
@added(Versions.v2027_01_01)
@maxLength(255)
scalar AutoReleaseSuffix extends string;

/** A size represented by an integer followed by B, K, M, G, T, or P. */
@added(Versions.v2027_01_01)
@pattern("^[0-9]+[BKMGTP]$")
scalar AutoReleaseSize extends string;

/** A trigger that starts or stops an AutoRelease policy. */
@added(Versions.v2027_01_01)
@discriminator("type")
model AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType;
}

/** Starts a policy when capacity is above the specified percentage. */
@added(Versions.v2027_01_01)
model CapacityPercentAboveTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.CapacityPercentAbove;

  /** Capacity percentage from 0 through 99. */
  @minValue(0)
  @maxValue(99)
  value: int32;
}

/** Stops a policy when capacity is below the specified percentage. */
@added(Versions.v2027_01_01)
model CapacityPercentBelowTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.CapacityPercentBelow;

  /** Capacity percentage from 1 through 100. */
  @minValue(1)
  @maxValue(100)
  value: int32;
}

/** Triggers a policy according to a UTC five-field cron expression. */
@added(Versions.v2027_01_01)
model CronTimeTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.CronTime;

  /** UTC five-field cron expression. */
  value: string;
}

/** Starts a policy immediately. */
@added(Versions.v2027_01_01)
model ImmediateTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.Immediate;
}

/** Starts a policy once at a UTC timestamp. */
@added(Versions.v2027_01_01)
model OnceAtTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.OnceAt;

  /** UTC timestamp at which the policy starts. */
  value: utcDateTime;
}

/** Stops a policy after the specified amount of data has been released. */
@added(Versions.v2027_01_01)
model ReleasedSizeAboveTrigger extends AutoReleaseTrigger {
  /** The trigger kind. */
  type: AutoReleaseTriggerType.ReleasedSizeAbove;

  /** Formatted size consisting of an integer and an uppercase unit from B through P. */
  value: AutoReleaseSize;
}

/** An ordered filter applied to AutoRelease candidates. */
@added(Versions.v2027_01_01)
@discriminator("type")
model AutoReleaseFilter {
  /** Whether matching files are included or excluded. */
  mode: AutoReleaseFilterMode;

  /** The filter kind. */
  type: AutoReleaseFilterType;
}

/** Filters candidates by file-name suffix. */
@added(Versions.v2027_01_01)
model SuffixFilter extends AutoReleaseFilter {
  /** The filter kind. */
  type: AutoReleaseFilterType.Suffix;

  /** Non-empty list of suffixes to match. */
  @minItems(1)
  @maxItems(100)
  value: AutoReleaseSuffix[];
}

/** Filters candidates by minimum file size. */
@added(Versions.v2027_01_01)
model SizeAboveFilter extends AutoReleaseFilter {
  /** The filter kind. */
  type: AutoReleaseFilterType.SizeAbove;

  /** Formatted size consisting of an integer and an uppercase unit from B through P. */
  value: AutoReleaseSize;
}

/** Filters candidates by time since last access. */
@added(Versions.v2027_01_01)
model LastAccessOlderThanFilter extends AutoReleaseFilter {
  /** The filter kind. */
  type: AutoReleaseFilterType.LastAccessOlderThan;

  /** ISO 8601 duration. */
  value: duration;
}

/** Filters candidates by time since last change. */
@added(Versions.v2027_01_01)
model LastChangeOlderThanFilter extends AutoReleaseFilter {
  /** The filter kind. */
  type: AutoReleaseFilterType.LastChangeOlderThan;

  /** ISO 8601 duration. */
  value: duration;
}

/** Filters candidates by time since last restore. */
@added(Versions.v2027_01_01)
model LastRestoreOlderThanFilter extends AutoReleaseFilter {
  /** The filter kind. */
  type: AutoReleaseFilterType.LastRestoreOlderThan;

  /** ISO 8601 duration. */
  value: duration;
}

/** One AutoRelease policy within a complete policy set. */
@added(Versions.v2027_01_01)
model AutoReleasePolicy {
  /** Unique policy name within the policy set. */
  name: string;

  /** Unique priority from 0 through 10. Lower values have higher priority. */
  @minValue(0)
  @maxValue(10)
  priority: int32;

  /** Trigger that makes the policy ready. */
  start: AutoReleaseTrigger;

  /** Optional trigger that finishes the policy. */
  stop?: AutoReleaseTrigger;

  /** Filesystem-root-relative paths. When omitted during creation, the service uses the root path. */
  @minItems(1)
  @maxItems(100)
  prefixes?: string[] = #["/"];

  /** Ordered filters applied to candidate files. */
  @identifiers(#[])
  filters?: AutoReleaseFilter[];
}

/** Properties of an AutoRelease job. */
@added(Versions.v2027_01_01)
model AutoReleaseJobProperties {
  /** Azure Resource Manager provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: AutoReleaseJobProvisioningState;

  /** Current administrative status. If omitted from PUT, the service applies Enable. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  adminStatus?: AutoReleaseJobAdminStatus = AutoReleaseJobAdminStatus.Enable;

  /** Complete policy set. Policies are immutable after creation. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  @maxItems(10)
  @identifiers(#["name"])
  policies: AutoReleasePolicy[];

  /** Latest status accepted by the resource provider. */
  @visibility(Lifecycle.Read)
  status?: AutoReleaseJobStatus;
}

/** Latest status for an AutoRelease job. */
@added(Versions.v2027_01_01)
model AutoReleaseJobStatus {
  /** Current operational state. */
  @visibility(Lifecycle.Read)
  state?: AutoReleaseJobState;

  /** Latest maximum per-OST fullness, from 0 through 100, or -1 when unknown. */
  @visibility(Lifecycle.Read)
  @minValue(-1)
  @maxValue(100)
  capacityPercentage?: int32;

  /** Total passes since the AutoRelease daemon started. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  passCount?: int64;

  /** Policy currently holding the engine, or an empty string when idle. */
  @visibility(Lifecycle.Read)
  activePolicy?: string;

  /** Scheduling status for policies in the submitted set. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  policies?: AutoReleasePolicyStatus[];

  /** Current or most recent pass start time. */
  @visibility(Lifecycle.Read)
  passStartTime?: utcDateTime;

  /** Current or most recent pass end time, when available. */
  @visibility(Lifecycle.Read)
  passEndTime?: utcDateTime;

  /** Files released in the current or most recent pass. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  filesReleased?: int64;

  /** Bytes accounted for released files in the current or most recent pass. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  bytesReleased?: int64;

  /** Files skipped in the current or most recent pass. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  filesSkipped?: int64;

  /** Files that failed release in the current or most recent pass. */
  @visibility(Lifecycle.Read)
  @minValue(0)
  filesFailed?: int64;
}

/** Scheduling status for one AutoRelease policy. */
@added(Versions.v2027_01_01)
model AutoReleasePolicyStatus {
  /** Policy name from the submitted policy set. */
  @visibility(Lifecycle.Read)
  name: string;

  /** Current policy scheduling state. */
  @visibility(Lifecycle.Read)
  state?: AutoReleasePolicyState;
}

/** AutoRelease job update request. */
@added(Versions.v2027_01_01)
model AutoReleaseJobUpdate {
  /** Properties to update. */
  properties?: AutoReleaseJobUpdateProperties;
}

/** Writable properties for an AutoRelease job update. */
@added(Versions.v2027_01_01)
model AutoReleaseJobUpdateProperties {
  /** Administrative status to apply. */
  adminStatus?: AutoReleaseJobAdminStatus;
}
