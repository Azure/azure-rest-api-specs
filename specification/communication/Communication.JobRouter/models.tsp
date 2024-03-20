import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.Reflection;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using Azure.ClientGenerator.Core;

@versioned(AzureCommunicationRoutingService.Versions)
namespace AzureCommunicationRoutingService;

@doc("Provides the 'Last-Modified' header to enable conditional (cached) requests")
model LastModifiedResponseEnvelope {
  @header("Last-Modified")
  @visibility("read")
  @doc("The last modified timestamp.")
  @encode("rfc7231")
  lastModifiedTimestamp?: utcDateTime;
}

// https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#conditional-requests

@doc("Provides the 'If-*' headers to enable conditional (cached) responses for JobRouter.")
model RouterConditionalRequestHeaders {
  @visibility("read", "query", "create", "update", "delete")
  @header("If-Match")
  @doc("The request should only proceed if an entity matches this string.")
  ifMatch?: string;

  @visibility("read", "query", "create", "update", "delete")
  @header("If-Unmodified-Since")
  @doc("The request should only proceed if the entity was not modified after this time.")
  @encode("rfc7231")
  ifUnmodifiedSince?: utcDateTime;
}

/**
 * Provides conditional request headers for requests and ETag headers for responses for JobRouter.
 * JobRouter support conditional updates based on 'If-Match' and/or 'If-Unmodified-Since' headers only.
 * @template TVersionAdded The version when the trait was added to the specification.
 *           Leave this empty if the trait is always supported.
 */
@trait("ConditionalRequests")
@traitAdded(TVersionAdded)
model SupportsRouterConditionalPatchUpdateRequests<TVersionAdded extends EnumMember | null = null> {
  #suppress "@azure-tools/typespec-providerhub/no-inline-model" "This inline model is never used directly in operations."
  conditionalRequests: {
    @traitContext(TraitContext.Update)
    @traitLocation(TraitLocation.Parameters)
    parameters: RouterConditionalRequestHeaders;
  };
}

@trait("RouterReturnConditionalResponseHeaders")
@traitAdded(TVersionAdded)
model RouterReturnConditionalResponseHeaders<TVersionAdded extends EnumMember | null = null> {
  conditionalResponseHeaders: {
    @traitContext(TraitContext.Create | TraitContext.Update | TraitContext.Read)
    @traitLocation(TraitLocation.Response)
    response: EtagResponseEnvelope & LastModifiedResponseEnvelope;
  };
}

@doc("Describes the various status of a job.")
union RouterJobStatus {
  string,

  @doc("Job is waiting to be classified.")
  "pendingClassification",

  @doc("Job has been queued.")
  "queued",

  @doc("Job has been assigned to a worker.")
  "assigned",

  @doc("Job has been completed by a worker.")
  "completed",

  @doc("Job has been closed by a worker.")
  "closed",

  @doc("Job has been cancelled.")
  "cancelled",

  @doc("Classification process failed for the job.")
  "classificationFailed",

  @doc("Job has been created.")
  "created",

  @doc("Job has been created but not been scheduled yet.")
  "pendingSchedule",

  @doc("Job has been scheduled successfully.")
  "scheduled",

  @doc("Job scheduling failed.")
  "scheduleFailed",

  @doc("Job is in a suspended state and waiting for an update.")
  "waitingForActivation",
}

@doc("Describes supported operations on label values.")
union LabelOperator {
  string,

  @doc("Equal.")
  "equal",

  @doc("Not Equal.")
  "notEqual",

  @doc("Less than.")
  "lessThan",

  @doc("Less than or equal.")
  "lessThanOrEqual",

  @doc("Greater than.")
  "greaterThan",

  @doc("Greater than or equal.")
  "greaterThanOrEqual",
}

@doc("Describes the status of a worker selector.")
union RouterWorkerSelectorStatus {
  string,

  @doc("Worker selector is valid.")
  "active",

  @doc("Worker selector is not valid.")
  "expired",
}

@doc("Enums used to filters jobs by status.")
union RouterJobStatusSelector {
  string,

  @doc("Default")
  all: "all",

  @doc("Job is waiting to be classified.")
  pendingClassification: "pendingClassification",

  @doc("Job has been queued.")
  queued: "queued",

  @doc("Job has been assigned to a worker.")
  assigned: "assigned",

  @doc("Job has been completed by a worker.")
  completed: "completed",

  @doc("Job has been closed by a worker.")
  closed: "closed",

  @doc("Job has been cancelled.")
  cancelled: "cancelled",

  @doc("Classification process failed for the job.")
  classificationFailed: "classificationFailed",

  @doc("Job has been created.")
  created: "created",

  @doc("Job has been created but not been scheduled yet.")
  pendingSchedule: "pendingSchedule",

  @doc("Job has been scheduled successfully.")
  scheduled: "scheduled",

  @doc("Job scheduling failed.")
  scheduleFailed: "scheduleFailed",

  @doc("Job is in a suspended state and waiting for an update.")
  waitingForActivation: "waitingForActivation",

  @doc("Job is in a state of PendingClassification or Queued or Assigned or ClassificationFailed or Completed or PendingSchedule or Scheduled or ScheduleFailed or WaitingForActivation.")
  active: "active",
}

@doc("Enums for worker states.")
union RouterWorkerState {
  string,

  @doc("Worker is active and available to take offers.")
  "active",

  @doc("Worker is not active, if there are existing offers they are being revoked. No new offers are sent.")
  "draining",

  @doc("Worker is not active. No new offers are sent.")
  "inactive",
}

@doc("Enums used to filters workers by state")
union RouterWorkerStateSelector {
  string,

  @doc("Worker is active and available to take offers.")
  active: "active",

  @doc("Worker is not active, if there are existing offers they are being revoked. No new offers are sent.")
  draining: "draining",

