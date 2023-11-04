import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

@useDependency(Azure.Core.)
namespace Microsoft.DeviceUpdate;

// TODO virtual resource?
/** The Device Update for IoT Hub account instance. */
@resource("deviceUpdate")
model Instance {
  /** The Device Update for IoT Hub account instance identifier. */
  @key
  @visibility("read")
  instanceId: string;
}

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
  @doc("""
Two to four part dot separated numerical version numbers.
Each part must be a number between 0 and 2147483647 and leading zeroes will be dropped.
""")
  @minLength(3)
  @pattern("^\\d+(?:\\.\\d+)+$")
  version: string;
}

/** List of update information. */
model UpdateInfoList is Azure.Core.Page<UpdateInfo>;

/** Update information. */
model UpdateInfo {
  /** Update identifier. */
  updateId: UpdateId;

  /** Update description. */
  @visibility("read")
  description?: string;

  /** Friendly update name. */
  @visibility("read")
  friendlyName?: string;
}

/** Common error response. */
@error
model ErrorResponse {
  /** The error details. */
  error: Error;
}

/** Error details. */
model Error {
  /** Server defined error code. */
  code: string;

  /** A human-readable representation of the error. */
  message: string;

  /** The target of the error. */
  target?: string;

  /** An array of errors that led to the reported error. */
  details?: Error[];

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innererror?: InnerError;

  /** Date and time in UTC when the error occurred. */
  occurredDateTime?: utcDateTime;
}

@doc("""
An object containing more specific information than the current object about
the error.
""")
model InnerError {
  /** A more specific error code than what was provided by the containing error. */
  code: string;

  /** A human-readable representation of the error. */
  message?: string;

  /** The internal error or exception message. */
  errorDetail?: string;

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innerError?: InnerError;
}

/** Operation status */
enum OperationStatus {
  /** Background operation created but not started yet. */
  NotStarted,
  /** Background operation is currently running. */
  Running,
  /** Background operation finished with success. */
  Succeeded,
  /** Background operation finished with failure. */
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


/** Device deployement state */
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