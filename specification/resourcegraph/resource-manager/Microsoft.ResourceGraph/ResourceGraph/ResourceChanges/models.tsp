import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using ResourceGraphCommon;

namespace ResourceChanges;

/**
 * The change type for snapshot. PropertyChanges will be provided in case of Update change type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ChangeType {
  /**
   * Create
   */
  Create,

  /**
   * Update
   */
  Update,

  /**
   * Delete
   */
  Delete,
}

/**
 * The change category.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ChangeCategory {
  /**
   * User
   */
  User,

  /**
   * System
   */
  System,
}

/**
 * The property change Type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum PropertyChangeType {
  /**
   * Insert
   */
  Insert,

  /**
   * Update
   */
  Update,

  /**
   * Remove
   */
  Remove,
}

/**
 * The parameters for a specific changes request.
 */
model ResourceChangesRequestParameters {
  /**
   * Specifies the list of resources for a changes request.
   */
  resourceIds?: string[];

  /**
   * The subscription id of resources to query the changes from.
   */
  subscriptionId?: string;

  /**
   * Specifies the date and time interval for a changes request.
   */
  interval: ResourceChangesRequestParametersInterval;

  /**
   * Acts as the continuation token for paged responses.
   */
  $skipToken?: string;

  /**
   * The maximum number of changes the client can accept in a paged response.
   */
  @maxValue(1000)
  @minValue(1)
  $top?: int32;

  /**
   * The table name to query resources from.
   */
  table?: string;

  /**
   * The flag if set to true will fetch property changes
   */
  fetchPropertyChanges?: boolean;

  /**
   * The flag if set to true will fetch change snapshots
   */
  fetchSnapshots?: boolean;
}

alias DateTimeInterval = ResourceGraphCommon.DateTimeInterval;

/**
 * Specifies the date and time interval for a changes request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceChangesRequestParametersInterval extends DateTimeInterval {}

/**
 * A list of changes associated with a resource over a specific time interval.
 */
model ResourceChangeList {
  /**
   * The pageable value returned by the operation, i.e. a list of changes to the resource.
   *
   * - The list is ordered from the most recent changes to the least recent changes.
   * - This list will be empty if there were no changes during the requested interval.
   * - The `Before` snapshot timestamp value of the oldest change can be outside of the specified time interval.
   */
  @identifiers(#[])
  changes?: ResourceChangeData[];

  /**
   * Skip token that encodes the skip information while executing the current request
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  $skipToken?: unknown;
}

/**
 * Data on a specific change, represented by a pair of before and after resource snapshots.
 */
model ResourceChangeData {
  /**
   * The resource for a change.
   */
  resourceId?: string;

  /**
   * The change ID. Valid and unique within the specified resource only.
   */
  changeId: string;

  /**
   * The snapshot before the change.
   */
  beforeSnapshot: ResourceChangeDataBeforeSnapshot;

  /**
   * The snapshot after the change.
   */
  afterSnapshot: ResourceChangeDataAfterSnapshot;

  /**
   * The change type for snapshot. PropertyChanges will be provided in case of Update change type
   */
  changeType?: ChangeType;

  /**
   * An array of resource property change
   */
  @identifiers(#[])
  propertyChanges?: ResourcePropertyChange[];
}

/**
 * The snapshot before the change.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceChangeDataBeforeSnapshot extends ResourceSnapshotData {}

/**
 * Data on a specific resource snapshot.
 */
model ResourceSnapshotData {
  /**
   * The ID of the snapshot.
   */
  snapshotId?: string;

  /**
   * The time when the snapshot was created.
   * The snapshot timestamp provides an approximation as to when a modification to a resource was detected.  There can be a difference between the actual modification time and the detection time.  This is due to differences in how operations that modify a resource are processed, versus how operation that record resource snapshots are processed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp: utcDateTime;

  /**
   * The resource snapshot content (in resourceChangeDetails response only).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  content?: unknown;
}

/**
 * The snapshot after the change.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceChangeDataAfterSnapshot extends ResourceSnapshotData {}

/**
 * The resource property change
 */
model ResourcePropertyChange {
  /**
   * The property name
   */
  propertyName: string;

  /**
   * The property value in before snapshot
   */
  beforeValue?: string;

  /**
   * The property value in after snapshot
   */
  afterValue?: string;

  /**
   * The change category.
   */
  changeCategory: ChangeCategory;

  /**
   * The property change Type
   */
  propertyChangeType: PropertyChangeType;
}

/**
 * The parameters for a specific change details request.
 */
model ResourceChangeDetailsRequestParameters {
  /**
   * Specifies the list of resources for a change details request.
   */
  resourceIds: string[];

  /**
   * Specifies the list of change IDs for a change details request.
   */
  changeIds: string[];
}