  @doc("Worker is not active. No new offers are sent.")
  inactive: "inactive",

  @doc("Worker is active or draining or inactive.")
  all: "all",
}

@doc("Supported parameters for scoring workers used with BestWorkerMode.")
union ScoringRuleParameterSelector {
  string,

  @doc("Parameter to add job labels to scoring payload.  Property is sent as `job`.")
  jobLabels: "jobLabels",

  @doc("Parameter to add worker selectors from a job to scoring payload.  Property is sent as `selectors`.")
  workerSelectors: "workerSelectors",
}

@doc("Available expression languages that can be configured.")
union ExpressionRouterRuleLanguage {
  string,

  @doc("PowerFx")
  "powerFx",
}

@doc("Discriminators for supported matching mode types.")
union JobMatchingModeKind {
  string,

  @doc("Discriminator value for QueueAndMatchMode.")
  queueAndMatch: "queueAndMatch",

  @doc("Discriminator value for ScheduleAndSuspendMode.")
  scheduleAndSuspend: "scheduleAndSuspend",

  @doc("Discriminator value for SuspendMode.")
  suspend: "suspend",
}

@doc("Discriminators for supported router rule types.")
union RouterRuleKind {
  string,

  @doc("Discriminator value for DirectMapRouterRule.")
  directMap: "directMap",

  @doc("Discriminator value for ExpressionRouterRule.")
  expression: "expression",

  @doc("Discriminator value for FunctionRouterRule.")
  function: "function",

  @doc("Discriminator value for StaticRouterRule.")
  static: "static",

  @doc("Discriminator value for WebhookRouterRule.")
  webhook: "webhook",
}

@doc("Discriminators for supported distribution mode types.")
union DistributionModeKind {
  string,

  @doc("Discriminator value for BestWorkerMode.")
  bestWorker: "bestWorker",

  @doc("Discriminator value for LongestIdleMode.")
  longestIdle: "longestIdle",

  @doc("Discriminator value for RoundRobinMode.")
  roundRobin: "roundRobin",
}

@doc("Discriminators for supported exception trigger types.")
union ExceptionTriggerKind {
  string,

  @doc("Discriminator value for QueueLengthExceptionTrigger.")
  queueLength: "queueLength",

  @doc("Discriminator value for WaitTimeExceptionTrigger.")
  waitTime: "waitTime",
}

@doc("Discriminators for supported exception action types.")
union ExceptionActionKind {
  string,

  @doc("Discriminator value for CancelExceptionAction.")
  cancel: "cancel",

  @doc("Discriminator value for ManualReclassifyExceptionAction.")
  manualReclassify: "manualReclassify",

  @doc("Discriminator value for ReclassifyExceptionAction.")
  reclassify: "reclassify",
}

@doc("Discriminators for supported queue selector attachment types.")
union QueueSelectorAttachmentKind {
  string,

  @doc("Discriminator value for ConditionalQueueSelectorAttachment.")
  conditional: "conditional",

  @doc("Discriminator value for PassThroughQueueSelectorAttachment.")
  passThrough: "passThrough",

  @doc("Discriminator value for RuleEngineQueueSelectorAttachment.")
  ruleEngine: "ruleEngine",

  @doc("Discriminator value for StaticQueueSelectorAttachment.")
  static: "static",

  @doc("Discriminator value for WeightedAllocationQueueSelectorAttachment.")
  weightedAllocation: "weightedAllocation",
}

@doc("Discriminators for supported worker selector attachment types.")
union WorkerSelectorAttachmentKind {
  string,

  @doc("Discriminator value for ConditionalWorkerSelectorAttachment.")
  conditional: "conditional",

  @doc("Discriminator value for PassThroughWorkerSelectorAttachment.")
  passThrough: "passThrough",

  @doc("Discriminator value for RuleEngineWorkerSelectorAttachment.")
  ruleEngine: "ruleEngine",

  @doc("Discriminator value for StaticWorkerSelectorAttachment.")
  static: "static",

  @doc("Discriminator value for WeightedAllocationWorkerSelectorAttachment.")
  weightedAllocation: "weightedAllocation",
}

@clientName("ClassificationPolicyInternal", "java")
@resource("routing/classificationPolicies")
@doc("A container for the rules that govern how jobs are classified.")
model ClassificationPolicy {
  ...EtagProperty;

  @key("classificationPolicyId")
  @doc("Id of a classification policy.")
  @visibility("read")
  id: string;

  @doc("Friendly name of this policy.")
  name?: string;

  @doc("Id of a fallback queue to select if queue selector attachments doesn't find a match.")
  fallbackQueueId?: string;

  @doc("Queue selector attachments used to resolve a queue for a job.")
  queueSelectorAttachments?: QueueSelectorAttachment[];

  @doc("A rule to determine a priority score for a job.")
  prioritizationRule?: RouterRule;

  @doc("Worker selector attachments used to attach worker selectors to a job.")
  workerSelectorAttachments?: WorkerSelectorAttachment[];
}

@clientName("RouterRuleInternal", "java")
@doc("""
A rule of one of the following types:
StaticRule:  A rule providing static rules that always return the same result, regardless of input.
DirectMapRule:  A rule that return the same labels as the input labels.
ExpressionRule: A rule providing inline expression rules.
FunctionRule: A rule providing a binding to an HTTP Triggered Azure Function.
WebhookRule: A rule providing a binding to a webserver following OAuth2.0 authentication protocol.
""")
@discriminator("kind")
model RouterRule {
  @doc("The type discriminator describing a sub-type of RouterRule")
  kind: RouterRuleKind;
}

