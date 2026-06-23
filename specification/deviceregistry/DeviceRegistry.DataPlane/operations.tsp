import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./common/longRunningOperation.tsp";

using TypeSpec.Rest;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Namespace operation status (polling) resource
// ──────────────────────────────────────────────

/**
 * Central status monitor for resource long-running operations on a namespace
 * (e.g. DeviceCapability create-or-replace / delete). Action LROs (POST
 * `:verb` endpoints) have their own per-action status-monitor endpoints
 * and do not surface here.
 */
@parentResource(Namespace)
@resource("operations")
model Operation is LongRunningOperationStatus;

// ──────────────────────────────────────────────
// Operations interface (LRO status polling)
// ──────────────────────────────────────────────

/** Operations on long-running operation status resources. */
@tag("Operations")
interface Operations {
  /**
   * Get the latest state for a namespace-scoped long-running operation.
   * Returns the current status, and includes error details when the operation
   * reaches a failed terminal state.
   */
  get is ResourceOperations.ResourceRead<
    Operation,
    LongRunningStatusMonitorResponseHeadersTrait
  >;
}
