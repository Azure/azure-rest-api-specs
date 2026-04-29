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

  /** Number of updateable devices that are currently on the latest available update. */
  onLatestUpdateDeviceCount: int32;

  /** Number of updateable devices for which a newer update is available but not yet applied. */
  newUpdatesAvailableDeviceCount: int32;

  /** Number of updateable devices currently being updated to the latest available update. */
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

  /** The group that the report is generated against. */
  reportTarget: string;
}

/** Request to generate a GroupInstallableUpdates report. */
model GenerateGroupInstallableUpdatesReportRequest
  extends GenerateReportRequest {
  reportType: ReportType.GroupInstallableUpdatesReport;

  /** The group that the report is generated against. */
  reportTarget: string;
}

/** Identifies a specific update by provider, name, and version. */
model UpdateId {
  /** The provider that published the update. */
  provider: string;

  /** The name of the update. */
  name: string;

  /** The version of the update. */
  version: string;
}

/** Criteria selecting which devices an update targets. */
model TargetDevices {
  /** Free-form compatibility properties (e.g. manufacturer, model) used to match devices. */
  compatProperties: Record<string>;

  /** The agent profile that the targeted devices must implement. */
  agentProfile: int32;
}

/** A best-available update for a subset of devices in the group. */
model BestUpdate {
  /** The devices that this update targets. */
  targetDevices: TargetDevices;

  /** The identifier of the best-available update for the targeted devices. */
  updateId: UpdateId;

  /** The number of devices in the group that target this update but are not yet running it. */
  devicesNotOnBestUpdateCount: int32;
}

/** Group-level update compliance counters. */
model GroupUpdateCompliance {
  /** Total number of devices in the group that are eligible for updates. */
  totalUpdateableDeviceCount: int32;

  /** Number of updateable devices that are currently on the best available update. */
  onBestUpdateDeviceCount: int32;

  /** Number of updateable devices for which a better update is available but not yet applied. */
  bestUpdateAvailableDeviceCount: int32;

  /** Number of updateable devices currently being updated to the best available update. */
  devicesInProgressOnBestUpdate: int32;

  /** Total number of devices in the group that are not eligible for updates. */
  totalNotUpdateableDeviceCount: int32;
}

/** Result of a GroupBestUpdates compliance report. */
model GroupBestUpdatesComplianceReport extends Report {
  reportType: ReportType.GroupBestUpdatesComplianceReport;

  /** The group that this report was generated against. */
  @visibility(Lifecycle.Read)
  reportTarget: string;

  /** Group-level update compliance counters. */
  updateCompliance: GroupUpdateCompliance;

  /** The best-available updates for devices in the group. May be empty. */
  bestUpdates: BestUpdate[];
}

/** The set of installable updates available for a class of target devices in the group. */
model InstallableUpdatesForTargetDevices {
  /** The devices that this set of updates targets. */
  targetDevices: TargetDevices;

  /** The updates that can be installed on the targeted devices. */
  installableUpdates: UpdateId[];
}

/** Result of a GroupInstallableUpdates report. */
model GroupInstallableUpdatesReport extends Report {
  reportType: ReportType.GroupInstallableUpdatesReport;

  /** The group that this report was generated against. */
  @visibility(Lifecycle.Read)
  reportTarget: string;

  /** Installable updates grouped by the devices they target. May be empty. */
  installableUpdatesAndTargetDevices: InstallableUpdatesForTargetDevices[];
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