@clientName("DistributionPolicyInternal", "java")
@resource("routing/distributionPolicies")
@doc("Policy governing how jobs are distributed to workers")
model DistributionPolicy {
  ...EtagProperty;

  @key("distributionPolicyId")
  @doc("Id of a distribution policy.")
  @visibility("read")
  id: string;

  @doc("Friendly name of this policy.")
  name?: string;

  @doc("Number of seconds after which any offers created under this policy will be expired.")
  offerExpiresAfterSeconds?: float64;

  @doc("Mode governing the specific distribution method.")
  mode?: DistributionMode;
}

@clientName("DistributionModeInternal", "java")
@doc("Abstract base class for defining a distribution mode.")
@discriminator("kind")
model DistributionMode {
  @doc("Governs the minimum desired number of active concurrent offers a job can have.")
  minConcurrentOffers?: int32 = 1;

  @doc("Governs the maximum number of active concurrent offers a job can have.")
  maxConcurrentOffers?: int32 = 1;

  @doc("If set to true, then router will match workers to jobs even if they don't match label selectors. Warning: You may get workers that are not qualified for a job they are matched with if you set this variable to true. This flag is intended more for temporary usage. By default, set to false.")
  bypassSelectors?: boolean = false;

  @doc("The type discriminator describing a sub-type of DistributionMode.")
  kind: DistributionModeKind;
}

@clientName("ExceptionPolicyInternal", "java")
@resource("routing/exceptionPolicies")
@doc("A policy that defines actions to execute when exception are triggered.")
model ExceptionPolicy {
  ...EtagProperty;

  @key("exceptionPolicyId")
  @doc("Id of an exception policy.")
  @visibility("read")
  id: string;

  @doc("Friendly name of this policy.")
  name?: string;

  @doc("A collection of exception rules on the exception policy.")
  exceptionRules?: ExceptionRule[];
}

@clientName("ExceptionRuleInternal", "java")
@doc("A rule that defines actions to execute upon a specific trigger.")
model ExceptionRule {
  @doc("Id of an exception rule.")
  id: string;

  @doc("The trigger for this exception rule.")
  trigger: ExceptionTrigger;

  @doc("A collection of actions to perform once the exception is triggered.")
  actions: ExceptionAction[];
}

@clientName("ExceptionTriggerInternal", "java")
@doc("Abstract base class for defining a trigger for exception rules.")
@discriminator("kind")
model ExceptionTrigger {
  @doc("The type discriminator describing a sub-type of ExceptionTrigger.")
  kind: ExceptionTriggerKind;
}

@doc("A note attached to a job.")
model RouterJobNote {
  @doc("The message contained in the note.")
  message: string;

  @doc("The time at which the note was added in UTC. If not provided, will default to the current time.")
  addedAt?: utcDateTime;
}

