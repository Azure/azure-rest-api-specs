import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./common/longRunningOperation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

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
  /** Get the status of a long-running operation. */
  get is ResourceOperations.ResourceRead<
    Operation,
    LongRunningStatusMonitorResponseHeadersTrait
  >;
}
