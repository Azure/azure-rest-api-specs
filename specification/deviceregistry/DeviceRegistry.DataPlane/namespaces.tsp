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
// Namespace operations models
// ──────────────────────────────────────────────

/** The type of report. */
union ReportType {
  string,

  /** Compliance report describing the updating state of devices in the namespace. */
  NamespaceUpdateComplianceReport: "NamespaceUpdateComplianceReport",

  /** Report describing the best available updates and update compliance for the devices within a group. */
  GroupBestUpdatesComplianceReport: "GroupBestUpdatesComplianceReport",

  /** Report listing the installable updates for the devices within a group. */
  GroupInstallableUpdatesReport: "GroupInstallableUpdatesReport",
}

/**
 * Request body for generating a report.
 */
@discriminator("reportType")
model GenerateReportRequest {
  /** The type of report to generate. */
  reportType: ReportType;

  /** The target of this report (e.g. group resource). */
  reportTarget?: string;
}

/** Base report type */
@discriminator("reportType")
model Report {
  /** The type of report. */
  @visibility(Lifecycle.Read)
  reportType: ReportType;

  /** The scope the report was generated against. */
  @visibility(Lifecycle.Read)
  reportTarget?: string;
}

/** Result of a NamespaceUpdateCompliance report. */
model NamespaceUpdateComplianceReport extends Report {
  /** Discriminator for NamespaceUpdateCompliance reports. */
  reportType: ReportType.NamespaceUpdateComplianceReport;

  /** Total number of devices in the namespace that are eligible for updates. */
  totalUpdateableDeviceCount: int32;

  /** Number of devices that are currently on the latest available update. */
  onLatestUpdateDeviceCount: int32;

  /** Number of devices for which a newer update is available but not yet applied. */
  newUpdatesAvailableDeviceCount: int32;

  /** Number of devices currently being updated to the latest available update. */
  updatesInProgressDeviceCount: int32;

  /** Total number of devices in the namespace that are not eligible for updates. */
  totalNotUpdateableDeviceCount: int32;
}

// ──────────────────────────────────────────────
// Concrete request stubs (one per ReportType).
// Add report-specific input fields to the relevant subclass as the
// product evolves; each subclass already inherits `reportTarget` and
// pins its `reportType` discriminator.
// ──────────────────────────────────────────────

/** Request to generate a NamespaceUpdateCompliance report. */
model GenerateNamespaceUpdateComplianceReportRequest
  extends GenerateReportRequest {
  reportType: ReportType.NamespaceUpdateComplianceReport;
}

/** Request to generate a GroupBestUpdates compliance report. */
model GenerateGroupBestUpdatesComplianceReportRequest
  extends GenerateReportRequest {
  reportType: ReportType.GroupBestUpdatesComplianceReport;
}

/** Request to generate a GroupInstallableUpdates report. */
model GenerateGroupInstallableUpdatesReportRequest
  extends GenerateReportRequest {
  reportType: ReportType.GroupInstallableUpdatesReport;
}

// ──────────────────────────────────────────────
// Concrete response stubs for the two report types that don't yet
// have a typed body. Mirrors the request stubs so every value of
// ReportType is satisfiable on both sides.
// ──────────────────────────────────────────────

/** Result of a GroupBestUpdates compliance report. */
model GroupBestUpdatesComplianceReport extends Report {
  reportType: ReportType.GroupBestUpdatesComplianceReport;
}

/** Result of a GroupInstallableUpdates report. */
model GroupInstallableUpdatesReport extends Report {
  reportType: ReportType.GroupInstallableUpdatesReport;
}

// ──────────────────────────────────────────────
// Namespaces interface
// ──────────────────────────────────────────────

/** Operations on namespaces. */
@tag("Namespaces")
interface Namespaces {
  /** Generate a report for a namespace. */
  @pollingOperation(Operations.get)
  generateReport is ResourceOperations.LongRunningResourceAction<
    Namespace,
    GenerateReportRequest,
    Report
  >;
}
