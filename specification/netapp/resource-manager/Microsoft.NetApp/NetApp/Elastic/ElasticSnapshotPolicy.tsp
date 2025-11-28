import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Snapshot Policy under an Elastic Account
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ElasticAccount)
model ElasticSnapshotPolicy
  is TrackedResource<ElasticSnapshotPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ElasticSnapshotPolicy,
    KeyName = "snapshotPolicyName",
    SegmentName = "elasticSnapshotPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/**
 * Elastic Snapshot policy properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotPolicyProperties {
  /**
   * Schedule for hourly snapshots
   */
  hourlySchedule?: ElasticSnapshotPolicyHourlySchedule;

  /**
   * Schedule for daily snapshots
   */
  dailySchedule?: ElasticSnapshotPolicyDailySchedule;

  /**
   * Schedule for weekly snapshots
   */
  weeklySchedule?: ElasticSnapshotPolicyWeeklySchedule;

  /** Schedule for monthly snapshots */
  monthlySchedule?: ElasticSnapshotPolicyMonthlySchedule;

  /** Configures if the snapshot policy is enabled on the volumes connected to the policy. */
  policyStatus?: PolicyStatus;

  /** Azure lifecycle management. */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;
}

/**
 * Policy status
 */
@added(Versions.v2025_09_01_preview)
union PolicyStatus {
  string,

  /** Value indicating the policy is enabled */
  Enabled: "Enabled",

  /** Value indicating the policy is disabled */
  Disabled: "Disabled",
}

/** Hourly Schedule properties used to create NetApp snapshot policy */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotPolicyHourlySchedule {
  /** Hourly snapshot count to keep */
  @minValue(0)
  @maxValue(255)
  snapshotsToKeep?: int32;

  /** Indicates which minute snapshot should be taken */
  @minValue(0)
  @maxValue(59)
  @example(30)
  minute?: int32;
}

/** Daily Schedule properties used to create NetApp snapshot policy */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotPolicyDailySchedule {
  /** Daily snapshot count to keep */
  @minValue(0)
  @maxValue(255)
  snapshotsToKeep?: int32;

  /** Indicates which hour in UTC timezone a snapshot should be taken */
  @minValue(0)
  @maxValue(23)
  @example(11)
  hour?: int32;

  /** Indicates which minute snapshot should be taken */
  @minValue(0)
  @maxValue(59)
  @example(30)
  minute?: int32;
}

/** Weekly Schedule properties used to create NetApp snapshot policy */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotPolicyWeeklySchedule {
  /** Weekly snapshot count to keep */
  @minValue(0)
  @maxValue(255)
  snapshotsToKeep?: int32;

  /** Indicates which weekday(s) snapshot(s) should be taken, accepts a list of week day names in english */
  @example(#["Sunday", "Monday"])
  days?: DayOfWeek[];

  /** Indicates which hour in UTC timezone a snapshot should be taken */
  @minValue(0)
  @maxValue(23)
  @example(11)
  hour?: int32;

  /** Indicates which minute snapshot should be taken */
  @minValue(0)
  @maxValue(59)
  @example(30)
  minute?: int32;
}

/** Monthly Schedule properties used to create NetApp snapshot policy */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotPolicyMonthlySchedule {
  /** Monthly snapshot count to keep */
  @minValue(0)
  @maxValue(255)
  snapshotsToKeep?: int32;

  /** Indicates which days of the month snapshot (1-31) should be taken, accepts a list of integers */
  @example(#[1, 11, 21])
  daysOfMonth?: int32[];

  /** Indicates which hour in UTC timezone a snapshot should be taken */
  @minValue(0)
  @maxValue(23)
  @example(11)
  hour?: int32;

  /** Indicates which minute snapshot should be taken */
  @minValue(0)
  @maxValue(59)
  @example(30)
  minute?: int32;
}

/**
 * Day of the week
 */
@added(Versions.v2025_09_01_preview)
union DayOfWeek {
  string,

  /** Take a snapshot each Sunday */
  Sunday: "Sunday",

  /** Take a snapshot each Monday */
  Monday: "Monday",

  /** Take a snapshot each Tuesday */
  Tuesday: "Tuesday",

  /** Take a snapshot each Wednesday */
  Wednesday: "Wednesday",

  /** Take a snapshot each Thursday */
  Thursday: "Thursday",

  /** Take a snapshot each Friday */
  Friday: "Friday",

  /** Take a snapshot each Saturday */
  Saturday: "Saturday",
}
/**
 * Elastic Volumes associated with Elastic Snapshot Policy
 */
model ElasticSnapshotPolicyVolumeList is Azure.Core.Page<ElasticVolume>;

@armResourceOperations
interface ElasticSnapshotPolicies {
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ElasticSnapshotPolicy>;

  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticSnapshotPolicy>;

  @added(Versions.v2025_09_01_preview)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    ElasticSnapshotPolicy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticSnapshotPolicy,
      ElasticSnapshotPolicyProperties
    >
  >;
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticSnapshotPolicy>;
  @added(Versions.v2025_09_01_preview)
  listByElasticAccount is ArmResourceListByParent<ElasticSnapshotPolicy>;

  /**
   * Get elastic volumes associated with Elastic Snapshot Policy
   */
  @list
  @get
  @action("elasticvolumes")
  @added(Versions.v2025_09_01_preview)
  listElasticVolumes is ArmResourceActionSync<
    ElasticSnapshotPolicy,
    void,
    ElasticSnapshotPolicyVolumeList
  >;
}

@@maxLength(ElasticSnapshotPolicy.name, 64);
@@minLength(ElasticSnapshotPolicy.name, 1);

@@clientName(ElasticSnapshotPolicies.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(ElasticSnapshotPolicies.update::parameters.properties, "body");
