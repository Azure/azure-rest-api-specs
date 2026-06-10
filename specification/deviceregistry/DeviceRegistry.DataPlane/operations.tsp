import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Namespace operation status (polling) resource
// ──────────────────────────────────────────────

/** The kind of long-running operation tracked by an `Operation` resource. */
union OperationKind {
  string,

  /** Device provisioning status report. */
  ProvisionDevice: "ProvisionDevice",

  /** Device reprovisioning (move to a new IoT Hub). */
  @added(Versions.v2026_11_02_preview)
  ReprovisionDevice: "ReprovisionDevice",

  /** Compliance report describing the updating state of devices in the namespace. */
  NamespaceUpdateComplianceReport: "GenerateReport.NamespaceUpdateComplianceReport",

  /** Report describing the best available updates and update compliance for the devices within a group. */
  GroupBestUpdatesComplianceReport: "GenerateReport.GroupBestUpdatesComplianceReport",

  /** Report listing the installable updates for the devices within a group. */
  GroupInstallableUpdatesReport: "GenerateReport.GroupInstallableUpdatesReport",
}

/** A long-running operation status resource scoped to a namespace. */
@parentResource(Namespace)
@resource("operations")
model Operation {
  /** The unique identifier of the operation. */
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: string;

  /** The kind of operation tracked by this status resource. */
  @visibility(Lifecycle.Read)
  kind: OperationKind;

  /** The current status of the operation. */
  @visibility(Lifecycle.Read)
  status: Azure.Core.Foundations.OperationState;

  /** Error details when the operation failed. */
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  /** The time at which the operation was started (UTC). */
  @visibility(Lifecycle.Read)
  executedAt?: utcDateTime;

  /** The time at which the operation result expires (UTC). */
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  /**
   * The operation results when `status` is `Succeeded`. The shape of this
   * object depends on `kind`; for report kinds it conforms to the
   * corresponding `Report` subtype returned by the originating action.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Operation results are heterogeneous across operation kinds and require arbitrary value types."
  @visibility(Lifecycle.Read)
  result?: Record<unknown>;
}

// ──────────────────────────────────────────────
// Operations interface (LRO status polling)
// ──────────────────────────────────────────────

/** Operations on long-running operation status resources. */
@tag("Operations")
interface Operations {
  /** Get the status of a long-running operation. */
  get is ResourceOperations.ResourceRead<Operation>;

  /** List long running operations. */
  list is ResourceOperations.ResourceList<Operation>;
}
