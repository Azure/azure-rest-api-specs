import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.ResourceManager;
using Versioning;

namespace Microsoft.NetApp;

/**
 * File extension with length constraints
 */
@added(Versions.v2025_09_01_preview)
@maxLength(1024)
@minLength(1)
scalar Extensions extends string;

/**
 * Advanced Ransomware Protection (ARP) report
 * Get details of the specified Advanced Ransomware Protection report (ARP).
 * ARP reports are created with a list of suspected files when it detects any combination of high data entropy, abnormal volume activity with data encryption, and unusual file extensions.
 * ARP creates snapshots named Anti_ransomware_backup when it detects a potential ransomware threat. You can use one of these ARP snapshots or another snapshot of your volume to restore data.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(Volume)
model RansomwareReport
  is Azure.ResourceManager.ProxyResource<RansomwareReportProperties> {
  ...ResourceNameParameter<
    Resource = RansomwareReport,
    KeyName = "ransomwareReportName",
    SegmentName = "ransomwareReports",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * List of Advanced Ransomware Protection (ARP) reports
 */
@added(Versions.v2025_09_01_preview)
model RansomwareReportsList is Azure.Core.Page<RansomwareReport>;

/**
 * Advanced Ransomware Protection (ARP) report properties.
 *
 * Evaluate the report to determine whether the activity is acceptable (false positive) or whether an attack seems malicious using the ClearSuspects operation.
 *
 * Advanced Ransomware Protection (ARP) creates snapshots named Anti_ransomware_backup when it detects a potential ransomware threat. You can use one of the ARP snapshots or another snapshot of your volume to restore data.
 */
@added(Versions.v2025_09_01_preview)
model RansomwareReportProperties {
  /**
   * The creation date and time of the report
   */
  @visibility(Lifecycle.Read)
  eventTime?: utcDateTime;

  /**
   * State of the Advanced Ransomware Protection (ARP) report
   */
  @visibility(Lifecycle.Read)
  state?: RansomwareReportState;

  /**
   * Severity of the Advanced Ransomware Protection (ARP) report
   */
  @visibility(Lifecycle.Read)
  severity?: RansomwareReportSeverity;

  /**
   * The number of cleared suspects identified by the ARP report
   */
  @visibility(Lifecycle.Read)
  clearedCount?: int32;

  /**
   * The number of suspects identified by the ARP report
   */
  @visibility(Lifecycle.Read)
  reportedCount?: int32;

  /**
   * Suspects identified in an ARP report
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["extension"])
  suspects?: RansomwareSuspects[];

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Clear suspects for Advanced Ransomware Protection (ARP) report
 */
@added(Versions.v2025_09_01_preview)
model RansomwareSuspectsClearRequest {
  /**
   * ARP report suspect resolution
   */
  resolution: RansomwareSuspectResolution;

  /**
   * List of file extensions resolved (PotentialThreat or FalsePositive)
   */
  @minItems(1)
  extensions: Extensions[];
}

/**
 * List of suspects identified in an Advanced Ransomware Protection (ARP) report
 */
@added(Versions.v2025_09_01_preview)
model RansomwareSuspects {
  /**
   * Suspect File extension
   */
  @visibility(Lifecycle.Read)
  extension?: string;

  /**
   * ARP report suspect resolution
   */
  @visibility(Lifecycle.Read)
  resolution?: RansomwareSuspectResolution;

  /**
   * The number of suspect files at the time of ARP report, this number can change as files get created and report status progresses
   */
  @visibility(Lifecycle.Read)
  fileCount?: int32;

  /**
   * Suspect files
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["suspectFileName"])
  suspectFiles?: SuspectFile[];
}

/**
 * Suspect file information
 */
@added(Versions.v2025_09_01_preview)
model SuspectFile {
  /**
   * Suspect filename
   */
  @visibility(Lifecycle.Read)
  suspectFileName?: string;

  /**
   * The creation date and time of the file
   */
  @visibility(Lifecycle.Read)
  fileTimestamp?: utcDateTime;
}

/**
 * Severity of the Advanced Ransomware Protection (ARP) report
 */
@added(Versions.v2025_09_01_preview)
union RansomwareReportSeverity {
  string,

  /**
   * No data is suspected for ransomware activity
   */
  None: "None",

  /**
   * Low attack probability
   */
  Low: "Low",

  /**
   * Moderate attack probability
   */
  Moderate: "Moderate",

  /**
   * High amount of data is suspected for ransomware activity
   */
  High: "High",
}

/**
 * State of the Advanced Ransomware Protection (ARP) report
 */
@added(Versions.v2025_09_01_preview)
union RansomwareReportState {
  string,

  /**
   * The ARP report has been created. Take action by running clearsuspects marking suspects as FalsePositive or PotentialThreats
   */
  Active: "Active",

  /**
   * The ARP Report has been resolved
   */
  Resolved: "Resolved",
}

/**
 * ARP report suspect resolution
 */
@added(Versions.v2025_09_01_preview)
union RansomwareSuspectResolution {
  string,

  /**
   * The identified file type is unexpected in your workload and should be treated as a potential attack
   */
  PotentialThreat: "PotentialThreat",

  /**
   * The identified file type is expected in your workload and can be ignored
   */
  FalsePositive: "FalsePositive",
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface RansomwareReports {
  /**
   * Get details of the specified ransomware report (ARP)
   * ARP reports are created with a list of suspected files when it detects any combination of high data entropy, abnormal volume activity with data encryption, and unusual file extensions.
   * ARP creates snapshots named Anti_ransomware_backup when it detects a potential ransomware threat. You can use one of these ARP snapshots or another snapshot of your volume to restore data.
   */
  get is ArmResourceRead<RansomwareReport>;

  /**
   * List all ransomware reports for the volume
   * Returns a list of the Advanced Ransomware Protection (ARP) reports for the volume.
   * ARP reports are created with a list of suspected files when it detects any combination of high data entropy, abnormal volume activity with data encryption, and unusual file extensions.
   * ARP creates snapshots named Anti_ransomware_backup when it detects a potential ransomware threat. You can use one of these ARP snapshots or another snapshot of your volume to restore data"
   */
  list is ArmResourceListByParent<
    RansomwareReport,
    Response = ArmResponse<RansomwareReportsList>
  >;

  /**
   * Clear ransomware suspects for the given Advanced Ransomware Protection report. You should evaluate the report to determine whether the activity is acceptable (false positive) or whether an attack seems malicious.
   * ARP creates snapshots named Anti_ransomware_backup when it detects a potential ransomware threat. You can use one of these ARP snapshots or another snapshot of your volume to restore data",
   */
  clearSuspects is ArmResourceActionNoResponseContentAsync<
    RansomwareReport,
    RansomwareSuspectsClearRequest
  >;
}

@@maxLength(RansomwareReport.name, 64);
@@minLength(RansomwareReport.name, 1);
@@doc(RansomwareReport.name, "The name of the ransomware report");
@@doc(RansomwareReport.properties,
  "Advanced Ransomware Protection reports Properties"
);
@@doc(RansomwareReports.clearSuspects::parameters.body,
  "Clear suspects request object supplied in the body of the operation."
);
