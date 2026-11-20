import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EdgeOperator;

/** The time range and optional role filter for collecting logs. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The SDK entrypoint client.tsp applies the C# CollectLogsContent override without changing the REST model name."
model CollectLogsRequest {
  /** The start of the log collection time range, in UTC. */
  fromDate: utcDateTime;

  /** The end of the log collection time range, in UTC. Must be later than fromDate. */
  toDate: utcDateTime;

  /** The roles to collect logs from. Omit to use the service's default role selection. */
  filterRoles?: string[];
}

/** The time range, destination, and optional credentials for indirect log collection. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The SDK entrypoint client.tsp applies the C# CollectLogsIndirectContent override without changing the REST model name."
model CollectLogsIndirectRequest {
  /** The start of the log collection time range, in UTC. */
  fromDate: utcDateTime;

  /** The end of the log collection time range, in UTC. Must be later than fromDate. */
  toDate: utcDateTime;

  /**
   * The absolute UNC path to the destination file share where the collected logs
   * are saved, for example `\\fileserver\share\logs`.
   * The destination must be accessible to the log-collection backend.
   */
  @minLength(1)
  saveToPath: string;

  /** The user name used to access the destination path, when authentication is required. */
  userName?: string;

  /** The password used to access the destination path, when authentication is required. */
  @secret
  userPassword?: string;

  /** The roles to collect logs from. Omit to use the service's default role selection. */
  filterRoles?: string[];
}

/** The provisioning state of a log collection job. */
union LogCollectionProvisioningState {
  ResourceProvisioningState,

  /** Log collection is in progress. */
  Running: "Running",
}

/** The type of a log collection job. */
union LogCollectionJobType {
  string,

  /** The job was started on demand by a collectLogs or collectLogsIndirect request. */
  OnDemand: "OnDemand",

  /** The job was started by the log collection service on a schedule. */
  Scheduled: "Scheduled",
}

/** Where the collected logs are delivered. */
union LogCollectionStorageKind {
  string,

  /** The collected logs are sent to Azure. Used by jobs started with collectLogs. */
  Azure: "Azure",

  /** The collected logs are saved to a file share. Used by jobs started with collectLogsIndirect; the share is reported in saveToPath. */
  FileShare: "FileShare",
}

/** Error details reported by the log collection service. */
model LogCollectionErrorDetails {
  /** The service-defined error code. Omitted when no code is available. */
  @visibility(Lifecycle.Read)
  code?: string;

  /** The error message. Omitted when no message is available. */
  @visibility(Lifecycle.Read)
  message?: string;
}

/** Upload details reported by the log collection service. */
model LogCollectionUploadDetails {
  /** The upload start time in UTC. Omitted when unavailable. */
  @visibility(Lifecycle.Read)
  uploadStartTime?: utcDateTime;

  /** The size in megabytes of the collected logs, as reported by the log collection service. */
  @visibility(Lifecycle.Read)
  uploadSizeInMb?: int32;

  /** The number of collected log files, as reported by the log collection service. */
  @visibility(Lifecycle.Read)
  uploadNumberOfFiles?: int32;

  /** The directory containing the uploaded logs. Omitted when unavailable. */
  @visibility(Lifecycle.Read)
  uploadDirectory?: string;
}

