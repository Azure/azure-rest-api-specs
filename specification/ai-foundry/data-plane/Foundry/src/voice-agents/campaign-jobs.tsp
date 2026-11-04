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

  @doc("""
    JSON inputs using the shared CallJob parser and Agent schemas/defaults: unique root names, depth at most 16,
    nested values/null allowed. Request/row byte limits apply, with no extra Campaign-specific value limits.
    Replay ignores object order but preserves array order, null versus omission and exact numeric values
    (1=1.0=1e0, -0=0; distinct int64 values and strings remain distinct). SDK serialization may round numbers before transmission.
    """)
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

@doc("Apply the same earliest dispatch time to every recipient. A past time is valid and makes work eligible after preparation succeeds.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model AtTimeSchedule extends TelephonyCampaignSchedule {
  @doc("Identifies scheduling with one common earliest dispatch time.")
  type: TelephonyCampaignScheduleType.scheduled;

  @doc("Common earliest dispatch time; successful preparation is required.")
  scheduled_at: FoundryTimestamp;
}

@doc("Read every recipient's earliest dispatch time from the fixed scheduled_at field. Dataset CSV/JSON/JSONL values use RFC 3339 with an explicit offset or Z; inline values use FoundryTimestamp.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model PerRecipientSchedule extends TelephonyCampaignSchedule {
  @doc("Identifies scheduling with a separate earliest dispatch time for each recipient.")
  type: TelephonyCampaignScheduleType.recipient;
}

@doc("Mutually exclusive execution counts stay zero until preparation and CallJob generation succeed, then sum to total_recipients. Campaign status and validation_errors report preparation failures.")
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

@doc("Campaign execution state, separate from preparation/cancel/delete LROs. Execution completes when all recipients are terminal, regardless of call outcomes.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  @doc("Pins the latest Agent version, snapshots/validates recipients and idempotently generates CallJobs before enabling dispatch. Cancel enters cancelling until workers stop.")
  validating: "validating",

  @doc("Preparation succeeded and all CallJobs are generated. Automatic execution includes waiting for schedules, capacity and retries; cancel stops new admission.")
  running: "running",

  @doc("Dispatch is closed while workers/admitted calls drain; connected calls finish naturally. Failed cancellation stays here with dispatch closed; a fresh conditional cancel resumes draining.")
  cancelling: "cancelling",

  @doc("Execution-terminal: every recipient is terminal, including failures or expiry. Delete is allowed after quiescence; individual call outcomes determine success.")
  completed: "completed",

  @doc("Preparation failed with workers stopped and no calls dispatched. Allows delete or full replacement with current If-Match and a fresh Operation-Id; partial tasks remain fenced.")
  failed: "failed",

  @doc("Execution-terminal: cancellation is complete and workers/admitted calls are quiescent. Delete is allowed; unfinished work cannot be restarted.")
  cancelled: "cancelled",

  @doc("Irreversible cascade cleanup; dialing and name reuse are blocked until deletion succeeds. A failed cleanup remains in this state and can be retried.")
  deleting: "deleting",
}

