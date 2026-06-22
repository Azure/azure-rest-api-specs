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
using Azure.Core.Foundations;
using Azure.Core.Traits;

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
 * Selector identifying a report by type and target. Shared as the request
 * body for both the `:generateReport` and `:getLatestReport` actions.
 */
@discriminator("reportType")
model ReportSelector {
  /** The type of report. */
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
  @visibility(Lifecycle.Read)
  reportType: ReportType.NamespaceUpdateComplianceReport;

  /** Total number of devices in the namespace that are eligible for updates. */
  @visibility(Lifecycle.Read)
  totalUpdateableDeviceCount: int32;

  /** Number of updateable devices that are currently on the latest available update. */
  @visibility(Lifecycle.Read)
  onLatestUpdateDeviceCount: int32;

  /** Number of updateable devices for which a newer update is available but not yet applied. */
  @visibility(Lifecycle.Read)
  newUpdatesAvailableDeviceCount: int32;

  /** Number of updateable devices currently being updated to the latest available update. */
  @visibility(Lifecycle.Read)
  updatesInProgressDeviceCount: int32;

  /** Total number of devices in the namespace that are not eligible for updates. */
  @visibility(Lifecycle.Read)
  totalNotUpdateableDeviceCount: int32;
}

// ──────────────────────────────────────────────
// Concrete request stubs (one per ReportType).
// Add report-specific input fields to the relevant subclass as the
// product evolves; each subclass already inherits `reportTarget` and
// pins its `reportType` discriminator. They extend `ReportSelector`
// (the discriminated base) so the `reportType` discriminator is
// preserved; the LRO id header is layered on separately at the
// `:generateReport` operation, not on these selector variants.
// ──────────────────────────────────────────────

/** Request to generate a NamespaceUpdateCompliance report. */
model NamespaceUpdateComplianceReportRequest extends ReportSelector {
  reportType: ReportType.NamespaceUpdateComplianceReport;
}

/** Request to generate a GroupBestUpdates compliance report. */
model GroupBestUpdatesComplianceReportRequest extends ReportSelector {
  reportType: ReportType.GroupBestUpdatesComplianceReport;

  /** The group that the report is generated against. */
  reportTarget: string;
}

/** Request to generate a GroupInstallableUpdates report. */
model GroupInstallableUpdatesReportRequest extends ReportSelector {
  reportType: ReportType.GroupInstallableUpdatesReport;

  /** The group that the report is generated against. */
  reportTarget: string;
}

/** Identifies a specific update by provider, name, and version. */
model UpdateId {
  /** The provider that published the update. */
  @visibility(Lifecycle.Read)
  provider: string;

  /** The name of the update. */
  @visibility(Lifecycle.Read)
  name: string;

  /** The version of the update. */
  @visibility(Lifecycle.Read)
  version: string;
}

/** Criteria selecting which devices an update targets. */
model TargetDevices {
  /** Free-form compatibility properties (e.g. manufacturer, model) used to match devices. */
  @visibility(Lifecycle.Read)
  compatProperties: Record<string>;

  /** The agent profile that the targeted devices must implement. */
  @visibility(Lifecycle.Read)
  agentProfile: int32;
}

/** A best-available update for a subset of devices in the group. */
model BestUpdate {
  /** The devices that this update targets. */
  @visibility(Lifecycle.Read)
  targetDevices: TargetDevices;

  /** The identifier of the best-available update for the targeted devices. */
  @visibility(Lifecycle.Read)
  updateId: UpdateId;

  /** The number of devices in the group that target this update but are not yet running it. */
  @visibility(Lifecycle.Read)
  devicesNotOnBestUpdateCount: int32;
}

/** Group-level update compliance counters. */
model GroupUpdateCompliance {
  /** Total number of devices in the group that are eligible for updates. */
  @visibility(Lifecycle.Read)
  totalUpdateableDeviceCount: int32;

  /** Number of updateable devices that are currently on the best available update. */
  @visibility(Lifecycle.Read)
  onBestUpdateDeviceCount: int32;

  /** Number of updateable devices for which a better update is available but not yet applied. */
  @visibility(Lifecycle.Read)
  bestUpdateAvailableDeviceCount: int32;

  /** Number of updateable devices currently being updated to the best available update. */
  @visibility(Lifecycle.Read)
  devicesInProgressOnBestUpdate: int32;

  /** Total number of devices in the group that are not eligible for updates. */
  @visibility(Lifecycle.Read)
  totalNotUpdateableDeviceCount: int32;
}

