import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./drillRunChildJob.models.tsp";
import "./drillRunResources.models.tsp";
import "./drillRunChaosJob.models.tsp";
import "./drillRunChaosJobResources.models.tsp";
import "./drillRunChaosJobChildJob.models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the DrillRun Object.
 */
@parentResource(Drill)
@doc("DrillRun resource.")
model DrillRun is ProxyResource<DrillRunProperties> {
  @doc("The name of the DrillRun (GUID).")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("drillRunName")
  @segment("drillRuns")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of the Resiliency DrillRun.")
model DrillRunProperties extends JobProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobType: JobType.DrillRun;

  @doc("Parent Drill resource.")
  @visibility(Lifecycle.Read)
  drillId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/drills";
    }
  ]>;

  @doc("Measured aggregated Metric value through the drill run.")
  @removed(Versions.v2026_04_01_preview)
  @visibility(Lifecycle.Read)
  metricValue?: string;

  @doc("Measured health status through the drill run.")
  @removed(Versions.v2026_04_01_preview)
  @visibility(Lifecycle.Read)
  healthStatus?: HealthStatus;

  @doc("Drill mode.")
  @visibility(Lifecycle.Read)
  drillMode?: DrillMode;

  @doc("Attestation of this Drill Run.")
  @visibility(Lifecycle.Read)
  attestation?: DrillAttestation;

  @doc("Notes for this Drill.")
  @visibility(Lifecycle.Read)
  notes?: string[];

  @doc("Matrix of Actions supported on Operations.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedVerbsForStage?: SupportedVerbsForStage[];

  @doc("The currently active operationID on this Drill Run. There can be only one active.")
  @visibility(Lifecycle.Read)
  currentActiveOperationId?: string;

  @doc("Summary of report generation for this Drill Run.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  report?: DrillReportSummary;
}

@added(Versions.v2026_08_31_preview)
@doc("Public, read-only summary of report generation for a Drill Run. Exposes status and pointers only - the report content and internal storage locations are never surfaced.")
model DrillReportSummary {
  @doc("Overall report generation status for the Drill Run.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  generationStatus?: DrillReportGenerationStatus;

  @doc("Per-stage report generation statuses.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  stageStatuses?: ReportStageStatus[];

  @doc("Formats the report is currently available for download in.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  availableFormats?: DrillReportFormat[];

  @doc("Timestamp of the last successful report generation.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  lastGeneratedTimestamp?: utcDateTime;

  @doc("Schema version of the generated report content.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  schemaVersion?: string;

  @doc("Finalization state of the report. A finalized report is immutable.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  finalizationState?: DrillReportFinalizationState;

  @doc("Error from the last failed report generation attempt.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  lastError?: ErrorDetails;
}

@added(Versions.v2026_08_31_preview)
@doc("Report generation status for a single Drill Run stage.")
model ReportStageStatus {
  @doc("Name of the Drill Run stage this status applies to.")
  @added(Versions.v2026_08_31_preview)
  drillRunStage: DrillRunSubtasks;

  @doc("Report generation status for this stage.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  generationStatus?: DrillReportGenerationStatus;

  @doc("Timestamp of the last report generation attempt for this stage.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  lastAttemptTimestamp?: utcDateTime;

  @doc("Error from the last failed report generation attempt for this stage.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  lastError?: ErrorDetails;
}

@added(Versions.v2026_08_31_preview)
@doc("Request to mint a short-lived, read-only download URL for a Drill Run report.")
model ListReportDownloadUrlRequest {
  @doc("Format of the report to download. Defaults to Html when not specified.")
  @added(Versions.v2026_08_31_preview)
  format?: DrillReportFormat;
}

@added(Versions.v2026_08_31_preview)
@doc("Response containing a short-lived, read-only download URL for a Drill Run report.")
model ListReportDownloadUrlResponse {
  @doc("Format of the report the download URL refers to.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  format?: DrillReportFormat;

  @doc("Short-lived, read-only URL to download the report.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  downloadUrl?: url;

  @doc("Timestamp at which the download URL expires.")
  @added(Versions.v2026_08_31_preview)
  @visibility(Lifecycle.Read)
  expiryTimestamp?: utcDateTime;
}

@doc("Request body for AddNotes API.")
model DrillRunAddNotesRequest {
  @doc("The notes string.")
  notes?: string;

  @doc("System generated current Timestamp.")
  @visibility(Lifecycle.Read)
  timestamp?: utcDateTime;

  @doc("System generated Object Id of the notes author.")
  @visibility(Lifecycle.Read)
  author?: string;
}

@doc("Request body for Failover API.")
model DrillRunFailoverRequest {
  @doc("AutoFailover - whether to pause between Fault and Failover for manual input.")
  autoFailover: AutoFailover;

  @doc("The failover properties.")
  failoverProperties: FailoverRequest;
}

@added(Versions.v2026_06_01_preview)
@doc("Request body for Reprotect API.")
model DrillRunReprotectRequest {
  @doc("The reprotect properties.")
  reprotectProperties: ReprotectRequest;
}

@doc("Request body for TestFailover API.")
@removed(Versions.v2026_04_01_preview)
model DrillRunTestFailoverRequest {
  @doc("The failover properties.")
  failoverProperties: FailoverRequest;
}

@doc("Request body for TestFailoverCleanup API.")
@removed(Versions.v2026_04_01_preview)
model DrillRunTestFailoverCleanupRequest {
  @doc("Comments for the request.")
  comments?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request body for TestFailoverCleanup API.")
model DrillRunActionResponse {
  @doc("JobId of the RO job.")
  @visibility(Lifecycle.Read)
  jobId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryJobs";
    }
  ]>;
}

@doc("Request body for MarkAsComplete API.")
model MarkAsCompleteRequest {
  @doc("State of the Drill Run.")
  drillRunStage: DrillRunSubtasks;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response body for MarkAsComplete API.")
model MarkAsCompleteResponse {
  @doc("Matrix of Actions supported on Operations.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  supportedVerbsForStage?: SupportedVerbsForStage[];
}

@doc("Model for supported verbs for stage.")
model SupportedVerbsForStage {
  @doc("Name of stage.")
  drillRunStage: DrillRunSubtasks;

  @doc("Supported Verbs for stage.")
  supportedVerbs: DrillRunOperationVerbs[];
}
