import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace Azure.IoT.DeviceUpdate;

/** Update identifier. */
model UpdateId {
  /** Update provider. */
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9.-]+$")
  provider: string;

  /** Update name. */
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9.-]+$")
  name: string;

  /** Update version. */
  /**
   * Two to four part dot separated numerical version numbers.
   * Each part must be a number between 0 and 2147483647 and leading zeroes will be dropped.
   */
  @minLength(3)
  @pattern("^\\d+(?:\\.\\d+)+$")
  version: string;
}

/** List of update information. */
model UpdateInfoList is Azure.Core.Page<UpdateInfo>;

/** Update information. */
model UpdateInfo {
  /** Update identifier. */
  @key
  @visibility("read")
  updateId: UpdateId;

  /** Update description. */
  @visibility("read")
  description?: string;

  /** Friendly update name. */
  @visibility("read")
  friendlyName?: string;
}

/** Operation status */
@lroStatus
enum OperationStatus {
  /** Background operation created but not started yet. */
  NotStarted,

  /** Background operation is currently running. */
  Running,

  /** Background operation finished with success. */
  @lroSucceeded
  Succeeded,

  /** Background operation finished with failure. */
  @lroFailed
  Failed,
}

/** Operation status filter. */
model OperationFilter {
  /** Operation status filter. */
  status?: OperationFilterStatus;
}

/**
 * Operation filter status
 */
enum OperationFilterStatus {
  /** Running */
  Running,

  /** Not started */
  NotStarted,
}

/** Device deployment state */
enum DeviceDeploymentState {
  /** Deployment has completed with success. */
  Succeeded,

  /** Deployment is in progress. */
  InProgress,

  /** Deployment was canceled. */
  Canceled,

  /** Deployment has completed with failure. */
  Failed,
}