@clientName("RouterJobInternal", "java")
@resource("routing/jobs")
@doc("A unit of work to be routed")
model RouterJob {
  ...EtagProperty;

  @key("jobId")
  @doc("Id of a job.")
  @visibility("read")
  id: string;

  @doc("Reference to an external parent context, eg. call ID.")
  channelReference?: string;

  @doc("The status of the job.")
  @visibility("read")
  status?: RouterJobStatus;

  @doc("Timestamp a job was queued in UTC.")
  @visibility("read")
  enqueuedAt?: utcDateTime;

  @doc("The channel identifier. eg. voice, chat, etc.")
  channelId?: string;

  @doc("Id of a classification policy used for classifying this job.")
  classificationPolicyId?: string;

  @doc("Id of a queue that this job is queued to.")
  queueId?: string;

  @doc("Priority of this job. Value must be between -100 to 100.")
  priority?: int32;

  @doc("Reason code for cancelled or closed jobs.")
  dispositionCode?: string;

  @doc("A collection of manually specified worker selectors, which a worker must satisfy in order to process this job.")
  requestedWorkerSelectors?: RouterWorkerSelector[];

  @doc("A collection of worker selectors attached by a classification policy, which a worker must satisfy in order to process this job.")
  @visibility("read")
  attachedWorkerSelectors?: RouterWorkerSelector[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("A set of key/value pairs that are identifying attributes used by the rules engines to make decisions. Values must be primitive values - number, string, boolean.")
  labels?: Record<unknown>;

  @doc("A collection of the assignments of the job. Key is AssignmentId.")
  @visibility("read")
  assignments?: Record<RouterJobAssignment>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("A set of non-identifying attributes attached to this job. Values must be primitive values - number, string, boolean.")
  tags?: Record<unknown>;

  @doc("Notes attached to a job, sorted by timestamp.")
  notes?: RouterJobNote[];

  @doc("If set, job will be scheduled to be enqueued at a given time.")
  @visibility("read")
  scheduledAt?: utcDateTime;

  @doc("If provided, will determine how job matching will be carried out. Default mode: QueueAndMatchMode.")
  matchingMode?: JobMatchingMode;
}

@clientName("RouterWorkerSelectorInternal", "java")
@doc("Describes a condition that must be met against a set of labels for worker selection.")
model RouterWorkerSelector {
  @doc("The label key to query against.")
  key: string;

  @doc("Describes how the value of the label is compared to the value defined on the worker selector.")
  labelOperator: LabelOperator;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Unions are currently not allowed in spec."
  @doc("The value to compare against the actual label value with the given operator. Values must be primitive values - number, string, boolean.")
  value?: unknown;

  @doc("Describes how long this label selector is valid in seconds.")
  expiresAfterSeconds?: float64;

  @doc("Pushes a job to the front of the queue as long as this selector is active.")
  expedite?: boolean;

  @doc("Status of the worker selector.")
  @visibility("read")
  status?: RouterWorkerSelectorStatus;

  @doc("The time at which this worker selector expires in UTC.")
  @visibility("read")
  expiresAt?: utcDateTime;
}

@doc("Assignment details of a job to a worker.")
@resource("assignments")
@parentResource(RouterJob)
model RouterJobAssignment {
  @key
  @doc("Id of a job assignment.")
  @visibility("read")
  assignmentId: string;

  @doc("Id of the Worker assigned to the job.")
  workerId?: string;

  @doc("Timestamp when the job was assigned to a worker in UTC.")
  assignedAt: utcDateTime;

  @doc("Timestamp when the job was marked as completed after being assigned in UTC.")
  completedAt?: utcDateTime;

  @doc("Timestamp when the job was marked as closed after being completed in UTC.")
  closedAt?: utcDateTime;
}

@clientName("JobMatchingModeInternal", "java")
@doc("""
A matching mode of one of the following types:
QueueAndMatchMode: Used when matching worker to a job is required to be done right after job is queued.
ScheduleAndSuspendMode: Used for scheduling jobs to be queued at a future time. At specified time, matching of a worker to the job will not start automatically.
SuspendMode: Used when matching workers to a job needs to be suspended.
""")
@discriminator("kind")
model JobMatchingMode {
  @doc("The type discriminator describing a sub-type of JobMatchingMode.")
  kind: JobMatchingModeKind;
}

@clientName("ScheduleAndSuspendModeInternal", "java")
@doc("Describes a matching mode used for scheduling jobs to be queued at a future time. At the specified time, matching worker to a job will not start automatically.")
model ScheduleAndSuspendMode extends JobMatchingMode {
  @doc("Requested schedule time.")
  scheduleAt: utcDateTime;

  @doc("The type discriminator describing ScheduleAndSuspendMode")
  kind: JobMatchingModeKind.scheduleAndSuspend;
}

@clientName("QueueAndMatchModeInternal", "java")
@doc("Describes a matching mode where matching worker to a job is automatically started after job is queued successfully.")
model QueueAndMatchMode extends JobMatchingMode {
  @doc("The type discriminator describing QueueAndMatchMode")
  kind: JobMatchingModeKind.queueAndMatch;
}

@clientName("SuspendModeInternal", "java")
@doc("Describes a matching mode where matching worker to a job is suspended.")
model SuspendMode extends JobMatchingMode {
  @doc("The type discriminator describing SuspendMode")
  kind: JobMatchingModeKind.suspend;
}

@clientName("CancelJobOptionsInternal", "java")
@access(Access.public, "python")
@doc("Request payload for cancelling a job.")
model CancelJobOptions {
  @doc("A note that will be appended to a job's Notes collection with the current timestamp.")
  note?: string;

  @doc("Indicates the outcome of a job, populate this field with your own custom values. If not provided, default value of \"Cancelled\" is set.")
  dispositionCode?: string;
}

@clientName("CompleteJobOptionsInternal", "java")
@access(Access.public, "python")
@doc("Request payload for completing jobs.")
model CompleteJobOptions {
  @doc("A note that will be appended to a job's Notes collection with the current timestamp.")
  note?: string;
}

@clientName("CloseJobOptionsInternal", "java")
@access(Access.public, "python")
@doc("Request payload for closing jobs")
model CloseJobOptions {
  @doc("Indicates the outcome of a job, populate this field with your own custom values.")
  dispositionCode?: string;

  @doc("If not provided, worker capacity is released immediately along with a JobClosedEvent notification. If provided, worker capacity is released along with a JobClosedEvent notification at a future time in UTC.")
  closeAt?: utcDateTime;

  @doc("A note that will be appended to a job's Notes collection with the current timestamp.")
  note?: string;
}

@doc("Position and estimated wait time for a job.")
model RouterJobPositionDetails {
  @doc("Id of the job these details are about.")
  jobId: string;

  @doc("Position of the job in question within that queue.")
  position: int32;

  @doc("Id of the queue this job is enqueued in.")
  queueId: string;

  @doc("Length of the queue: total number of enqueued jobs.")
  queueLength: int32;

  @doc("Estimated wait time of the job rounded up to the nearest minute.")
  estimatedWaitTimeMinutes: float64;
}

@doc("Request payload for unassigning a job.")
model UnassignJobOptions {
  @doc("If SuspendMatching is true, then a job is not queued for re-matching with a worker.")
  suspendMatching?: boolean;
}

@doc("Response payload after a job has been successfully unassigned.")
model UnassignJobResult {
  @doc("Id of an unassigned job.")
  jobId: string;

  @doc("The number of times a job is unassigned. At a maximum 3.")
  unassignmentCount: int32;
}

@doc("Response containing ids for the worker, job, and assignment from an accepted offer.")
model AcceptJobOfferResult {
  @doc("Id of job assignment that assigns a worker that has accepted an offer to a job.")
  assignmentId: string;

  @doc("Id of the job assigned.")
  jobId: string;

  @doc("Id of the worker that has been assigned this job.")
  workerId: string;
}

@clientName("DeclineJobOfferOptionsInternal", "java")
@access(Access.public, "python")
@doc("Request payload for declining offers.")
model DeclineJobOfferOptions {
  @doc("If the RetryOfferAt is not provided, then this job will not be offered again to the worker who declined this job unless the worker is de-registered and re-registered.  If a RetryOfferAt time is provided, then the job will be re-matched to eligible workers at the retry time in UTC.  The worker that declined the job will also be eligible for the job at that time.")
  retryOfferAt?: utcDateTime;
}

@clientName("RouterQueueInternal", "java")
@resource("routing/queues")
@doc("A queue that can contain jobs to be routed.")
model RouterQueue {
  ...EtagProperty;

  @key("queueId")
  @doc("Id of a queue.")
  @visibility("read")
  id: string;

  @doc("Friendly name of this queue.")
  name?: string;

  @doc("Id of a distribution policy that will determine how a job is distributed to workers.")
  distributionPolicyId?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("A set of key/value pairs that are identifying attributes used by the rules engines to make decisions. Values must be primitive values - number, string, boolean.")
  labels?: Record<unknown>;

  @doc("Id of an exception policy that determines various job escalation rules.")
  exceptionPolicyId?: string;
}

@clientName("RouterQueueStatisticsInternal", "java")
@doc("Statistics for the queue.")
model RouterQueueStatistics {
  @doc("Id of the queue these details are about.")
  queueId: string;

  @doc("Length of the queue: total number of enqueued jobs.")
  length: int32;

  @doc("The estimated wait time of this queue rounded up to the nearest minute, grouped by job priority.")
  estimatedWaitTimeMinutes?: Record<float64>;

  @doc("The wait time of the job that has been enqueued in this queue for the longest.")
  longestJobWaitTimeMinutes?: float64;
}

@clientName("RouterWorkerInternal", "java")
@resource("routing/workers")
@doc("An entity for jobs to be routed to.")
model RouterWorker {
  ...EtagProperty;

  @key("workerId")
  @doc("Id of a worker.")
  @visibility("read")
  id: string;

  @doc("Current state of a worker.")
  @visibility("read")
  state?: RouterWorkerState;

  @doc("Collection of queue(s) that this worker can receive work from.")
  queues?: string[];

  @doc("The total capacity score this worker has to manage multiple concurrent jobs.")
  capacity?: int32;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("A set of key/value pairs that are identifying attributes used by the rules engines to make decisions. Values must be primitive values - number, string, boolean.")
  labels?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("A set of non-identifying attributes attached to this worker. Values must be primitive values - number, string, boolean.")
  tags?: Record<unknown>;

  @doc("Collection of channel(s) this worker can handle and their impact on the workers capacity.")
  channels?: RouterChannel[];

  @doc("A list of active offers issued to this worker.")
  @visibility("read")
  offers?: RouterJobOffer[];

  @doc("A list of assigned jobs attached to this worker.")
  @visibility("read")
  assignedJobs?: RouterWorkerAssignment[];

  @doc("A value indicating the workers capacity. A value of '1' means all capacity is consumed. A value of '0' means no capacity is currently consumed.")
  @visibility("read")
  loadRatio?: float64;

  @doc("A flag indicating this worker is open to receive offers or not.")
  availableForOffers?: boolean;

  @doc("If this is set, the worker will only receive up to this many new offers at a time.")
  @added(Versions.c2024_01_18_Preview)
  maxConcurrentOffers?: int32;
}

@doc("Represents the capacity a job in this channel will consume from a worker.")
model RouterChannel {
  @doc("Id of a channel.")
  channelId: string;

  @doc("The amount of capacity that an instance of a job of this channel will consume of the total worker capacity.")
  capacityCostPerJob: int32;

  @doc("The maximum number of jobs that can be supported concurrently for this channel. Value must be greater than zero.")
  maxNumberOfJobs?: int32;
}

@doc("An offer of a job to a worker.")
@resource("offers")
@parentResource(RouterWorker)
model RouterJobOffer {
  @key
  @doc("Id of an offer.")
  @visibility("read")
  offerId: string;

  @doc("Id of the job.")
  jobId: string;

  @doc("The capacity cost consumed by the job offer.")
  capacityCost: int32;

  @doc("Timestamp when the offer was created in UTC.")
  offeredAt?: utcDateTime;

  @doc("Timestamp when the offer will expire in UTC.")
  expiresAt?: utcDateTime;
}

@doc("The assignment for a worker to a job.")
model RouterWorkerAssignment {
  @doc("Id of the assignment.")
  assignmentId: string;

  @doc("Id of the job assigned.")
  jobId: string;

  @doc("The amount of capacity this assignment has consumed on the worker.")
  capacityCost: int32;

  @doc("The assignment time of the job in UTC.")
  assignedAt: utcDateTime;
}

@clientName("BestWorkerModeInternal", "java")
@doc("Jobs are distributed to the worker with the strongest abilities available.")
model BestWorkerMode extends DistributionMode {
  @doc("Define a scoring rule to use, when calculating a score to determine the best worker. If not set, will use a default scoring formula that uses the number of job labels that the worker labels match, as well as the number of label selectors the worker labels match and/or exceed using a logistic function (https://en.wikipedia.org/wiki/Logistic_function).")
  scoringRule?: RouterRule;

  @doc("Options to configure 'scoringRule'. If not set, default values are used.")
  scoringRuleOptions?: ScoringRuleOptions;

  @doc("The type discriminator describing a sub-type of Mode")
  kind: DistributionModeKind.bestWorker;
}

@doc("Encapsulates all options that can be passed as parameters for scoring rule with BestWorkerMode.")
model ScoringRuleOptions {
  @doc("Set batch size when 'isBatchScoringEnabled' is set to true. Defaults to 20 if not configured.")
  batchSize?: int32 = 20;

  @doc("List of extra parameters from a job that will be sent as part of the payload to scoring rule. If not set, a job's labels (sent in the payload as `job`) and a job's worker selectors (sent in the payload as `selectors`) are added to the payload of the scoring rule by default. Note: Worker labels are always sent with scoring payload.")
  scoringParameters?: ScoringRuleParameterSelector[] = [
    ScoringRuleParameterSelector.jobLabels,
    ScoringRuleParameterSelector.workerSelectors
  ];

  @doc("If set to true, will score workers in batches, and the parameter name of the worker labels will be sent as `workers`. By default, set to false and the parameter name for the worker labels will be sent as `worker`. Note: If enabled, use 'batchSize' to set batch size.")
  isBatchScoringEnabled?: boolean = false;

  @doc("If false, will sort scores by ascending order. By default, set to true.")
  descendingOrder?: boolean = true;
}

@clientName("CancelExceptionActionInternal", "java")
@doc("An action that marks a job as cancelled.")
model CancelExceptionAction extends ExceptionAction {
  @doc("A note that will be appended to a job's notes collection with the current timestamp.")
  note?: string;

  @doc("Indicates the outcome of a job, populate this field with your own custom values.")
  dispositionCode?: string;

  @doc("The type discriminator describing a sub-type of ExceptionAction.")
  kind: ExceptionActionKind.cancel;
}

@clientName("ExceptionActionInternal", "java")
@doc("The action to take when the exception is triggered.")
@discriminator("kind")
model ExceptionAction {
  @doc("Unique Id of the exception action.")
  id?: string;

  @doc("The type discriminator describing a sub-type of ExceptionAction.")
  kind: ExceptionActionKind;
}

@clientName("ConditionalQueueSelectorAttachmentInternal", "java")
@doc("Describes a set of queue selectors that will be attached if the given condition resolves to true.")
model ConditionalQueueSelectorAttachment extends QueueSelectorAttachment {
  @doc("The condition that must be true for the queue selectors to be attached.")
  condition: RouterRule;

  @doc("The queue selectors to attach.")
  queueSelectors: RouterQueueSelector[];

  @doc("The type discriminator describing the type of queue selector attachment.")
  kind: QueueSelectorAttachmentKind.conditional;
}

@clientName("RouterQueueSelectorInternal", "java")
@doc("Describes a condition that must be met against a set of labels for queue selection.")
model RouterQueueSelector {
  @doc("The label key to query against.")
  key: string;

  @doc("Describes how the value of the label is compared to the value defined on the label selector.")
  labelOperator: LabelOperator;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Unions are currently not allowed in spec."
  @doc("The value to compare against the actual label value with the given operator. Values must be primitive values - number, string, boolean.")
  value?: unknown;
}

@clientName("QueueSelectorAttachmentInternal", "java")
@doc("An attachment of queue selectors to resolve a queue to a job from a classification policy.")
@discriminator("kind")
model QueueSelectorAttachment {
  @doc("The type discriminator describing a sub-type of QueueSelectorAttachment.")
  kind: QueueSelectorAttachmentKind;
}

@clientName("ConditionalWorkerSelectorAttachmentInternal", "java")
@doc("Describes a set of worker selectors that will be attached if the given condition resolves to true.")
model ConditionalWorkerSelectorAttachment extends WorkerSelectorAttachment {
  @doc("The condition that must be true for the worker selectors to be attached.")
  condition: RouterRule;

  @doc("The worker selectors to attach.")
  workerSelectors: RouterWorkerSelector[];

  @doc("The type discriminator describing the type of worker selector attachment.")
  kind: WorkerSelectorAttachmentKind.conditional;
}

@clientName("WorkerSelectorAttachmentInternal", "java")
@doc("An attachment which attaches worker selectors to a job.")
@discriminator("kind")
model WorkerSelectorAttachment {
  @doc("The type discriminator describing a sub-type of WorkerSelectorAttachment.")
  kind: WorkerSelectorAttachmentKind;
}

@clientName("DirectMapRouterRuleInternal", "java")
@doc("A rule that return the same labels as the input labels.")
model DirectMapRouterRule extends RouterRule {
  @doc("The type discriminator describing a sub-type of Rule.")
  kind: RouterRuleKind.directMap;
}

@clientName("ExpressionRouterRuleInternal", "java")
@doc("A rule providing inline expression rules.")
model ExpressionRouterRule extends RouterRule {
  @doc("The expression language to compile to and execute.")
  language?: ExpressionRouterRuleLanguage;

  @doc("An expression to evaluate. Should contain return statement with calculated values.")
  expression: string;

  @doc("The type discriminator describing a sub-type of Rule.")
  kind: RouterRuleKind.expression;
}

@clientName("FunctionRouterRuleInternal", "java")
@doc("A rule providing a binding to an HTTP Triggered Azure Function.")
model FunctionRouterRule extends RouterRule {
  @doc("URL for Azure Function.")
  functionUri: url;

  @doc("Credentials used to access Azure function rule.")
  credential?: FunctionRouterRuleCredential;

  @doc("The type discriminator describing a sub-type of Rule.")
  kind: RouterRuleKind.function;
}

@doc("Credentials used to access Azure function rule.")
model FunctionRouterRuleCredential {
  @doc("Access key scoped to a particular function.")
  functionKey?: string;

  @doc("Access key scoped to a Azure Function app. This key grants access to all functions under the app.")
  appKey?: string;

  @doc("Client id, when AppKey is provided In context of Azure function, this is usually the name of the key.")
  clientId?: string;
}

@clientName("LongestIdleModeInternal", "java")
@doc("Jobs are directed to the worker who has been idle longest.")
model LongestIdleMode extends DistributionMode {
  @doc("The type discriminator describing a sub-type of Mode.")
  kind: DistributionModeKind.longestIdle;
}

@clientName("ManualReclassifyExceptionActionInternal", "java")
@doc("An action that manually reclassifies a job by providing the queue, priority and worker selectors.")
model ManualReclassifyExceptionAction extends ExceptionAction {
  @doc("Updated QueueId.")
  queueId?: string;

  @doc("Updated Priority.")
  priority?: int32;

  @doc("Updated WorkerSelectors.")
  workerSelectors?: RouterWorkerSelector[];

  @doc("The type discriminator describing a sub-type of ExceptionAction.")
  kind: ExceptionActionKind.manualReclassify;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is standard naming convention for OAuth."
@doc("OAuth2.0 Credentials used to Contoso's Authorization server. Reference: https://www.oauth.com/oauth2-servers/access-tokens/client-credentials/")
model OAuth2WebhookClientCredential {
  @doc("ClientId for Contoso Authorization server.")
  clientId?: string;

  @doc("Client secret for Contoso Authorization server.")
  clientSecret?: string;
}

@clientName("PassThroughQueueSelectorAttachmentInternal", "java")
@doc("Attaches a queue selector where the value is passed through from a job's label with the same key.")
model PassThroughQueueSelectorAttachment extends QueueSelectorAttachment {
  @doc("The label key to query against.")
  key: string;

  @doc("Describes how the value of the label is compared to the value pass through.")
  labelOperator: LabelOperator;

  @doc("The type discriminator describing the type of queue selector attachment.")
  kind: QueueSelectorAttachmentKind.passThrough;
}

@clientName("PassThroughWorkerSelectorAttachmentInternal", "java")
@doc("Attaches a worker selector where the value is passed through from a job's label with the same key.")
model PassThroughWorkerSelectorAttachment extends WorkerSelectorAttachment {
  @doc("The label key to query against.")
  key: string;

  @doc("Describes how the value of the label is compared to the value pass through.")
  labelOperator: LabelOperator;

  @doc("Describes how long the attached label selector is valid in seconds.")
  expiresAfterSeconds?: float64;

  @doc("The type discriminator describing the type of worker selector attachment.")
  kind: WorkerSelectorAttachmentKind.passThrough;
}

@clientName("QueueLengthExceptionTriggerInternal", "java")
@doc("Trigger for an exception action on exceeding queue length.")
model QueueLengthExceptionTrigger extends ExceptionTrigger {
  @doc("Threshold of number of jobs ahead in the queue to for this trigger to fire.")
  threshold: int32;

  @doc("The type discriminator describing a sub-type of ExceptionTrigger.")
  kind: ExceptionTriggerKind.queueLength;
}

@clientName("QueueWeightedAllocationInternal", "java")
@doc("Contains the weight percentage and queue selectors to be applied if selected for weighted distributions.")
model QueueWeightedAllocation {
  @doc("The percentage of this weight, expressed as a fraction of 1.")
  weight: float64;

  @doc("A collection of queue selectors that will be applied if this allocation is selected.")
  queueSelectors: RouterQueueSelector[];
}

@clientName("ReclassifyExceptionActionInternal", "java")
@doc("An action that modifies labels on a job and then reclassifies it.")
model ReclassifyExceptionAction extends ExceptionAction {
  @doc("The new classification policy that will determine queue, priority and worker selectors.")
  classificationPolicyId?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Unions are currently not allowed in spec."
  @doc("Dictionary containing the labels to update (or add if not existing) in key-value pairs.  Values must be primitive values - number, string, boolean.")
  labelsToUpsert?: Record<unknown>;

  @doc("The type discriminator describing a sub-type of ExceptionAction.")
  kind: ExceptionActionKind.reclassify;
}

@clientName("RoundRobinModeInternal", "java")
@doc("Jobs are distributed in order to workers, starting with the worker that is after the last worker to receive a job.")
model RoundRobinMode extends DistributionMode {
  @doc("The type discriminator describing a sub-type of Mode.")
  kind: DistributionModeKind.roundRobin;
}

@clientName("RuleEngineQueueSelectorAttachmentInternal", "java")
@doc("Attaches queue selectors to a job when the RouterRule is resolved.")
model RuleEngineQueueSelectorAttachment extends QueueSelectorAttachment {
  @doc("A RouterRule that resolves a collection of queue selectors to attach.")
  rule: RouterRule;

  @doc("The type discriminator describing the type of queue selector attachment.")
  kind: QueueSelectorAttachmentKind.ruleEngine;
}

@clientName("RuleEngineWorkerSelectorAttachmentInternal", "java")
@doc("Attaches worker selectors to a job when a RouterRule is resolved.")
model RuleEngineWorkerSelectorAttachment extends WorkerSelectorAttachment {
  @doc("A RouterRule that resolves a collection of worker selectors to attach.")
  rule: RouterRule;

  @doc("The type discriminator describing the type of worker selector attachment.")
  kind: WorkerSelectorAttachmentKind.ruleEngine;
}

@clientName("StaticQueueSelectorAttachmentInternal", "java")
@doc("Describes a queue selector that will be attached to a job.")
model StaticQueueSelectorAttachment extends QueueSelectorAttachment {
  @doc("The queue selector to attach.")
  queueSelector: RouterQueueSelector;

  @doc("The type discriminator describing the type of queue selector attachment.")
  kind: QueueSelectorAttachmentKind.static;
}

@clientName("StaticRouterRuleInternal", "java")
@doc("A rule providing static rules that always return the same result, regardless of input.")
model StaticRouterRule extends RouterRule {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Unions are currently not allowed in spec."
  @doc("The static value this rule always returns. Values must be primitive values - number, string, boolean.")
  value?: unknown;

  @doc("The type discriminator describing a sub-type of Rule.")
  kind: RouterRuleKind.static;
}

@clientName("StaticWorkerSelectorAttachmentInternal", "java")
@doc("Describes a worker selector that will be attached to a job.")
model StaticWorkerSelectorAttachment extends WorkerSelectorAttachment {
  @doc("The worker selector to attach.")
  workerSelector: RouterWorkerSelector;

  @doc("The type discriminator describing the type of worker selector attachment.")
  kind: WorkerSelectorAttachmentKind.static;
}

@clientName("WaitTimeExceptionTriggerInternal", "java")
@doc("Trigger for an exception action on exceeding wait time.")
model WaitTimeExceptionTrigger extends ExceptionTrigger {
  @doc("Threshold for wait time for this trigger.")
  thresholdSeconds: float64;

  @doc("The type discriminator describing a sub-type of ExceptionTrigger.")
  kind: ExceptionTriggerKind.waitTime;
}

@clientName("WebhookRouterRuleInternal", "java")
@doc("A rule providing a binding to an external web server.")
model WebhookRouterRule extends RouterRule {
  @doc("Uri for Authorization Server.")
  authorizationServerUri?: url;

  @doc("OAuth2.0 Credentials used to Contoso's Authorization server. Reference: https://www.oauth.com/oauth2-servers/access-tokens/client-credentials/")
  clientCredential?: OAuth2WebhookClientCredential;

  @doc("Uri for Contoso's Web Server.")
  webhookUri?: url;

  @doc("The type discriminator describing a sub-type of Rule.")
  kind: RouterRuleKind.webhook;
}

@clientName("WeightedAllocationQueueSelectorAttachmentInternal", "java")
@doc("Describes multiple sets of queue selectors, of which one will be selected and attached according to a weighting.")
model WeightedAllocationQueueSelectorAttachment
  extends QueueSelectorAttachment {
  @doc("A collection of percentage based weighted allocations.")
  allocations: QueueWeightedAllocation[];

  @doc("The type discriminator describing the type of queue selector attachment.")
  kind: QueueSelectorAttachmentKind.weightedAllocation;
}

@clientName("WeightedAllocationWorkerSelectorAttachmentInternal", "java")
@doc("Describes multiple sets of worker selectors, of which one will be selected and attached according to a weighting.")
model WeightedAllocationWorkerSelectorAttachment
  extends WorkerSelectorAttachment {
  @doc("A collection of percentage based weighted allocations.")
  allocations: WorkerWeightedAllocation[];

  @doc("The type discriminator describing the type of worker selector attachment.")
  kind: WorkerSelectorAttachmentKind.weightedAllocation;
}

@clientName("WorkerWeightedAllocationInternal", "java")
@doc("Contains the weight percentage and worker selectors to be applied if selected for weighted distributions.")
model WorkerWeightedAllocation {
  @doc("The percentage of this weight, expressed as a fraction of 1.")
  weight: float64;

  @doc("A collection of worker selectors that will be applied if this allocation is selected.")
  workerSelectors: RouterWorkerSelector[];
}

@clientName("ReclassifyJobOptionsInternal", "java")
@access(Access.internal)
@doc("Request payload for reclassifying jobs.")
model ReclassifyJobOptions {}

@clientName("ReclassifyJobResultInternal", "java")
@access(Access.internal)
@doc("Response payload from reclassifying a job.")
model ReclassifyJobResult {}

@doc("OK Response payload from reclassifying a job.")
model ReclassifyJobResultWithOkResponse {
  @doc("Response payload from reclassifying a job.")
  @body
  body: ReclassifyJobResult;

  @doc("Status code.")
  @statusCode
  _: 200;
}

@clientName("CloseJobResultInternal", "java")
@access(Access.internal)
@doc("Response payload from closing a job.")
model CloseJobResult {}

@doc("Response payload from closing a job synchronously.")
model CloseJobResultWithOkResponse {
  @doc("Response after closing a job.")
  @body
  body: CloseJobResult;

  @doc("Status code.")
  @statusCode
  _: 200;
}

@clientName("CancelJobResultInternal", "java")
@access(Access.internal)
@doc("Response payload from cancelling a job.")
model CancelJobResult {}

@doc("OK Response payload from cancelling a job.")
model CancelJobResultWithOkResponse {
  @doc("Response after cancelling a job.")
  @body
  body: CancelJobResult;

  @doc("Status code.")
  @statusCode
  _: 200;
}

@clientName("CompleteJobResultInternal", "java")
@access(Access.internal)
@doc("Response payload from completing a job.")
model CompleteJobResult {}

@doc("OK Response payload from completing a job.")
model CompleteJobResultWithOkResponse {
  @doc("Response after completing a job.")
  @body
  body: CompleteJobResult;

  @doc("Status code.")
  @statusCode
  _: 200;
}

@clientName("DeclineJobOfferResultInternal", "java")
@access(Access.internal)
@doc("Response payload from declining a job.")
model DeclineJobOfferResult {}

@doc("OK Response payload from declining a job.")
model DeclineJobOfferResultWithOkResponse {
  @doc("Response payload from declining a job.")
  @body
  body: DeclineJobOfferResult;

  @doc("Status code.")
  @statusCode
  _: 200;
}

alias CommonListParams = {
  @doc("Number of objects to return per page.")
  @query
  maxpagesize?: int32;
};

alias ListJobQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;

  @doc("If specified, filter jobs by status.")
  @query
  status?: RouterJobStatusSelector = RouterJobStatusSelector.all;

  @doc("If specified, filter jobs by queue.")
  @query
  queueId?: string;

  @doc("If specified, filter jobs by channel.")
  @query
  channelId?: string;

  @doc("If specified, filter jobs by classificationPolicy.")
  @query
  classificationPolicyId?: string;

  @doc("If specified, filter on jobs that was scheduled before or at given timestamp. Range: (-Inf, scheduledBefore].")
  @query
  scheduledBefore?: utcDateTime;

  @doc("If specified, filter on jobs that was scheduled at or after given value. Range: [scheduledAfter, +Inf).")
  @query
  scheduledAfter?: utcDateTime;
}>;

alias ListClassificationPoliciesQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListDistributionPoliciesQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListExceptionPoliciesQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListQueuesQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListWorkerQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;

  @doc("If specified, select workers by worker state.")
  @query
  state?: RouterWorkerStateSelector = RouterWorkerStateSelector.all;

  @doc("If specified, select workers who have a channel configuration with this channel.")
  @query
  channelId?: string;

  @doc("If specified, select workers who are assigned to this queue.")
  @query
  queueId?: string;

  @doc("If set to true, select only workers who have capacity for the channel specified by `channelId` or for any channel if `channelId` not specified. If set to false, then will return all workers including workers without any capacity for jobs. Defaults to false.")
  @query
  hasCapacity?: boolean;
}>;

@doc("JobRouter Versions")
enum Versions {
  @doc("JobRouter 2023-11-01 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2023_11_01: "2023-11-01",

  @doc("JobRouter 2024-01-18-preview api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_01_18_Preview: "2024-01-18-preview",
}
