import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Job Statuses")
union JobStatus {
  @doc("The job has not started yet.")
  NotStarted: "NotStarted",

  @doc("The job is pending execution, awaiting the completion of dependent stages.")
  Pending: "Pending",

  @doc("The job is currently in progress.")
  InProgress: "InProgress",

  @doc("The job has been completed successfully.")
  Completed: "Completed",

  @doc("The job has been completed with warnings.")
  CompletedWithWarnings: "CompletedWithWarnings",

  @doc("The job has failed.")
  Failed: "Failed",

  @doc("The job skipped for the resource (resource not qualified or not applicable).")
  Skipped: "Skipped",

  @doc("The job is in the process of being cancelled.")
  Cancelling: "Cancelling",

  @doc("The job has been cancelled.")
  Cancelled: "Cancelled",

  @doc("The job is currently paused.")
  Paused: "Paused",

  string,
}

@doc("Job TriggeredBy")
union JobTriggeredBy {
  @doc("Triggered by the system.")
  System: "System",

  @doc("Triggered by the user.")
  User: "User",

  string,
}

@doc("Job User's Comment.")
model JobUserComment {
  @doc("The time of user comment.")
  @visibility(Lifecycle.Read)
  commentTime?: utcDateTime;

  @doc("User Comment")
  @visibility(Lifecycle.Read)
  comments?: string;
}

@doc("Job task details.")
model JobTaskDetail {
  ...JobExecutionDetails;

  @doc("Identifier of the task.")
  @visibility(Lifecycle.Read)
  taskId?: string;

  @doc("Friendly name of the task.")
  @visibility(Lifecycle.Read)
  taskName?: string;

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Identifiers of linked jobs to this task.")
  @visibility(Lifecycle.Read)
  linkedJobIds?: armResourceIdentifier[];

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("User Comments.")
  @visibility(Lifecycle.Read)
  userComments?: JobUserComment[];

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("List of sub-tasks associated with this job.")
  @visibility(Lifecycle.Read)
  subTasksList?: JobTaskDetail[];
}

@doc("Additional information for job.")
model JobExtendedInfo {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("List of tasks associated with this job.")
  @visibility(Lifecycle.Read)
  tasksList?: JobTaskDetail[];

  @doc("Non localized error message on job execution.")
  @visibility(Lifecycle.Read)
  dynamicErrorMessage?: string;
}

@doc("Job Error information.")
model JobErrorInfo {
  @doc("A code representing the error.")
  @visibility(Lifecycle.Read)
  errorCode?: string;

  @doc("A detailed message explaining the error.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("A list of recommendations to resolve the error.")
  @visibility(Lifecycle.Read)
  recommendations?: string[];
}

@doc("Job Retry Details.")
model JobRetryDetails {
  ...JobExecutionDetails;

  @doc("The retry attempt number of the job.")
  retryAttempt: int32;
}

@doc("Job Execution Details.")
model JobExecutionDetails {
  @doc("The current status of the job execution.")
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  @doc("The start time of the job execution.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("The end time of the job execution.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The time elapsed during the execution of this job.")
  @visibility(Lifecycle.Read)
  duration?: duration;

  @doc("Details of any errors that occurred during the execution of this job.")
  errorDetails?: JobErrorInfo;
}

// Define the main model
@doc("Definition of a job, including its type, status, timing, and additional details.")
model BaseJobProperties {
  ...JobExecutionDetails;

  @doc("The resource for which this job was created. This is typically the resource that the job is intended to manage or operate on.")
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;

  @doc("The operation that this job is intended to perform.")
  @visibility(Lifecycle.Read)
  operation?: string;

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Details of any retries that have been attempted for this job.")
  retryDetails?: JobRetryDetails[];

  @doc("Additional information about the job.")
  jobExtendedInfo?: JobExtendedInfo;

  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("User Comments.")
  @visibility(Lifecycle.Read)
  userComments?: JobUserComment[];
}

// Define the main model
@doc("Definition of a job, including its type, status, timing, and additional details.")
@discriminator("jobType")
model JobProperties {
  ...BaseJobProperties;

  @doc("The type of job.")
  @visibility(Lifecycle.Read)
  jobType?: JobType;

  @doc("Indicates whether the job was triggered by the system or a user.")
  @visibility(Lifecycle.Read)
  triggeredBy?: JobTriggeredBy;
}
