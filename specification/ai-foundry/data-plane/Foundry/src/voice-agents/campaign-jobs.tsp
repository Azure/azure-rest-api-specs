import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

@doc("One recipient in an inline campaign input. Each input position is a separate intended call, including repeated destinations.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyRecipient {
  @doc("Recipient address; currently phone_number only. Unsupported types fail preparation; future variants can reuse this field.")
  destination: TelephonyAddress;

  @doc("Agent inputs with nested JSON/null, unique names and depth at most 16. Agent schemas/defaults apply. Replay preserves types, exact numbers, array order and null/omission, but ignores object order; use lossless numeric serialization.")
  structured_inputs?: Record<unknown>;

  @doc("Earliest dispatch time for recipient scheduling. Required only when schedule.type is recipient; forbidden for other modes.")
  scheduled_at?: FoundryTimestamp;
}

@doc("Mutually exclusive ways to determine each recipient's earliest dispatch time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignScheduleType {
  string,

  @doc("Eligible automatically after successful preparation.")
  immediate: "immediate",

  @doc("One common earliest dispatch time.")
  scheduled: "scheduled",

  @doc("A separate earliest dispatch time for each recipient.")
  recipient: "recipient",
}

@doc("Creation authorizes dialing; every scheduling mode waits for successful preparation.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignSchedule {
  @doc("How each recipient's earliest dispatch time is determined.")
  type: TelephonyCampaignScheduleType;

  @doc("Exclusive deadline for new attempts, including retries; active calls may finish. Must be later than every scheduled_at.")
  expires_at?: FoundryTimestamp;
}

@doc("Dispatch automatically as soon as preparation succeeds and capacity permits.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model ImmediateSchedule extends TelephonyCampaignSchedule {
  @doc("Identifies immediate scheduling after successful preparation.")
  type: TelephonyCampaignScheduleType.immediate;
}

@doc("Uses one earliest dispatch time for all recipients. Past times are allowed; preparation must still succeed.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model AtTimeSchedule extends TelephonyCampaignSchedule {
  @doc("Identifies scheduling with one common earliest dispatch time.")
  type: TelephonyCampaignScheduleType.scheduled;

  @doc("Common earliest dispatch time; successful preparation is required.")
  scheduled_at: FoundryTimestamp;
}

@doc("Uses each recipient's scheduled_at: RFC 3339 with timezone in Datasets, Unix seconds for inline recipients.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model PerRecipientSchedule extends TelephonyCampaignSchedule {
  @doc("Identifies scheduling with a separate earliest dispatch time for each recipient.")
  type: TelephonyCampaignScheduleType.recipient;
}

@doc("Recipient execution counts, zero until preparation succeeds; then mutually exclusive and summing to total_recipients.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignProgress {
  @doc("Total input rows, including invalid rows. Omitted until known; never an estimate.")
  @minValue(0)
  total_recipients?: int64;

  @doc("Recipients waiting for their schedule, capacity or retry after preparation has completed.")
  @minValue(0)
  pending: int64;

  @doc("Recipients with a durable origination reservation or unresolved provider attempt, including dispatching before a call ID is received.")
  @minValue(0)
  active: int64;

  @doc("Recipients whose CallJob completed; not proof of business success.")
  @minValue(0)
  completed: int64;

  @doc("Recipients whose CallJob exhausted retries or failed.")
  @minValue(0)
  failed: int64;

  @doc("Recipients cancelled before completion. Does not include dispatch-window expiry.")
  @minValue(0)
  cancelled: int64;

  @doc("Recipients whose dispatch deadline elapsed before a new attempt could start.")
  @minValue(0)
  expired: int64;
}

@doc("Campaign execution state, separate from preparation/cancel/delete LROs. All recipients terminal means completed, not necessarily successful.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  @doc("Validating recipients and generating CallJobs; no dialing until preparation succeeds.")
  validating: "validating",

  @doc("Preparation complete; jobs execute subject to schedule, capacity and retries.")
  running: "running",

  @doc("New dispatch stopped while admitted work drains; connected calls finish naturally. Cancellation failure leaves dispatch stopped.")
  cancelling: "cancelling",

  @doc("All recipients terminal, including failed/expired jobs. Deletion waits for admitted work to stop.")
  completed: "completed",

  @doc("Preparation failed without dialing and workers have stopped. Allows deletion or full replacement.")
  failed: "failed",

  @doc("Cancellation complete. Can be deleted; unfinished work cannot restart.")
  cancelled: "cancelled",

  @doc("Cleanup in progress; dialing and name reuse stay blocked until success, including after cleanup failure.")
  deleting: "deleting",
}

