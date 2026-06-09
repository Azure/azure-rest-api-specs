import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Foundations;

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

// Mark all status-monitor fields read-only and tag `status` so the
// poller infrastructure can find it on the custom status monitor shape.
@@visibility(LongRunningOperationStatus.id, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.status, Lifecycle.Read);
@@Azure.Core.lroStatus(LongRunningOperationStatus.status);
@@visibility(LongRunningOperationStatus.error, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.result, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.startTime, Lifecycle.Read);
@@visibility(LongRunningOperationStatus.endTime, Lifecycle.Read);
