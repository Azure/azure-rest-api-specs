import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace QuantumClient;

enum JobType {
  Unknown,
  QuantumComputing,
  Optimization,
}

enum JobStatus {
  Waiting,
  Executing,
  Succeeded,
  Failed,
  Cancelled,
}

enum ItemType {
  @doc("A program, problem, or application submitted for processing.") Job,
  @doc("A logical grouping of jobs.") Session,
}

enum JsonPatchOperation {
  add,
  remove,
  replace,
  move,
  copy,
  test,
}

enum ProviderAvailability {
  Available,
  Degraded,
  Unavailable,
}

enum TargetAvailability {
  Available,
  Degraded,
  Unavailable,
}

enum DimensionScope {
  Workspace,
  Subscription,
}

enum MeterPeriod {
  None,
  Monthly,
}

enum SessionJobFailurePolicy {
  @doc("New jobs submitted after a job fails will be rejected. ") Abort,
  @doc("New jobs submitted after a job fails will be accepted.") Continue,
}

enum SessionStatus {
  Waiting,
  Executing,
  Succeeded,
  Failed,
  `Failure(s)`,
  TimedOut,
}

@doc("List of job details.")
model JobDetailsList is Azure.Core.Page<JobDetails>;

@doc("Job details.")
model JobDetails extends ItemDetails {
  @doc("The type of job.")
  @visibility("read")
  jobType?: JobType;

  @doc("The ID of the session that the job is part of.")
  sessionId?: string;

  @doc("The blob container SAS uri, the container is used to host job data.")
  containerUri: string;

  @doc("""
The input blob SAS uri, if specified, it will override the default input blob
in the container.
""")
  inputDataUri?: string;

  @doc("The format of the input data.")
  inputDataFormat: string;

  @doc("""
The input parameters for the job. JSON object used by the target solver. It is
expected that the size of this object is small and only used to specify
parameters for the execution target, not the input data.
""")
  inputParams?: unknown;

  @doc("The status of the job.")
  @visibility("read")
  status?: JobStatus;

  @doc("""
The job metadata. Metadata provides client the ability to store client-specific
information
""")
  metadata?: Record<string>;

  @doc("""
The output blob SAS uri. When a job finishes successfully, results will be
uploaded to this blob.
""")
  outputDataUri?: string;

  @doc("The format of the output data.")
  outputDataFormat?: string;

  @doc("The time when a job was successfully cancelled.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancellationTime?: utcDateTime;

  @doc("Quantum computing data.")
  @visibility("read")
  quantumComputingData?: QuantumComputingData;

  @doc("List of user-supplied tags associated with the job.")
  tags?: string[];

  @doc("The type of item.")
  itemType: "Job";
}

@doc("Quantum computing data.")
model QuantumComputingData {
  @doc("The number of quantum computing items in the job.")
  count?: int32;
}

@doc("Item details. An item can be a job or a session.")
@discriminator("itemType")
model ItemDetails {
  @doc("The id of the item.")
  id: string;

  @doc("""
The name of the item. It is not required for the name to be unique and it's
only used for display purposes.
""")
  name: string;

  @doc("The unique identifier for the provider.")
  providerId: string;

  @doc("The target identifier to run the job.")
  target: string;

  @doc("The creation time of the item.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The time when the item began execution.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  beginExecutionTime?: utcDateTime;

  @doc("The time when the item finished execution.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endExecutionTime?: utcDateTime;

  @doc("""
The job cost billed by the provider. The final cost on your bill might be
slightly different due to added taxes and currency conversion rates.
""")
  costEstimate?: CostEstimate;

  @doc("An error response from Azure.")
  errorData?: ErrorData;
}

@doc("""
The job cost billed by the provider. The final cost on your bill might be
slightly different due to added taxes and currency conversion rates.
""")
model CostEstimate {
  @doc("The currency code.")
  currencyCode?: string;

  @doc("List of usage events")
  events?: UsageEvent[];

  @doc("The estimated total.")
  estimatedTotal?: float32;
}

@doc("Usage event details.")
model UsageEvent {
  @doc("The dimension id.")
  dimensionId?: string;

  @doc("The dimension name.")
  dimensionName?: string;

  @doc("The unit of measure.")
  measureUnit?: string;

  @doc("The amount billed.")
  amountBilled?: float32;

  @doc("The amount consumed.")
  amountConsumed?: float32;

  @doc("The unit price.")
  unitPrice?: float32;
}

@doc("An error response from Azure.")
model ErrorData {
  @doc("""
An identifier for the error. Codes are invariant and are intended to be
consumed programmatically.
""")
  code: string;

  @doc("""
A message describing the error, intended to be suitable for displaying in a
user interface.
""")
  message: string;
}

@doc("Error information returned by the API")
@error
model RestError {
  @doc("An error response from Azure.")
  error: ErrorData;
}

@doc("A JSONPatch document as defined by RFC 6902")
model JsonPatchDocument {
  @doc("The operation to be performed.")
  `op`: JsonPatchOperation;

  @doc("A JSON-Pointer.")
  path: string;

  @doc("A value to be used in the operation on the path.")
  value?: unknown;

  @doc("Optional field used in copy and move operations.")
  from?: string;
}

@doc("Providers status.")
model ProviderStatusList is Azure.Core.Page<ProviderStatus>;

@doc("Providers status.")
model ProviderStatus {
  @doc("Provider id.")
  id?: string;

  @doc("Provider availability.")
  currentAvailability?: ProviderAvailability;
  targets?: TargetStatus[];
}

@doc("Target status.")
model TargetStatus {
  @doc("Target id.")
  id?: string;

  @doc("Target availability.")
  currentAvailability?: TargetAvailability;

  @doc("Average queue time in seconds.")
  averageQueueTime?: int32;

  @doc("A page with detailed status of the provider.")
  statusPage?: string;
}

@doc("Blob details.")
model BlobDetails {
  @doc("The container name.")
  containerName: string;

  @doc("The blob name.")
  blobName?: string;
}

@doc("Get SAS URL operation response.")
model SasUriResponse {
  @doc("A URL with a SAS token to upload a blob for execution in the given workspace.")
  sasUri?: string;
}

@doc("List of quotas.")
model QuotaList is Azure.Core.Page<Quota>;

@doc("Quota information.")
model Quota {
  @doc("The name of the dimension associated with the quota.")
  dimension?: string;

  @doc("The scope at which the quota is applied.")
  scope?: DimensionScope;

  @doc("The unique identifier for the provider.")
  providerId?: string;

  @doc("The amount of the usage that has been applied for the current period.")
  utilization?: float32;

  @doc("""
The amount of the usage that has been reserved but not applied for the current
period.
""")
  holds?: float32;

  @doc("The maximum amount of usage allowed for the current period.")
  limit?: float32;

  @doc("""
The time period in which the quota's underlying meter is accumulated. Based on
calendar year. 'None' is used for concurrent quotas.
""")
  period?: MeterPeriod;
}

@doc("List of session details.")
model SessionDetailsList is Azure.Core.Page<SessionDetails>;

@doc("Session details.")
model SessionDetails extends ItemDetails {
  @doc("Policy controlling the behavior of the Session when a job in the session fails.")
  jobFailurePolicy?: SessionJobFailurePolicy;

  @doc("The status of the session.")
  @visibility("read")
  status?: SessionStatus;

  @doc("The type of item.")
  itemType: "Session";
}

@doc("List of item details.")
model ItemDetailsList is Azure.Core.Page<ItemDetails>;
