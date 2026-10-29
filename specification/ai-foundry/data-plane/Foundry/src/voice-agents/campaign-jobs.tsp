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

/** Complete writable configuration shared by Campaign creation, replacement and reads. */
alias TelephonyCampaignConfiguration = {
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
};

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
  ...TelephonyCampaignConfiguration;

  @doc("Business execution state. Each asynchronous action has its own retained operation monitor.")
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  @doc("Preparation failure when failed, cancellation failure when cancelling, or cleanup failure when deleting. Cleared when that work is retried. Never contains secrets or raw recipient values.")
  @visibility(Lifecycle.Read)
  error?: ApiError;

  @doc("Immutable customer-chosen name, unique within the project and Agent.")
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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-scoped Campaign reads, cursor pages and retained monitors use Foundry operation wrappers; asynchronous actions reuse the shared configurable job templates."
@doc("Name-addressed Campaigns owned by the route Agent.")
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /**
   * Creates a named Campaign (201) or fully replaces a failed Campaign's inputs (200), authorizing calls after validation.
   * Shape/authorization checks precede acceptance. Replacement requires exact If-Match and fresh Operation-Id:
   * missing replacement ID returns 400, stale If-Match returns 412, and nonfailed state returns 409.
   * If-Match on an absent Campaign returns 412; it never recreates a deleted resource.
   * Supply exactly one recipient source; omitted optional fields reset to defaults on replacement.
   *
   * Acceptance returns validating and its separate monitor in operation_id. Replacement starts a new round,
   * resetting errors, finished_at, progress, Dataset resolution and locked_agent_version. Superseded diagnostics/CallJobs
   * disappear from lists, counts and dispatch; old validation-error cursors become invalid. Previous monitors/replay safeguards remain.
   *
   * Preparation pins the owning Agent's latest authorized version and any omitted Dataset version once per round before row validation.
   * Pins survive retries and later Agent updates; resolution failure fails preparation. Dispatch opens only after the full snapshot
   * validates and each input position has a CallJob. Failed rounds never dial and report failed only after preparation stops;
   * immediate calls may begin before the PUT poller returns.
   *
   * Identical Operation-Id, original inputs and original If-Match replay the saved receipt/monitor before current-state/token checks,
   * without restarting the round or changing pins. Conflicting reuse returns 409 operation_id_conflict; superseded keys replay old monitors.
   * Without replay, If-Match requires failed state and a fresh Operation-Id even for unchanged inputs. Without If-Match, equivalent
   * input returns the current resource/saved validation monitor; different input conflicts. Headers keep that monitor after later
   * cancel/delete, without resetting Campaign.operation_id. Replay compares submitted inputs, including Dataset version omission,
   * not resolved versions/defaults. After deletion, retained keys return 409 campaign_deleted; new intent needs a fresh key.
   */
  @summary("Create or replace a failed telephony campaign")
  @extension(
    "x-ms-examples",
    #{
      CreateImmediate: #{
        $ref: "../../examples/campaigns/CreateImmediate.json",
      },
      CreateScheduled: #{
        $ref: "../../examples/campaigns/CreateScheduled.json",
      },
      CreateRecipientScheduled: #{
        $ref: "../../examples/campaigns/CreateRecipientScheduled.json",
      },
      ReplaceFailedCampaign: #{
        $ref: "../../examples/campaigns/ReplaceFailedCampaign.json",
      },
    }
  )
  @put
  @parameterVisibility(Lifecycle.Create)
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(
    TelephonyCampaigns.getOperation,
    {
      operation_id: ResponseProperty<"operationId">,
    }
  )
  @finalOperation(
    TelephonyCampaigns.get,
    {
      operation_id: ResponseProperty<"operationId">,
    }
  )
  create is putJobPreview<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    TelephonyCampaign,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      @doc("Name chosen by the caller; only a failed Campaign permits full replacement.")
      @path
      campaign_name: TelephonyCampaignName;

      @doc("Retry identifier; required and fresh for intentional failed-state replacement. Preserve with original inputs and If-Match for transport retries.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;

      @doc("Required for failed-state replacement; omit on initial creation. Exact current control token; wildcards are rejected. Retry with the original token and Operation-Id.")
      @header("If-Match")
      if_match?: Azure.Core.eTag;

      @doc("Complete Campaign configuration for creation or failed-state replacement.")
      @body
      campaign: TelephonyCampaign;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  @doc("Gets the current Campaign with source provenance but no inline recipients, after authorization. Optional operation_id checks the saved instance/round, not the latest operation pointer: same-round cancellation is allowed; replacement/name reuse returns 409 campaign_operation_mismatch. Missing/expired/wrong-scope operations or absent Campaigns return 404.")
  @summary("Get a telephony campaign")
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  get is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      @doc("Immutable Campaign name.")
      @path
      campaign_name: TelephonyCampaignName;

      @doc("Initiating response's retained Operation-Id for guarded final GET, not a later Campaign.operation_id. Same-round actions preserve this guard; replacement/name reuse returns 409 campaign_operation_mismatch.")
      @query
      operation_id?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignResponse
  >;

  @doc("Lists Agent-owned Campaigns without inline arrays. Opaque continuation tokens retain the original created_at/internal-instance boundary across deletion and name reuse. Filters are live views, not a snapshot.")
  @summary("List telephony campaigns")
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  list is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      ...TelephonyCampaignPageQueryParameters;
      ...TelephonyCampaignFilters;
    },
    TelephonyCampaignPage<TelephonyCampaign> & {
      @doc("Progress-bearing list responses are not cacheable.")
      @header("Cache-Control")
      cache_control: "no-store";
    }
  >;

  /**
   * Starts cancellation for validating/running Campaigns with exact If-Match. Always returns 202 with the monitor,
   * Operation-Id, Operation-Location and Retry-After, even if already complete. Acceptance blocks new dispatch/retries,
   * sets cancelling and the latest operation_id, and preserves the validation round/Agent pin. Connected calls finish naturally;
   * the Campaign becomes cancelled and this monitor succeeds only after preparation/admitted calls stop.
   * If cancellation wins preparation, its validation monitor becomes cancelled after workers stop; an already succeeded monitor stays succeeded.
   *
   * Omitted Operation-Id is generated. After authorization, a retained ID and original If-Match replay 202 before current-state/token checks,
   * even after deletion/name reuse, without touching a replacement; conflicting reuse returns 409. Without replay, missing Campaign
   * returns 404 and stale If-Match returns 412. Current-token repeats in cancelling/cancelled reuse the monitor; a fresh ID aliases it.
   *
   * Failure leaves cancelling/error with dispatch disabled, changes etag and fails only this monitor. Resume with fresh Operation-Id
   * and current If-Match to create a new monitor while preserving previous failures. New cancellation of completed/failed/deleting
   * returns 409. The SDK polls the accepted monitor, then performs a guarded Campaign GET.
   */
  @summary("Cancel a telephony campaign")
  @extension(
    "x-ms-examples",
    #{
      CancelCampaign: #{ $ref: "../../examples/campaigns/CancelCampaign.json" },
    }
  )
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:cancel")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(
    TelephonyCampaigns.getOperation,
    {
      operation_id: ResponseProperty<"operationId">,
    }
  )
  @finalOperation(
    TelephonyCampaigns.get,
    {
      operation_id: ResponseProperty<"operationId">,
    }
  )
  cancel is cancelJobPreview<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    TelephonyCampaign,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      @doc("Campaign name.")
      @path
      campaign_name: TelephonyCampaignName;

      @doc("Exact control token. Preserve with Operation-Id for transport retries; wildcards are rejected.")
      @header("If-Match")
      if_match: Azure.Core.eTag;

      @doc("Optional idempotency identifier; distinct from validation/delete operations. Required and fresh to resume terminal cancellation failure.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignCancelAcceptedResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  /**
   * Asynchronously deletes a terminal Campaign after preparation/admitted calls stop; other active states return 409.
   * Cancellation must finish first. Cleanup removes recipient snapshots, validation diagnostics/accounting, owned CallJobs/attempts
   * from all rounds and pending dispatch work. Acceptance sets deleting and Campaign.operation_id to the deletion monitor,
   * hides owned jobs/results, and blocks name reuse until success. Dataset, connections, Agent configuration and independent CallJobs
   * remain; call records, conversations and recordings retain their own policies.
   *
   * Cleanup targets the accepted Campaign instance, never a later namesake. Failure leaves deleting/error; resume with fresh
   * Operation-Id and current If-Match to create a new monitor, update Campaign.operation_id and preserve the validation round.
   * Identical retained Operation-Id retries replay the original 202 before stale-token checks, including after deletion/name reuse.
   * Conflicting IDs return 409. Without replay, absent names return 204 and stale tokens return 412. Current-token DELETE during
   * cleanup reuses its monitor; a fresh ID aliases the same operation. Success frees the name but retains replay/duplicate-dialing safeguards.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Azure DELETE LRO pattern specifies a bodyless 202 with Operation-Location; polling returns the operation body."
  @summary("Delete a telephony campaign")
  @extension(
    "x-ms-examples",
    #{
      DeleteTerminalCampaign: #{
        $ref: "../../examples/campaigns/DeleteTerminalCampaign.json",
      },
    }
  )
  @delete
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(
    TelephonyCampaigns.getOperation,
    {
      operation_id: ResponseProperty<"operationId">,
    }
  )
  delete is deleteJobPreview<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      @doc("Immutable Campaign name.")
      @path
      campaign_name: TelephonyCampaignName;

      @doc("Exact control token for the instance being deleted. Wildcards are rejected; absent resources still return 204.")
      @header("If-Match")
      if_match: Azure.Core.eTag;

      @doc("Optional retry identifier, distinct from creation and previous failed deletion operations. Reuse with the identical original If-Match for transport retries; a changed precondition conflicts.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignDeleteAcceptedResponse | NoContentResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  /**
   * Lists detailed invalid-row diagnostics for the current round/pinned Agent; the monitor carries only a bounded summary.
   * During validating, results are partial and an empty page does not mean success. Input-position identities and cursors survive
   * worker retries/cancellation. Replacement resets the collection and invalidates cursors; diagnostics otherwise persist until deletion.
   * Successful validation yields no errors; execution failures appear in CallJobs, non-row preparation failures in Campaign.error.
   * Cursors bind instance, round and row_number boundary. Replaced rounds, reused names or invalid cursors return 400 invalid_cursor;
   * deleting returns 409 campaign_deleting, deleted Campaigns return 404.
   */
  @summary("List campaign validation errors")
  @opExample(
    #{
      returnType: #{
        cache_control: "no-store",
        data: #[
          #{
            row_number: 7,
            error: #{
              code: "invalid_recipient_schedule",
              message: "Provide a timestamp with an explicit timezone.",
              param: "scheduled_at",
            },
          }
        ],
        agent_version: "12",
        first_id: "opaque-first-error-cursor",
        last_id: "opaque-last-error-cursor",
        has_more: false,
      },
    },
    #{ title: "Only invalid input rows are returned" }
  )
  @opExample(
    #{
      returnType: #{
        cache_control: "no-store",
        data: #[],
        agent_version: "12",
        has_more: false,
      },
    },
    #{
      title: "No errors found; inspect Campaign status for validation completion",
    }
  )
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/validation_errors")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  listValidationErrors is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      @doc("Owning Agent; never overridden in recipient inputs.")
      @path
      agent_name: string;

      @doc("Immutable Campaign name.")
      @path
      campaign_name: TelephonyCampaignName;

      ...TelephonyCampaignValidationErrorQueryParameters;
    },
    TelephonyCampaignValidationErrorPage & TelephonyCampaignNoStoreResponse
  >;

  @doc("Polls one fixed validation/cancel/delete operation despite changes to Campaign.operation_id, replacement or deletion. Retained throughout Campaign lifetime and at least 24 hours after both completion and deletion. Pending responses include Retry-After; PUT/cancel use guarded final Campaign GETs, delete has none. Pollers never switch operations.")
  @summary("Get a campaign operation")
  @opExample(
    #{
      returnType: #{
        cache_control: "no-store",
        id: "prepare-appointment-reminders",
        kind: "validation",
        status: "in_progress",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        retryAfter: 5,
      },
    },
    #{ title: "Preparation is still validating recipients" }
  )
  @opExample(
    #{
      returnType: #{
        cache_control: "no-store",
        id: "prepare-appointment-reminders",
        kind: "validation",
        status: "succeeded",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        finished_at: FoundryTimestamp.fromISO("2026-09-17T08:01:00Z"),
      },
    },
    #{ title: "Preparation finished and automatic dispatch is enabled" }
  )
  @opExample(
    #{
      returnType: #{
        cache_control: "no-store",
        id: "prepare-appointment-reminders",
        kind: "validation",
        status: "failed",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        finished_at: FoundryTimestamp.fromISO("2026-09-17T08:01:00Z"),
        error: #{
          code: "campaign_validation_failed",
          message: "Recipient validation failed. Inspect validation_errors, correct the inputs, and PUT the complete replacement with current If-Match and a fresh Operation-Id.",
        },
      },
    },
    #{ title: "Validation failed without dialing" }
  )
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/operations/{operation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  getOperation is queryJobStatusPreview<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    TelephonyCampaignOperation,
    {
      @doc("Owning Agent.")
      @path
      agent_name: string;

      @doc("Immutable Campaign name.")
      @path
      campaign_name: TelephonyCampaignName;

      @doc("Stable validation-, cancellation- or deletion-operation ID returned in Operation-Id. Authorization is checked against its saved project and Agent scope even after resource deletion.")
      @path
      operation_id: TelephonyCampaignOperationId;
    },
    JobStatusResponse<TelephonyCampaignOperation> &
      TelephonyCampaignNoStoreResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;
}
