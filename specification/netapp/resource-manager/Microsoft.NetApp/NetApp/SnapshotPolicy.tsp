import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

namespace Microsoft.NetApp;
/**
 * Snapshot policy information
 */
@parentResource(NetAppAccount)
model SnapshotPolicy
  is Azure.ResourceManager.TrackedResource<SnapshotPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = SnapshotPolicy,
    KeyName = "snapshotPolicyName",
    SegmentName = "snapshotPolicies",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

/**
 * List of Snapshot Policies
 */
model SnapshotPoliciesList is Azure.Core.Page<SnapshotPolicy>;

/**
 * Snapshot policy properties
 */
model SnapshotPolicyProperties {
  /**
   * Schedule for hourly snapshots
   */
  hourlySchedule?: HourlySchedule;

  /**
   * Schedule for daily snapshots
   */
  dailySchedule?: DailySchedule;

  /**
   * Schedule for weekly snapshots
   */
  weeklySchedule?: WeeklySchedule;

  /**
   * Schedule for monthly snapshots
   */
  monthlySchedule?: MonthlySchedule;

  /**
   * The property to decide policy is enabled or not
   */
  enabled?: boolean;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Hourly Schedule properties
 */
model HourlySchedule {
  /**
   * Hourly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Daily Schedule properties
 */
model DailySchedule {
  /**
   * Daily snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Weekly Schedule properties, make a snapshot every week at a specific day or days
 */
model WeeklySchedule {
  /**
   * Weekly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which weekdays snapshot should be taken, accepts a comma separated list of week day names in english
   */
  day?: string;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Monthly Schedule properties
 */
model MonthlySchedule {
  /**
   * Monthly snapshot count to keep
   */
  snapshotsToKeep?: int32;

  /**
   * Indicates which days of the month snapshot should be taken. A comma delimited string.
   */
  daysOfMonth?: string;

  /**
   * Indicates which hour in UTC timezone a snapshot should be taken
   */
  hour?: int32;

  /**
   * Indicates which minute snapshot should be taken
   */
  minute?: int32;

  /**
   * Resource size in bytes, current storage usage for the volume in bytes
   */
  usedBytes?: int64;
}

/**
 * Snapshot policy Details for create and update
 */
model SnapshotPolicyPatch {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Snapshot Policy properties
   */
  properties?: SnapshotPolicyProperties;
}

/**
 * Volumes associated with snapshot policy
 */
model SnapshotPolicyVolumeList is Azure.Core.Page<Volume>;

@armResourceOperations
interface SnapshotPolicies {
  /**
   * Get a snapshot Policy
   */
  get is ArmResourceRead<SnapshotPolicy>;

  /**
   * Create a snapshot policy
   */
  create is ArmResourceCreateOrReplaceSync<SnapshotPolicy>;

  /**
   * Patch a snapshot policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SnapshotPolicy,
    PatchModel = SnapshotPolicyPatch,
    Response = ArmResponse<SnapshotPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SnapshotPolicy> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: SnapshotPolicy;
    })
  >;

  /**
   * Delete snapshot policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SnapshotPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List snapshot policy
   */
  list is ArmResourceListByParent<
    SnapshotPolicy,
    Response = ArmResponse<SnapshotPoliciesList>
  >;

  /**
   * Get volumes associated with snapshot policy
   */
  @get
  @action("volumes")
  listVolumes is ArmResourceActionSync<
    SnapshotPolicy,
    void,
    ArmResponse<SnapshotPolicyVolumeList>
  >;
}

@@doc(SnapshotPolicy.name, "The name of the snapshot policy");
@@doc(SnapshotPolicy.properties, "Snapshot policy Properties");
@@doc(SnapshotPolicies.create::parameters.resource,
  "Snapshot policy object supplied in the body of the operation."
);
@@doc(SnapshotPolicies.update::parameters.properties,
  "Snapshot policy object supplied in the body of the operation."
);
