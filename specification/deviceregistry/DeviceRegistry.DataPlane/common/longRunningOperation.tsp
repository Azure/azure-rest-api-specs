import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;
using TypeSpec.Http;

namespace Microsoft.DeviceRegistry;

/**
 * Project-local base for every long-running operation status monitor in the
 * Device Registry data plane. Extends `Azure.Core.Foundations.OperationStatus`
 * (the canonical Azure API Guidelines status monitor — id, status, error,
 * optional typed result) with the two project-standard timestamps using
 * ARM RPC `OperationStatusResult` naming: `startTime` and `endTime`.
 *
 * Concrete consumers add their own `@parentResource` + `@resource(...)`
 * decorators to bind the type to a URL segment.
 *
 * @template TResult Type of the operation's success payload. Defaults to
 * `never`, which causes the emitter to omit the `result` property entirely
 * (use this for actions that have no result body, e.g. `:revokeCerts`).
 * @template TError Type of the operation's failure payload. Defaults to the
 * standard `Azure.Core.Foundations.Error`.
 */
model LongRunningOperationStatus<
  TResult = never,
  TError = Azure.Core.Foundations.Error
> is Azure.Core.Foundations.OperationStatus<TResult, TError> {
  /** The time at which the operation was started (UTC). */
  startTime?: utcDateTime;

  /** The time at which the operation reached a terminal state (UTC). */
  endTime?: utcDateTime;
}

// Mark all status-monitor fields read-only. `status` is automatically
// recognized as the LRO status field because `OperationState` itself carries
// `@lroStatus` in Azure Core's foundations.
@@visibility(LongRunningOperationStatus.id, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.status, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.error, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.result, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.startTime, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.endTime, Lifecycle.Read);

/**
 * Request `Operation-Id` header used by long-running action operations
 * (POST `:verb` endpoints). If omitted, the service generates a GUID.
 */
model LongRunningOperationIdHeader {
  /**
   * Optional client-supplied identifier for the operation's status monitor.
   * If omitted, the service generates a GUID.
   */
  @header("Operation-Id")
  operationId?: string;
}

/**
 * Response `Operation-Id` header used by long-running action operations
 * (POST `:verb` endpoints).
 */
model LongRunningOperationIdResponseHeader {
  /** The ID of the long-running operation's status monitor. */
  @header("Operation-Id")
  operationId: string;
}

/**
 * Response headers emitted on long-running action trigger responses, per
 * the Azure API Guidelines.
 */
alias LongRunningActionResponseHeadersTrait = ResponseHeadersTrait<
  RetryAfterHeader & LongRunningOperationIdResponseHeader,
  TraitContext.Action
>;

/**
 * Response headers emitted on long-running operation status-monitor GETs
 * while the operation is still running, per the Azure API Guidelines.
 */
alias LongRunningStatusMonitorResponseHeadersTrait = ResponseHeadersTrait<
  RetryAfterHeader,
  TraitContext.Read
>;
