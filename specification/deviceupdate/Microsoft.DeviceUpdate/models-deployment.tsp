import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/** Deployment metadata. */
@resource("deployments")
@parentResource(Group)
model Deployment {
  /**
   * The caller-provided deployment identifier. This cannot be longer than 73
   * characters, must be all lower-case, and cannot contain '&', '^', '[', ']', '{',
   * '}', '|', '<', '>', forward slash, backslash, or double quote. The Updates view
   * in the Azure Portal IoT Hub resource generates a GUID for deploymentId when you
   * create a deployment.
   */
  @key
  @visibility("read", "create")
  deploymentId: string;

  /** The deployment start datetime. */
  @visibility("read", "create", "update")
  startDateTime: utcDateTime;

  /** Update information for the update in the deployment. */
  @visibility("read", "create")
  update: UpdateInfo;

  /** The group identity for the devices the deployment is intended to update. */
  @visibility("read", "create")
  groupId: string;

  /**
   * The device class subgroups the deployment is compatible with and subgroup
   * deployments have been created for. This is not provided by the caller during
   * CreateOrUpdateDeployment but is automatically determined by Device Update
   */
  @visibility("read")
  deviceClassSubgroups?: string[];

  /** Boolean flag indicating whether the deployment was canceled. */
  @visibility("read")
  isCanceled?: boolean;

  /** Boolean flag indicating whether the deployment has been retried. */
  @visibility("read")
  isRetried?: boolean;

  /** The rollback policy for the deployment. */
  @visibility("read", "create")
  rollbackPolicy?: CloudInitiatedRollbackPolicy;

  /** Boolean flag indicating whether the deployment is a rollback deployment. */
  @visibility("read")
  isCloudInitiatedRollback?: boolean;
}

/** DeviceClass Subgroup Deployment metadata */
@resource("deployments")
@parentResource(DeviceClassSubgroup)
model DeviceClassSubgroupDeployment is Deployment;

/** Rollback policy for deployment */
model CloudInitiatedRollbackPolicy {
  /** Update to rollback to. */
  update: UpdateInfo;

  /** Failure conditions to initiate rollback policy. */
  failure: CloudInitiatedRollbackPolicyFailure;
}

/** Failure conditions to initiate rollback policy */
model CloudInitiatedRollbackPolicyFailure {
  /** Percentage of devices that failed. */
  devicesFailedPercentage: int32;

  /** Number of devices that failed. */
  devicesFailedCount: int32;
}

/** Deployment device status. */
@resource("devicestates")
@parentResource(DeviceClassSubgroupDeployment)
model DeploymentDeviceState {
  /** Device identity. */
  @key
  @path
  @visibility("read")
  deviceId: string;

  /** Device module identity. */
  moduleId?: string;

  /** The number of times this deployment has been retried on this device. */
  retryCount: int32;

  /**
   * Boolean flag indicating whether this device is in a newer deployment and can no
   * longer retry this deployment.
   */
  movedOnToNewDeployment: boolean;

  /** Deployment device state. */
  deviceState: DeviceDeploymentState;
}

/** Deployment status metadata. */
model DeploymentStatus {
  /** The group identity */
  groupId: string;

  /** The state of the deployment. */
  deploymentState: DeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment
   * state is not Failed.
   */
  error?: Azure.Core.Foundations.Error;

  /** The collection of device class subgroup status objects */
  subgroupStatus: DeviceClassSubgroupDeploymentStatus[];
}

/** Deployment state */
enum DeploymentState {
  /** The deployment can be sent to devices targeted in the deployment. */
  Active,

  /**
   * The deployment can be sent to some devices targeted in the deployment but at least 1 subgroup is in a failed state.
   */
  ActiveWithSubgroupFailures,

  /**
   * The deployment will not be sent to any devices.  Consult error for more details about what failed.
   */
  Failed,

  /**
   * A newer deployment for this group has been created and no devices in the group will receive this deployment.
   */
  Inactive,

  /** The deployment has been canceled and no devices will receive it. */
  Canceled,
}

/** Device class subgroup deployment status metadata. */
model DeviceClassSubgroupDeploymentStatus {
  /** The group identity */
  groupId: string;

  /** The device class subgroup identity */
  deviceClassId: string;

  /** The state of the subgroup deployment. */
  deploymentState: DeviceClassSubgroupDeploymentState;

  /**
   * The error details of the Failed state.  This is not present if the deployment
   * state is not Failed.
   */
  error?: Azure.Core.Foundations.Error;

  /** The total number of devices in the deployment. */
  totalDevices?: int32;

  /** The number of devices that are currently in deployment. */
  devicesInProgressCount?: int32;

  /** The number of devices that have completed deployment with a failure. */
  devicesCompletedFailedCount?: int32;

  /** The number of devices which have successfully completed deployment. */
  devicesCompletedSucceededCount?: int32;

  /** The number of devices which have had their deployment canceled. */
  devicesCanceledCount?: int32;
}

/**
 * Device class subgroup deployment state.
 */
enum DeviceClassSubgroupDeploymentState {
  /** The subgroup deployment can be sent to devices targeted in the deployment. */
  Active,

  /** The subgroup deployment failed and will not be sent to any devices. */
  Failed,

  /**
   * A newer deployment for this subgroup has been created and no devices in the subgroup will receive this deployment.
   */
  Inactive,

  /** The subgroup deployment has been canceled and no devices will receive it. */
  Canceled,
}

/** Deployment order by. */
model DeploymentOrderBy {
  /** The deployment start datetime. */
  startDateTime?: utcDateTime;
}