@doc("An Agent-owned Campaign. Creation and replacement of failed preparation authorize execution after validation; cancel and delete control its lifecycle.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  @doc("Human-readable name of the provider connection in the current project.")
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  @doc("Typed caller address shared with generated CallJobs. The connection validates source support separately from recipient support.")
  source: TelephonyAddress;

  @doc("1-100 inline recipients, exclusive with recipient_dataset; missing/empty/conflicting sources return 400. The whole UTF-8 request shares 1 MiB. Reads omit recipients; retain the submission for row correlation.")
  @minItems(1)
  @maxItems(100)
  @visibility(Lifecycle.Create)
  recipients?: TelephonyRecipient[];

  @doc("""
    Same-project single uri_file, exclusive with recipients. Empty name/version returns 400. Omitted version pins latest
    once per round before reads; retries reuse its snapshot. Reads expose the requested version until the pin resolves.
    The submitter's assets/read on that version is rechecked before content reads. Bounded detection accepts CSV, JSON arrays or JSONL;
    ambiguous/malformed content fails preparation without fallback or dialing.
    Reserved destination_type/destination_value form a phone_number/E.164 address. scheduled_at is required only for
    recipient scheduling. Other fields use the shared structured-input/Agent rules: JSON preserves nested values/null;
    CSV cells stay strings. Duplicate headers/top-level row keys fail; repeated destinations remain separate calls.
    Limits: 1-1,000,000 rows, 256 MiB decoded file and 1 MiB per logical row. Folders are unsupported.
    """)
  recipient_dataset?: DatasetReference;

  @doc("Dispatch schedule; omission equals ImmediateSchedule. Every mode waits for successful preparation, then follows its schedule and available capacity.")
  schedule?: TelephonyCampaignSchedule;

  @doc("Per-recipient provider retries. Omit for one initial attempt with no retry. Generated CallJobs return fixed_interval with max_attempts=1 and interval=0 seconds for an omitted policy.")
  retry_policy?: TelephonyOutboundRetryPolicy;

  @doc("Business execution state. Each asynchronous action has its own retained operation monitor.")
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  @doc("Preparation failure when failed, cancellation failure when cancelling, or cleanup failure when deleting. Cleared when that work is retried. Never contains secrets or raw recipient values.")
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

  @doc("Control token for conditional actions, not a cache validator. Changes with lifecycle, accepted operations or terminal control failure, never progress alone.")
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;

  @doc("Latest accepted action's ID, retained after completion; older completions cannot overwrite it. For discovery only: poll the request's Operation-Id/Operation-Location, not this pointer.")
  @visibility(Lifecycle.Read)
  operation_id: string;

  @doc("Time of terminal completion for the current round; cleared when failed preparation is replaced.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  @doc("Latest Agent version pinned at validation start and shared by preparation, retries and calls. Omitted until resolved; replacement clears it and resolves latest. Resolution failure fails preparation; unavailable pins fail preparation/the affected task without fallback.")
  @visibility(Lifecycle.Read)
  locked_agent_version?: string;

  @doc("Available partial accounting even when the job fails or is cancelled.")
  @visibility(Lifecycle.Read)
  progress: TelephonyCampaignProgress;
}

@doc("Validation diagnostic for one invalid input row in the current validation round. Execution details are available through the CallJob list.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationError {
  @doc("One-based source row or inline item position.")
  @minValue(1)
  row_number: int64;

  @doc("Validation error for this row. param identifies the input field; never echoes raw values or secrets. Non-row source/runtime failures are returned through Campaign.error.")
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

@doc("""
  Instance/round-bound validation, cancel or delete monitor, independent of Campaign execution and later operation_id changes.
  Validation succeeds when all CallJobs exist and dispatch opens; cancellation waits for workers/admitted calls without
  rewriting terminal validation. Retries reuse IDs; failed cancel/delete resumes with a fresh ID. Monitors omit result:
  PUT/cancel use a guarded final Campaign GET; delete completes without a resource result.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  @doc("Work tracked by this monitor.")
  @visibility(Lifecycle.Read)
  kind: TelephonyCampaignOperationKind;

  @doc("Creation time of this operation.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("Time preparation/task generation, cancellation draining or task cleanup completed. Source Dataset, connections, Agent configuration, call records, conversations and recordings are preserved.")
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

    @doc("Absolute URI including api-version of the current validation round monitor, returned while the recipient scan proceeds asynchronously. Campaign state tracks subsequent execution.")
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    @doc("ID of this PUT's validation monitor; preserved on retries. May differ from the latest operation_id in the Campaign body after a later action.")
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

/** Bodyless acknowledgement of asynchronous cascade deletion. The SDK polls the retained monitor and completes with no result. */
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

  @doc("Opaque last_id bound to scope, filters and sort boundary; error cursors also bind instance/round/snapshot and survive cancellation. Exclusive with before; invalid or mismatched tokens return 400 invalid_cursor.")
  @query
  @continuationToken
  after?: string;

  @doc("Opaque first_id for backward traversal with unchanged scope/filters/order. Cannot be combined with after. Does not resolve the current resource by name.")
  @query
  before?: string;
};

@doc("Shared Foundry page shape with opaque boundary tokens bound to the original sort position.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignPage<T> {
  ...OmitProperties<AgentsPagedResult<T>, "first_id" | "last_id">;

  @doc("Opaque boundary cursor for the first returned item; absent for an empty page. Not a Campaign name or recipient ID.")
  first_id?: string;

  @doc("Opaque boundary cursor for the last returned item; absent for an empty page. Captures its original immutable sort key, so deleting/reusing the resource name cannot move the boundary.")
  @continuationToken
  last_id?: string;
}