/** The status and available history details of a log collection job. */
model LogCollectionProperties {
  /** The provisioning state derived from the log collection service's job state. */
  @visibility(Lifecycle.Read)
  provisioningState?: LogCollectionProvisioningState;

  /** The job start time in UTC, when available. */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** The job completion time in UTC, when available. */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /** The collection start time in UTC, when available in job history. */
  @visibility(Lifecycle.Read)
  collectionTime?: utcDateTime;

  /** The collection completion time in UTC, when available in job history. */
  @visibility(Lifecycle.Read)
  collectionEndTime?: utcDateTime;

  /** The requested start of the log time range in UTC, when available in job history. */
  @visibility(Lifecycle.Read)
  fromDate?: utcDateTime;

  /** The requested end of the log time range in UTC, when available in job history. */
  @visibility(Lifecycle.Read)
  toDate?: utcDateTime;

  /** The job type, when available in job history. */
  @visibility(Lifecycle.Read)
  jobType?: LogCollectionJobType;

  /** Where the collected logs are delivered, when available in job history. */
  @visibility(Lifecycle.Read)
  storageKind?: LogCollectionStorageKind;

  /**
   * The absolute UNC path to the destination file share where the collected logs
   * are saved, for example `\\fileserver\share\logs`.
   * Present only when storageKind is FileShare.
   */
  @visibility(Lifecycle.Read)
  saveToPath?: string;

  /** A free-text description of why the job ran, when available in job history. */
  @visibility(Lifecycle.Read)
  reason?: string;

  /** The error details associated with the job. Omitted when the service reports no error. */
  @visibility(Lifecycle.Read)
  error?: LogCollectionErrorDetails;

  /** The upload details associated with the job. Omitted when the service reports no upload details. */
  @visibility(Lifecycle.Read)
  uploadDetails?: LogCollectionUploadDetails;
}

/**
 * A read-only log collection job created by collectLogs or collectLogsIndirect.
 * The request subscription must be the Operator subscription; requests for other subscriptions are rejected.
 */
@subscriptionResource
model LogCollection is ProxyResource<LogCollectionProperties> {
  ...ResourceNameParameter<
    Resource = LogCollection,
    KeyName = "jobId",
    SegmentName = "logCollections",
    NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  >;
}

/** The earliest date for retrieving log collection job history. */
model LogCollectionHistoryParameters {
  /**
   * The earliest date and time in UTC for which job history is requested.
   * The downstream log collection service requires a history start time and supports no other filter criteria,
   * so this is a typed parameter rather than an OData $filter expression.
   */
  @query
  fromDate: utcDateTime;
}

/** A page of log collection job history. The service currently returns all matching jobs in a single page. */
model LogCollectionListResult {
  /** The log collection jobs in the requested history window. */
  @visibility(Lifecycle.Read)
  @pageItems
  value: LogCollection[];

  /** The URL of the next page of jobs. Omitted when all matching jobs have been returned. */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/** Read operations for log collection jobs in the Operator subscription. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Log collection jobs are service-created history records. Callers can read and list them but cannot create, update, or delete them directly."
@armResourceOperations
@tag("LogCollections")
interface LogCollections {
  /** Gets the status and available history details of a log collection job by its GUID identifier. */
  get is ArmResourceRead<LogCollection>;

  /** Lists log collection job history from the specified date and time. */
  listBySubscription is ArmResourceListByParent<
    LogCollection,
    Parameters = LogCollectionHistoryParameters,
    Response = ArmResponse<LogCollectionListResult>
  >;
}

/**
 * Asynchronous log collection actions in the Operator subscription.
 * Poll the Azure-AsyncOperation URL until completion. A successful operation status contains
 * properties.resourceId identifying the resulting logCollections resource, which can then be retrieved.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "These subscription-scoped provider actions are not actions on a log collection resource instance."
@tag("LogCollections")
interface LogCollectionActions {
  /** Starts collecting logs for the specified time range. Returns 202 Accepted with no response body. */
  @autoRoute
  @action("collectLogs")
  @useFinalStateVia("azure-async-operation")
  collectLogs is ArmProviderActionAsync<
    Request = CollectLogsRequest,
    Response = void,
    Scope = SubscriptionActionScope,
    LroHeaders = ArmCombinedLroHeaders<
      FinalResult = void,
      FinalUrlValue = url
    > &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Starts collecting logs to the specified destination path. Returns 202 Accepted with no response body. */
  @autoRoute
  @action("collectLogsIndirect")
  @useFinalStateVia("azure-async-operation")
  collectLogsIndirect is ArmProviderActionAsync<
    Request = CollectLogsIndirectRequest,
    Response = void,
    Scope = SubscriptionActionScope,
    LroHeaders = ArmCombinedLroHeaders<
      FinalResult = void,
      FinalUrlValue = url
    > &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
