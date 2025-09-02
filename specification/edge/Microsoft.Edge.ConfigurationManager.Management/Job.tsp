import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./Target.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("JobType for the job. Supports extensibility via string values.")
union JobType {
  string,

  @doc("A deployment job.")
  Deploy: "deploy",

  @doc("A publish job.")
  @added(Versions.v2025_08_01)
  Publish: "publish",

  @doc("A staging job.")
  Staging: "staging",

  @doc("A validation job.")
  ExternalValidation: "externalValidation",
}

@doc("Status of a job or job step.")
union JobStatus {
  string,

  /** The job or step is not started. */
  NotStarted: "NotStarted",

  /** The job or step is in progress. */
  InProgress: "InProgress",

  /** The job or step succeeded. */
  Succeeded: "Succeeded",

  /** The job or step failed. */
  Failed: "Failed",
}

@doc("Publish statistics for a job step, including total, success, and failed counts.")
@added(Versions.v2025_08_01)
model PublishJobStepStatistics extends JobStepStatisticsBase {
  @doc("Statistics type discriminator value")
  statisticsType: JobType.Publish;

  @doc("Total count of items processed in this step")
  totalCount?: int32;

  @doc("Count of successful items in this step")
  successCount?: int32;

  @doc("Count of failed items in this step")
  failedCount?: int32;
}

// Base model for polymorphic job step statistics
@doc("Base Job Step Statistics")
@discriminator("statisticsType")
model JobStepStatisticsBase {
  @doc("Statistics type discriminator value")
  statisticsType: JobType;
}

@doc("Deploy statistics for a job step, including total, success, and failed counts.")
model DeployJobStepStatistics extends JobStepStatisticsBase {
  @doc("Statistics type discriminator value")
  statisticsType: JobType.Deploy;

  @doc("Total count of items processed in this step")
  totalCount?: int32;

  @doc("Count of successful items in this step")
  successCount?: int32;

  @doc("Count of failed items in this step")
  failedCount?: int32;
}

// Union for polymorphic statistics
@doc("Polymorphic statistics for a job step.")
union JobStepStatistics {
  DeployJobStepStatistics,
  // Add future statistics models here
}

// Base model for polymorphic job parameters
@doc("Base Job Parameter")
@discriminator("jobType")
model JobParameterBase {
  @doc("Job type discriminator value")
  jobType: JobType;
}

@doc("Parameters for a deployment job.")
model DeployJobParameter extends JobParameterBase {
  @doc("Job type discriminator value")
  jobType: JobType.Deploy;

  parameter?: InstallSolutionParameter;
}

@doc("Parameters for a publish job.")
@added(Versions.v2025_08_01)
model PublishJobParameter extends JobParameterBase {
  @doc("Job type discriminator value")
  jobType: JobType.Publish;

  parameter?: SolutionVersionParameter;
}

@doc("Job Step")
model JobStep {
  @doc("Name of the step")
  name: string;

  @doc("Status of the step")
  status: JobStatus;

  @doc("Start time of the step (ISO8601)")
  startTime?: utcDateTime;

  @doc("End time of the step (ISO8601)")
  endTime?: utcDateTime;

  @doc("Message for the step")
  message?: string;

  @doc("Statistics for the step")
  statistics?: JobStepStatisticsBase;

  @doc("Nested substeps for this step")
  steps?: JobStep[];

  @doc("Error Details if any failure is there")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Properties of a Job resource, including type, status, parameters, steps, and error details.")
model JobProperties {
  @doc("The type of job.")
  jobType: JobType;

  @doc("Start time of the job (ISO8601).")
  startTime?: utcDateTime;

  @doc("End time of the job (ISO8601).")
  endTime?: utcDateTime;

  @doc("Status of the job.")
  status: JobStatus;

  @doc("Parameters for the job.")
  jobParameter?: JobParameterBase;

  @doc("Correlation ID for tracking.")
  correlationId?: string;

  @doc("Steps and substatuses for the job.")
  steps?: JobStep[];

  @doc("The OID or identity that triggered the job.")
  triggeredBy?: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Error Details if any failure is there")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Job extension resource for tracking job execution and substatuses.")
model Job is ExtensionResource<JobProperties> {
  ...ResourceNameParameter<
    Job,
    NamePattern = "^(?=.{3,60}$)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface Jobs {
  @doc("Get a Job resource")
  get is ArmResourceRead<Job>;

  @doc("List Jobs by parent resource")
  listByTarget is ArmResourceListByParent<Job>;
}
