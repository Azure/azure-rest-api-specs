import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

@doc("One recipient in an inline campaign input. Each input position is a separate intended call, including repeated destinations.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyRecipient {
  @doc("Recipient destination address. Initial provider support accepts phone_number; non-phone variants can be introduced without replacing this field. Unsupported destination types fail preparation.")
  destination: TelephonyAddress;

  /**
   * Parsing follows the same rules as direct CallJobs: a root object with unique names and at most 16 JSON nesting levels.
   * Strings, numbers, booleans, null, objects and arrays retain their types, including nested values.
   * Agent required/default/schema rules apply. Campaign request and row byte limits still apply;
   * no separate name-length, variable-count, string-length or numeric-representability limits apply.
   * Replay compares received JSON: object order is ignored, array order matters, and null differs from omission.
   * Exact decimal coefficient/exponent identity treats 1=1.0=1e0 and -0=0; distinct int64 values and string/number distinctions are preserved.
   * Use lossless SDK serialization for exact numbers; rounding can occur before transmission.
   */
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

@doc("Batch size and mutually exclusive execution counts per recipient intent. Counts are zero until preparation succeeds and all CallJobs are generated, then sum to total_recipients. Validation is reported through Campaign status and validation_errors.")
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

@doc("Business lifecycle of a Campaign; validation, cancellation and deletion have independent LROs. An executed Campaign completes when every recipient task is terminal, independently of individual call outcomes.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  @doc("Each validation round resolves and pins the owning Agent's latest version once, then snapshots/validates recipients and idempotently generates all CallJobs. Dispatch is gated until preparation succeeds. Cancel enters cancelling and waits for workers to quiesce.")
  validating: "validating",

  @doc("Preparation succeeded and all CallJobs are generated. Automatic execution includes waiting for schedules, capacity and retries; cancel stops new admission.")
  running: "running",

  @doc("New admission is closed while validation workers and admitted calls drain. Connected calls finish naturally. A failed cancellation monitor leaves this state and the dispatch gate closed; a fresh conditional cancel resumes draining.")
  cancelling: "cancelling",

  @doc("Execution-terminal: every recipient is terminal, including failures or expiry. Delete is allowed after quiescence; individual call outcomes determine success.")
  completed: "completed",

  @doc("Preparation failed and workers are quiescent; no calls were dispatched. A conditional PUT with complete inputs and a fresh Operation-Id replaces this failed configuration and reenters validating. Delete is also allowed; partial tasks remain fenced.")
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

  @doc("Authorized typed caller address. The connection validates which address variants it supports for the source role independently of recipient destination support. Generated CallJobs use the same TelephonyAddress representation.")
  source: TelephonyAddress;

  @doc("One to 100 inline recipients, mutually exclusive with recipient_dataset; missing, empty or conflicting sources return 400. The entire decoded UTF-8 request shares a 1 MiB budget, not one per recipient. Reads omit this array; retain the submission to correlate rows.")
  @minItems(1)
  @maxItems(100)
  @visibility(Lifecycle.Create)
  recipients?: TelephonyRecipient[];

  /**
   * Same-project uri_file Dataset; supply exactly one of recipient_dataset or recipients. Only single files are supported; folders fail validation.
   * Empty name or supplied version returns 400 before acceptance. Omitted version resolves to latest once per round, persisted before content reads;
   * retries reuse it and a consistent snapshot. Reads expose requested then resolved version; omitted unresolved versions stay absent.
   * Before content reads, the submitter's assets/read permission is rechecked on that version; failure prevents preparation/dispatch.
   * Bounded inspection uses metadata hints to detect CSV, JSON array or JSONL. Unsupported/ambiguous/malformed content fails preparation without format fallback.
   * destination_type/destination_value form TelephonyAddress; initially only phone_number/E.164 is valid.
   * These fields and scheduled_at are reserved, not variables. scheduled_at is required for recipient scheduling and forbidden otherwise.
   * Other top-level fields use the same structured-input parsing and Agent processing as inline recipients/direct CallJobs, including required/default/schema rules.
   * JSON and JSONL preserve nested objects, arrays and null. CSV cells remain strings without implicit JSON decoding.
   * Duplicate CSV headers or top-level JSON row fields fail validation. Each position, including repeated destinations, is a separate intended call.
   * Files allow 1-1,000,000 recipients, at most 256 MiB decoded bytes and 1 MiB per logical row.
   */
  recipient_dataset?: DatasetReference;

  @doc("Dispatch schedule. Omission defaults to immediate scheduling; an explicit ImmediateSchedule has the same behavior. Every mode waits for successful preparation and then dispatches subject to its schedule and capacity.")
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

  @doc("Opaque control-state token for conditional actions. Changes with lifecycle, a newly accepted operation or terminal cancellation/deletion failure, never from progress alone. This is not a validator for caching the full progress-bearing representation.")
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;

  @doc("Latest accepted validation/cancel/delete operation ID; retained after completion and changed only by a new accepted action, never an older completion. For discovery, not round identity: poll a request's returned Operation-Id/Operation-Location, not this changing pointer.")
  @visibility(Lifecycle.Read)
  operation_id: string;

  @doc("Time of terminal completion for the current round; cleared when failed preparation is replaced.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  @doc("Agent version pinned once at background validation start, before recipient validation/task generation. Omitted until resolved; cleared on failed-state replacement. Validation, retries, CallJobs and voice sessions share it despite later Agent updates. New rounds resolve latest. Resolution failure fails preparation; an unavailable pin fails preparation or the affected task without fallback.")
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

/**
 * Independent validation/cancel/delete monitor, bound to its original Campaign instance and round.
 * Validation succeeds after all CallJobs exist and dispatch is enabled, unless cancellation wins.
 * Cancellation succeeds after workers/admitted calls stop, without rewriting terminal validation.
 * New actions have distinct IDs; transport/worker retries reuse them, but failed cancel/delete resumes with a fresh operation.
 * Monitors omit result and remain queryable independently of the Campaign. PUT/cancel finish with a guarded Campaign GET; delete has none.
 * Later cancel/delete changes to Campaign.operation_id do not change the monitor's instance/round association or pinned Agent version.
 */
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

  @doc("Previous page's opaque last_id, bound to the original sort boundary, project/Agent and filters; error cursors also bind instance, round and snapshot, unchanged by cancellation. Not a name/row number; mutually exclusive with before. Invalid, altered or mismatched cursors return 400 invalid_cursor.")
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