/** Result of a GroupBestUpdates compliance report. */
model GroupBestUpdatesComplianceReport extends Report {
  @visibility(Lifecycle.Read)
  reportType: ReportType.GroupBestUpdatesComplianceReport;

  /** The group that this report was generated against. */
  @visibility(Lifecycle.Read)
  reportTarget: string;

  /** Group-level update compliance counters. */
  @visibility(Lifecycle.Read)
  updateCompliance: GroupUpdateCompliance;

  /** The best-available updates for devices in the group. May be empty. */
  @visibility(Lifecycle.Read)
  bestUpdates: BestUpdate[];
}

/** The set of installable updates available for a class of target devices in the group. */
model InstallableUpdatesForTargetDevices {
  /** The devices that this set of updates targets. */
  @visibility(Lifecycle.Read)
  targetDevices: TargetDevices;

  /** The updates that can be installed on the targeted devices. */
  @visibility(Lifecycle.Read)
  installableUpdates: UpdateId[];
}

/** Result of a GroupInstallableUpdates report. */
model GroupInstallableUpdatesReport extends Report {
  @visibility(Lifecycle.Read)
  reportType: ReportType.GroupInstallableUpdatesReport;

  /** The group that this report was generated against. */
  @visibility(Lifecycle.Read)
  reportTarget: string;

  /** Installable updates grouped by the devices they target. May be empty. */
  @visibility(Lifecycle.Read)
  installableUpdatesAndTargetDevices: InstallableUpdatesForTargetDevices[];
}

// ──────────────────────────────────────────────
// Generate-report status monitor endpoint
// ──────────────────────────────────────────────

/**
 * Status monitor for the long-running `:generateReport` action on a namespace.
 * The typed `result` is the produced `Report` (polymorphic over `reportType`).
 */
@parentResource(Namespace)
@resource("generateReportResults")
model GenerateReportResult is LongRunningOperationStatus<Report>;

/**
 * Request for the long-running `:generateReport` action: a report selector
 * combined with the long-running operation id header. Defined as an alias so
 * the `reportType` discriminator on `ReportSelector` is preserved on the wire
 * (a spread `model` would flatten it and break `@discriminator`).
 */
alias GenerateReportRequest = ReportSelector & LongRunningOperationIdHeader;

// ──────────────────────────────────────────────
// Namespaces interface
// ──────────────────────────────────────────────

/** Operations on namespaces. */
@tag("Namespaces")
interface Namespaces {
  /** Generate a report for a namespace. */
  @pollingOperation(GenerateReportResults.get)
  generateReport is ResourceOperations.LongRunningResourceAction<
    Namespace,
    GenerateReportRequest,
    Report,
    Azure.Core.Foundations.Error,
    LongRunningActionResponseHeadersTrait
  >;

  /**
   * Get the most recently generated report of the given type and target
   * without triggering a new report generation. Returns the report directly
   * with 200 OK; no polling.
   */
  getLatestReport is ResourceOperations.ResourceAction<
    Namespace,
    ReportSelector,
    Report
  >;
}

/** Polling operations for the long-running `:generateReport` action on namespaces. */
@tag("Namespaces")
interface GenerateReportResults {
  /** Get the result of a `:generateReport` operation. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Intentional: keep this GET grouped with Namespaces in generated SDK clients."
  // Override the emitted operationId to surface this status monitor under
  // the `Namespaces` SDK client (matches the wire-side `Namespaces_GenerateReport`
  // action that produces these results) rather than as a top-level
  // `GenerateReportResults_Get` method.
  @operationId("Namespaces_GetGenerateReportResult")
  get is ResourceOperations.ResourceRead<
    GenerateReportResult,
    LongRunningStatusMonitorResponseHeadersTrait
  >;
}