@doc("Agent-owned outbound call Campaign. Creation/replacement authorizes execution after successful preparation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  @doc("Human-readable name of the provider connection in the current project.")
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  @doc("Typed caller address shared with generated CallJobs. The connection validates source support separately from recipient support.")
  source: TelephonyAddress;

  @doc("1-100 recipients, exclusive with recipient_dataset. The whole UTF-8 request is limited to 1 MiB. Omitted from reads; retain the submission for row correlation.")
  @minItems(1)
  @maxItems(100)
  @visibility(Lifecycle.Create)
  recipients?: TelephonyRecipient[];

  @doc("Same-project CSV/JSON/JSONL uri_file, exclusive with recipients. Omitted version pins latest per preparation. Limits: 1-1,000,000 rows, 256 MiB decoded/file, 1 MiB/row.")
  recipient_dataset?: DatasetReference;

  @doc("Dispatch schedule; omission equals ImmediateSchedule. Every mode waits for successful preparation, then follows its schedule and available capacity.")
  schedule?: TelephonyCampaignSchedule;

  @doc("Per-recipient retries. Omit for one attempt; generated CallJobs return fixed_interval with max_attempts=1 and interval=0 seconds.")
  retry_policy?: TelephonyOutboundRetryPolicy;

  @doc("Business execution state. Each asynchronous action has its own retained operation monitor.")
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  @doc("Preparation/control failure, cleared on retry. Never includes secrets or raw recipient values.")
  @visibility(Lifecycle.Read)
  error?: ApiError;

  @doc("Immutable name supplied as campaign_name in the PUT path, not the request body; echoed in responses. Unique within the project and Agent.")
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

  @doc("Creation time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("Last observable progress update.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;

  @doc("Conditional-action token, not a cache validator. Changes with control state, not progress.")
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;

  @doc("Latest accepted action, for discovery only. Poll the initiating response's Operation-Id/Operation-Location instead.")
  @visibility(Lifecycle.Read)
  operation_id: string;

  @doc("Time of terminal completion for the current round; cleared when failed preparation is replaced.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  @doc("Latest Agent version pinned once per preparation and shared by retries/calls. Omitted until resolved; replacement clears it. Unavailable pins fail without fallback.")
  @visibility(Lifecycle.Read)
  locked_agent_version?: string;

  @doc("Available partial accounting even when the job fails or is cancelled.")
  @visibility(Lifecycle.Read)
  progress: TelephonyCampaignProgress;
}

@doc("Invalid-row diagnostic for current preparation; execution errors are in CallJobs.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationError {
  @doc("One-based source row or inline item position.")
  @minValue(1)
  row_number: int64;

  @doc("Row validation error; param identifies the field. Never includes raw values or secrets.")
  error: ApiError;
}

@doc("Error-only page. During validation this is a partial live view; an empty page does not establish success.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationErrorPage {
  ...TelephonyCampaignPage<TelephonyCampaignValidationError>;

  @doc("Pinned Agent version used for preparation, shared by all errors on the page.")
  agent_version?: string;
}

/** Error pages order diagnostics by their original input position. */
alias TelephonyCampaignValidationErrorQueryParameters = {
  ...OmitProperties<TelephonyCampaignPageQueryParameters, "order">;

  @doc("Sort invalid rows by their original row_number.")
  @query
  order?: PageOrder = "desc";
};

@doc("Kind of asynchronous work associated with a Campaign.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignOperationKind {
  string,

  @doc("Input validation and complete CallJob generation for a PUT.")
  validation: "validation",

  @doc("Stop future dispatch and drain admitted work.")
  cancel: "cancel",

  @doc("Cascade cleanup of Campaign task resources.")
  delete: "delete",
}

@doc("Preparation/cancel/delete monitor bound to its original Campaign instance/round, independent of later actions. Omits result. Retained for the Campaign lifetime and at least 24 hours after both completion and deletion.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  @doc("Work tracked by this monitor.")
  @visibility(Lifecycle.Read)
  kind: TelephonyCampaignOperationKind;

  @doc("Creation time of this operation.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("When preparation, cancellation or deletion finished.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}
@@lroErrorResult(TelephonyCampaignOperation.error);

/** Non-cacheable Campaign state and operation responses. */
alias TelephonyCampaignNoStoreResponse = {
  @doc("Prevents caches from treating the control token as a validator for changing progress.")
  @header("Cache-Control")
  cache_control: "no-store";
};

/** Campaign response. Dynamic progress is not cacheable; the body etag is used only for control-state concurrency. */
alias TelephonyCampaignResponse = TelephonyCampaign &
  TelephonyCampaignNoStoreResponse;

@doc("An operation identifier of 1-256 characters. Must not be whitespace-only or contain CR/LF; the service enforces these content rules.")
@minLength(1)
@maxLength(256)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
scalar TelephonyCampaignOperationId extends string;

/** Returns the created business resource; the asynchronous operation is polled separately. */
alias TelephonyCampaignCreatedResponse<Status extends int32> = TypeSpec.Http.Response<Status> &
  TelephonyCampaignResponse & {
    @doc("URI of the Campaign business resource.")
    @header("Location")
    location: TypeSpec.Rest.ResourceLocation<TelephonyCampaign>;

    @doc("Preparation monitor URI, including api-version. Completion does not mean all calls have finished.")
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    @doc("This request's preparation ID, unchanged on retries; may differ from Campaign.operation_id.")
    @header("Operation-Id")
    operationId: TelephonyCampaignOperationId;

    @doc("Suggested polling delay in seconds.")
    @header("Retry-After")
    retry_after: int32;
  };

/** Acknowledges asynchronous cancellation with its independent status monitor. */
alias TelephonyCampaignCancelAcceptedResponse = TypeSpec.Http.AcceptedResponse &
  TelephonyCampaignNoStoreResponse & {
    @doc("Cancellation monitor; its id matches Operation-Id.")
    @body
    body: TelephonyCampaignOperation;

    @doc("Absolute polling URI including api-version.")
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    @doc("Stable cancellation operation ID for this accepted request.")
    @header("Operation-Id")
    operationId: TelephonyCampaignOperationId;

    @doc("Suggested polling delay in seconds.")
    @header("Retry-After")
    retry_after: int32;
  };

/** Bodyless deletion acceptance; poll its monitor, with no final resource result. */
alias TelephonyCampaignDeleteAcceptedResponse = TypeSpec.Http.AcceptedResponse &
  TelephonyCampaignNoStoreResponse & {
    @doc("Absolute deletion-monitor URI including api-version, retained after the Campaign is removed.")
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    @doc("Immutable deletion-operation ID; retries of the same accepted request return the same ID.")
    @header("Operation-Id")
    operationId: TelephonyCampaignOperationId;

    @doc("Suggested delay in seconds before polling.")
    @header("Retry-After")
    retry_after: int32;
  };

/** Filters combined with the shared cursor paging parameters. */
alias TelephonyCampaignFilters = {
  @doc("Filter by Campaign business state.")
  @query
  status?: TelephonyCampaignStatus;
};

/** Campaign-scoped cursor parameters. Preserve shared wire names without treating reusable resource names as cursors. */
alias TelephonyCampaignPageQueryParameters = {
  ...OmitProperties<CommonPageQueryParameters, "after" | "before">;

  @doc("Opaque last_id bound to scope/filters/order; error cursors also bind instance/round/snapshot and survive cancel, not replacement. Exclusive with before; invalid tokens return 400 invalid_cursor.")
  @query
  @continuationToken
  after?: string;

  @doc("Opaque first_id for backward paging with unchanged scope/filters/order; exclusive with after.")
  @query
  before?: string;
};

@doc("Shared Foundry page shape with opaque boundary tokens bound to the original sort position.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignPage<T> {
  ...OmitProperties<AgentsPagedResult<T>, "first_id" | "last_id">;

  @doc("Opaque cursor for the first returned item; absent when empty.")
  first_id?: string;

  @doc("Opaque cursor for the last returned item; absent when empty. Deletion/name reuse does not move its original sort boundary.")
  @continuationToken
  last_id?: string;
}
