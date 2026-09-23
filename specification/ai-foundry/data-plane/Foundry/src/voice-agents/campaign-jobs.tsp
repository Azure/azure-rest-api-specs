import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

/**
 * Scalar template values. Objects, arrays, null and non-finite numbers are not accepted.
 * Numbers use JSON-number semantics, not separate int64/double wire tags: 1, 1.0 and 1e0 are
 * equivalent for replay; -0 equals 0. Compare normalized exact decimal coefficient/exponent
 * from the original JSON token before binary64 conversion. Never merge distinct int64 values
 * through float rounding. Strings such as "1" remain distinct from numbers. Preserve int64
 * values exactly; other values must convert to finite binary64 without nonzero underflow to zero.
 * Replay comparison applies to the JSON actually received by the service. SDK serialization can round
 * caller-side numeric values before transmission; clients needing exact values must use a lossless
 * serialization path. Retries preserve the same serialized numeric values.
 * Numeric tokens are limited to 128 characters. Strings are limited to 16 KiB in UTF-8 at runtime.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignInputValue {
  string,
  float64,
  int64,
  boolean,
}

/** One recipient in an inline campaign input. Each input position is a separate intended call, including repeated phone numbers. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipient {
  /** Recipient E.164 phone number; the provider comes from the Campaign connection. */
  @pattern("^\\+[1-9]\\d{1,14}$")
  phone_number: string;

  /** Agent-declared inputs follow required/default/schema semantics. Extra scalars are dynamic variables. At most 128 keys, each 1-256 characters; values must obey the documented byte limits. */
  structured_inputs?: Record<TelephonyCampaignInputValue>;

  /** Earliest dispatch time for recipient scheduling. Required only when schedule.type is recipient; forbidden for other modes. */
  scheduled_at?: FoundryTimestamp;
}

/**
 * Reference to a single-file (uri_file) Dataset in the current project.
 * During preparation, an omitted version resolves to the Dataset service's latest version once.
 * Persist that concrete version before reading content; preparation and execution retries
 * use the same version/snapshot. Reads return the resolved version once available.
 * Validation identifies CSV, JSON array or JSONL from bounded content inspection, using file metadata
 * as hints. Unsupported, ambiguous or malformed content fails preparation; a parse error is not
 * grounds to reinterpret the file as another format.
 * File fields use phone_number for the required E.164 destination. Each input position is a separate intended call.
 * The fixed scheduled_at field is reserved for per-recipient scheduling and excluded from structured inputs.
 * It is required when schedule.type is recipient and forbidden for other modes. Other flat fields become structured inputs; undeclared
 * CSV cells stay strings. Duplicate CSV headers or JSON keys fail validation.
 * Files contain 1-1,000,000 recipients and at most 256 MiB decoded bytes, with 1 MiB per logical row.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignDatasetReference {
  /** Name of an existing uri_file Dataset in this project. Folder Datasets are rejected during preparation. */
  @minLength(1)
  name: string;

  /** Omit on creation to resolve latest once during preparation. On reads, contains the concrete version after resolution, or the requested version before resolution. Remains absent while an omitted version is unresolved. */
  @minLength(1)
  version?: string;
}

/** Mutually exclusive ways to determine each recipient's earliest dispatch time. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignScheduleType {
  string,

  /** Eligible automatically after successful preparation. */
  immediate: "immediate",

  /** One common earliest dispatch time. */
  scheduled: "scheduled",

  /** A separate earliest dispatch time for each recipient. */
  recipient: "recipient",
}

/** Creation authorizes dialing; every scheduling mode waits for successful preparation. */
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignSchedule {
  /** How each recipient's earliest dispatch time is determined. */
  type: TelephonyCampaignScheduleType;

  /** Exclusive deadline for new attempts, including retries; active calls may finish. Must be later than every scheduled_at. */
  expires_at?: FoundryTimestamp;
}

/** Dispatch automatically as soon as preparation succeeds and capacity permits. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model ImmediateTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.immediate;
}

/** Apply the same earliest dispatch time to every recipient. A past time is valid and makes work eligible after preparation succeeds. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model ScheduledTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.scheduled;

  /** Common earliest dispatch time; successful preparation is required. */
  scheduled_at: FoundryTimestamp;
}

/** Read every recipient's earliest dispatch time from the fixed scheduled_at field. Dataset CSV/JSON/JSONL values use RFC 3339 with an explicit offset or Z; inline values use FoundryTimestamp. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model RecipientTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.recipient;
}

/** Complete Campaign configuration supplied on creation or replacement of failed preparation. Inputs stay fixed throughout a validation round and subsequent execution. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputs {
  /** Human-readable name of the provider connection in the current project. */
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  /** Authorized phone number or Teams Resource Account UUID, inferred from the connection category. */
  source: TelephonyOutboundSource;

  /** Inline recipients, mutually exclusive with recipient_dataset. Exactly one source is required; neither, both or an empty array returns 400. Reads omit this array; retain the original submission for row correlation. Creation body limit: 1 MiB decoded UTF-8. */
  @minItems(1)
  @maxItems(100)
  recipients?: TelephonyCampaignRecipient[];

  /** Dataset source, mutually exclusive with recipients. Exactly one source is required. Omitted version is resolved once during asynchronous preparation; file format is detected during validation. */
  recipient_dataset?: TelephonyCampaignDatasetReference;

  /** Omit for immediate scheduling. Every mode dispatches automatically after successful preparation, subject to its schedule. */
  schedule?: TelephonyCampaignSchedule;

  /** Per-recipient provider retries. Omit for one initial attempt with no retry. Generated CallJobs return fixed_interval with max_attempts=1 and interval=0 seconds for an omitted policy. */
  retry_policy?: TelephonyOutboundRetryPolicy;
}

/** Inputs accepted when creating the name-addressed Campaign. Server state and the path name cannot be supplied in the body. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@Azure.ClientGenerator.Core.clientName(
  "CreateTelephonyCampaignContent",
  "csharp"
)
model CreateTelephonyCampaignRequest {
  /** Complete configuration and recipient source for a new validation round; omitted optional fields use defaults rather than preserving previous values. */
  inputs: TelephonyCampaignInputs;
}

/** Readable configuration. Inline arrays are omitted. recipient_dataset is present only for Dataset input and reports the concrete version once resolved. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputSummary {
  ...OmitProperties<TelephonyCampaignInputs, "recipients">;
}

/** Batch size and mutually exclusive execution counts per recipient intent. Counts are zero until preparation succeeds and all CallJobs are generated, then sum to total_recipients. Validation is reported through Campaign status and validation_errors. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignProgress {
  /** Total input rows, including invalid rows. Omitted until known; never an estimate. */
  @minValue(0) total_recipients?: int64;

  /** Recipients waiting for their schedule, capacity or retry after preparation has completed. */
  @minValue(0) pending: int64;

  /** Recipients with a durable origination reservation or unresolved provider attempt, including dispatching before a call ID is received. */
  @minValue(0) active: int64;

  /** Recipients whose CallJob completed; not proof of business success. */
  @minValue(0) completed: int64;

  /** Recipients whose CallJob exhausted retries or failed. */
  @minValue(0) failed: int64;

  /** Recipients cancelled before completion. Does not include dispatch-window expiry. */
  @minValue(0) cancelled: int64;

  /** Recipients whose dispatch deadline elapsed before a new attempt could start. */
  @minValue(0) expired: int64;
}

/** Business lifecycle of a Campaign; validation, cancellation and deletion have independent LROs. Expiry is a recipient outcome, never a Campaign status. An executed Campaign completes when all recipient tasks are terminal, even if some expired. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  /** Each validation round resolves and pins the owning Agent's latest version once, then snapshots/validates recipients and idempotently generates all CallJobs. Dispatch is gated until preparation succeeds. Cancel enters cancelling and waits for workers to quiesce. */
  validating: "validating",

  /** Preparation succeeded and all CallJobs are generated. Automatic execution includes waiting for schedules, capacity and retries; cancel stops new admission. */
  running: "running",

  /** New admission is closed while validation workers and admitted calls drain. Connected calls finish naturally. A failed cancellation monitor leaves this state and the dispatch gate closed; a fresh conditional cancel resumes draining. */
  cancelling: "cancelling",

  /** Execution-terminal: every recipient is terminal, including failures or expiry. Delete is allowed after quiescence; individual call outcomes determine success. */
  completed: "completed",

  /** Preparation failed and workers are quiescent; no calls were dispatched. A conditional PUT with complete inputs and a fresh Operation-Id replaces this failed configuration and reenters validating. Delete is also allowed; partial tasks remain fenced. */
  failed: "failed",

  /** Execution-terminal: cancellation is complete and workers/admitted calls are quiescent. Delete is allowed; unfinished work cannot be restarted. */
  cancelled: "cancelled",

  /** Irreversible cascade cleanup; dialing and name reuse are blocked until deletion succeeds. A failed cleanup remains in this state and can be retried. */
  deleting: "deleting",
}

/** An Agent-owned Campaign. Creation and replacement of failed preparation authorize execution after validation; cancel and delete control its lifecycle. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  /** Business execution state. Each asynchronous action has its own retained operation monitor. */
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  /** Preparation failure when failed, cancellation failure when cancelling, or cleanup failure when deleting. Cleared when that work is retried. Never contains secrets or raw recipient values. */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /** Immutable customer-chosen name, unique within the project and Agent. */
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

  /** Configuration of the current validation round. A failed round permits full replacement by PUT. Reads omit inline recipient arrays; validation errors and CallJobs belong to the current round. */
  @visibility(Lifecycle.Read)
  inputs: TelephonyCampaignInputSummary;

  /** Creation time. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Last observable progress update. */
  @visibility(Lifecycle.Read) updated_at: FoundryTimestamp;

  /** Opaque control-state token for conditional actions. Changes with lifecycle, a newly accepted operation or terminal cancellation/deletion failure, never from progress alone. This is not a validator for caching the full progress-bearing representation. */
  @visibility(Lifecycle.Read) etag: Azure.Core.eTag;

  /** ID of the most recently accepted asynchronous operation: validation, cancellation or deletion. Retained after completion and updated only when a new operation is accepted; completing an older operation never overwrites it. Use for operation discovery, not validation-round identity. Poll an individual request using its returned Operation-Id/Operation-Location rather than following this changing pointer. */
  @visibility(Lifecycle.Read) operation_id: string;

  // Internal persistence/message field: execution_generation is an opaque, independently generated
  // token, never an Operation-Id. Create or failed-state PUT replacement assigns a fresh value;
  // request/worker retries, cancel and delete preserve it. Persist it with each task, queued message,
  // operation ownership record and cursor boundary. Reject stale work before writes or origination.
  // Check Campaign admission state as well: a matching generation alone does not authorize dialing.
  // This internal field is intentionally absent from the public TypeSpec model.

  /** Time of terminal completion for the current round; cleared when failed preparation is replaced. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;

  /** Exact owning Agent version selected once when background processing starts the current validating round. Omitted until resolution succeeds; cleared on failed-state replacement. Persist before recipient validation or task generation. Validation, worker retries, CallJobs and voice sessions use this version for the round. New rounds resolve latest again; later Agent updates do not change an executing round. Resolution failure fails preparation; an unavailable pinned version fails preparation or the affected task without fallback. */
  @visibility(Lifecycle.Read)
  locked_agent_version?: string;

  /** Available partial accounting even when the job fails or is cancelled. */
  @visibility(Lifecycle.Read) progress: TelephonyCampaignProgress;
}

/** Validation diagnostic for one invalid input row in the current validation round. Execution details are available through the CallJob list. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationError {
  /** One-based source row or inline item position. */
  @minValue(1) row_number: int64;

  /** Validation error for this row. param identifies the input field; never echoes raw values or secrets. Non-row source/runtime failures are returned through Campaign.error. */
  error: ApiError;
}

/** Error-only page. During validation this is a partial live view; an empty page does not establish success. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationErrorPage {
  ...TelephonyCampaignPage<TelephonyCampaignValidationError>;

  /** Pinned Agent version used for preparation, shared by all errors on the page. */
  agent_version?: string;
}

/** Error pages order diagnostics by their original input position. */
alias TelephonyCampaignValidationErrorQueryParameters = {
  ...OmitProperties<TelephonyCampaignPageQueryParameters, "order">;

  /** Sort invalid rows by their original row_number. */
  @query order?: PageOrder = "desc";
};

/** Kind of asynchronous work associated with a Campaign. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignOperationKind {
  string,
  /** Input validation and complete CallJob generation for a PUT. */
  validation: "validation",
  /** Stop future dispatch and drain admitted work. */
  cancel: "cancel",
  /** Cascade cleanup of Campaign task resources. */
  delete: "delete",
}

/**
 * Independent status monitor for validation, cancellation or deletion. PUT validation succeeds after
 * all tasks are generated and dispatch is enabled, unless cancellation won. Cancellation succeeds only
 * after workers and admitted calls stop; it does not rewrite an already terminal validation operation.
 * Each new action has a distinct ID; transport and worker retries reuse its monitor. A failed cancel/delete
 * is resumed with a fresh operation. Monitors omit result and remain queryable independently of the resource.
 * Create/replace and cancel use a guarded final Campaign GET; delete completes without a final GET.
 * Internal ownership associates every monitor with a resource incarnation and validation round. Accepting
 * cancel/delete changes the public operation pointer, not that round identity or the version pin.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  /** Work tracked by this monitor. */
  @visibility(Lifecycle.Read) kind: TelephonyCampaignOperationKind;

  /** Creation time of this operation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time of this operation. Validation completes after full preparation/task generation, cancellation after workers and admitted calls stop, deletion after Campaign task cleanup. Source Dataset, connections, Agent configuration, actual calls, conversations and recordings are preserved. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;
}
@@lroErrorResult(TelephonyCampaignOperation.error);

/** Campaign response. Dynamic progress is not cacheable; the body etag is used only for control-state concurrency. */
alias TelephonyCampaignResponse = TelephonyCampaign & {
  /** Prevents caches from treating the control token as a validator for changing progress. */
  @header("Cache-Control") cache_control: "no-store";
};

/** Returns the created business resource; the asynchronous operation is polled separately. */
alias TelephonyCampaignCreatedResponse<Status extends int32> = TypeSpec.Http.Response<Status> &
  TelephonyCampaignResponse & {
    /** URI of the Campaign business resource. */
    @header("Location")
    location: TypeSpec.Rest.ResourceLocation<TelephonyCampaign>;

    /** Absolute URI including api-version of the current validation round monitor, returned while the recipient scan proceeds asynchronously. Campaign state tracks subsequent execution. */
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    /** ID of this PUT's validation monitor; preserved on retries. May differ from the latest operation_id in the Campaign body after a later action. */
    @header("Operation-Id") operationId: string;
  };

/** Acknowledges asynchronous cancellation with its independent status monitor. */
alias TelephonyCampaignCancelAcceptedResponse = TypeSpec.Http.AcceptedResponse & {
  /** Cancellation monitor; its id matches Operation-Id. */
  @body body: TelephonyCampaignOperation;

  /** Absolute polling URI including api-version. */
  @pollingLocation
  @header("Operation-Location")
  operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

  /** Stable cancellation operation ID for this accepted request. */
  @header("Operation-Id") operationId: string;

  /** Suggested polling delay in seconds. */
  @header("Retry-After") retry_after: int32;
};

/** Bodyless acknowledgement of asynchronous cascade deletion. The SDK polls the retained monitor and completes with no result. */
alias TelephonyCampaignDeleteAcceptedResponse = TypeSpec.Http.AcceptedResponse & {
  /** Absolute deletion-monitor URI including api-version, retained after the Campaign is removed. */
  @pollingLocation
  @header("Operation-Location")
  operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

  /** Immutable deletion-operation ID; retries of the same accepted request return the same ID. */
  @header("Operation-Id") operationId: string;

  /** Suggested delay in seconds before polling. */
  @header("Retry-After") retry_after: int32;
};

/** Filters combined with the shared cursor paging parameters. */
alias TelephonyCampaignFilters = {
  /** Filter by Campaign business state. */
  @query status?: TelephonyCampaignStatus;
};

/** Campaign-scoped cursor parameters. Preserve shared wire names without treating reusable resource names as cursors. */
alias TelephonyCampaignPageQueryParameters = {
  ...OmitProperties<CommonPageQueryParameters, "after" | "before">;

  /** Opaque last_id from the previous page. Binds the original sort boundary, project/Agent scope and filters; validation-error cursors also bind the Campaign incarnation, internal validation round and input snapshot; cancelling does not change that round. Never supply a name or row number. Cannot be combined with before. Invalid, altered or mismatched cursors return 400 invalid_cursor. */
  @query @continuationToken after?: string;

  /** Opaque first_id for backward traversal with unchanged scope/filters/order. Cannot be combined with after. Does not resolve the current resource by name. */
  @query before?: string;
};

/** Shared Foundry page shape with opaque boundary tokens bound to the original sort position. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignPage<T> {
  ...OmitProperties<AgentsPagedResult<T>, "first_id" | "last_id">;

  /** Opaque boundary cursor for the first returned item; absent for an empty page. Not a Campaign name or recipient ID. */
  first_id?: string;

  /** Opaque boundary cursor for the last returned item; absent for an empty page. Captures its original immutable sort key, so deleting/reusing the resource name cannot move the boundary. */
  @continuationToken last_id?: string;
}

/** Name-addressed Campaigns owned by the route Agent. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-contained named resources use FoundryDataPlanePreviewOperation with shared job envelopes and paging; shared job templates have fixed project-level ID parameters."
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /**
   * Creates a named Campaign or fully replaces a failed Campaign's inputs, authorizing execution after validation.
   * Perform shape and caller authorization checks before acceptance. New creation returns 201.
   * Failed-state replacement requires exact If-Match and a fresh Operation-Id and returns 200;
   * a missing replacement Operation-Id returns 400, stale token returns 412, invalid state returns 409.
   * Atomically save complete inputs, a new independent internal execution_generation, validating state and durable work.
   * Create its validation monitor and set Campaign.operation_id to that monitor ID.
   * Clear previous error, finished_at, progress, Dataset resolution and locked_agent_version.
   * At the start of background validation, resolve the owning Agent's latest authorized version once.
   * Persist it before validating recipients or generating tasks. Resolution failure fails this round.
   * An omitted Dataset version also resolves again for each new round. Worker retries reuse both pins.
   * Snapshot/validate all recipients, then idempotently generate one CallJob per input position.
   * Dispatch remains gated until all tasks exist. Failed rounds never dial; workers stop before failed.
   * Replacement invalidates old error cursors and hides superseded diagnostics and partial tasks.
   * Old workers, callbacks, task IDs and queued events are fenced by execution_generation, not operation_id; asynchronously
   * remove superseded artifacts, preserving replay safeguards and all prior operation monitors.
   * Current-round task IDs include round identity; old tasks can neither dispatch nor enter its counts.
   * Retried Operation-Id with identical input and original If-Match replays its receipt and monitor
   * before evaluating current ETag/state, without restarting a round or changing pinned versions.
   * Conflicting key reuse returns 409 operation_id_conflict. Retained superseded keys replay old monitors.
   * Without a matching replay, PUT with If-Match requires failed state and a fresh Operation-Id,
   * even if the complete input is unchanged (for example, retry after an Agent fix).
   * Without If-Match, equivalent existing input reads the current resource and monitor; different
   * input conflicts. Its response headers still identify the saved validation monitor, even if a later
   * cancel/delete changed Campaign.operation_id. Retried PUT never resets that public pointer.
   * If-Match on a missing resource returns 412, never recreates a deleted Campaign.
   * Exactly one recipient source is required; omitted optional fields reset to defaults on replacement.
   * Replay compares original inputs including Dataset version omission, excluding resolved versions/defaults.
   * After deletion a retained PUT key returns 409 campaign_deleted; new intent requires a fresh key.
   * Immediate calls may start before the PUT poller returns. Running/completed/cancelled Campaigns
   * cannot be replaced; future Agent publication leaves their locked execution version unchanged.
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
  create is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Name chosen by the caller; only a failed Campaign permits full replacement. */
      @path campaign_name: TelephonyCampaignName;

      /** Retry identifier; required and fresh for intentional failed-state replacement. Preserve with original inputs and If-Match for transport retries. */
      @header("Operation-Id")
      operationId?: string;

      /** Required for failed-state replacement; omit on initial creation. Exact current control token; wildcards are rejected. Retry with the original token and Operation-Id. */
      @header("If-Match") if_match?: Azure.Core.eTag;

      /** Complete Campaign configuration for creation or failed-state replacement. */
      @body body: CreateTelephonyCampaignRequest;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>
  >;

  /** Gets the current Campaign with source provenance but no inline array. Optional operation_id checks the saved operation's owning Campaign incarnation and internal validation round, NOT equality with Campaign.operation_id. A later cancellation on the same round is allowed; replacement/name reuse returns 409 campaign_operation_mismatch, missing/expired/wrong-scope operation or absent Campaign returns 404. Authorization precedes the lookup. */
  @summary("Get a telephony campaign")
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  get is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Retained operation ID belonging to the expected Campaign incarnation/validation round. Use the initiating response ID for final GET; do not substitute a later Campaign.operation_id. Same-round actions preserve this guard; replacement/name reuse returns 409 campaign_operation_mismatch. */
      @query operation_id?: string;
    },
    TelephonyCampaignResponse
  >;

  /** Lists Agent-owned Campaigns without inline arrays. Opaque continuation tokens retain the original created_at/internal-instance boundary across deletion and name reuse. Filters are live views, not a snapshot. */
  @summary("List telephony campaigns")
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  list is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      ...TelephonyCampaignPageQueryParameters;
      ...TelephonyCampaignFilters;
    },
    TelephonyCampaignPage<TelephonyCampaign> & {
      /** Progress-bearing list responses are not cacheable. */
      @header("Cache-Control") cache_control: "no-store";
    }
  >;

  /**
   * Starts a cancellation LRO for validating or running Campaigns. Exact If-Match is required.
   * Atomically close new dispatch/retries, enter cancelling, create an independent cancel monitor
   * and update Campaign.operation_id. Keep the internal validation round and pinned Agent unchanged.
   * Return 202 with the monitor body, Operation-Id, Operation-Location and Retry-After, even if already done.
   * Drain preparation workers and admitted calls; connected calls finish naturally. On quiescence,
   * Campaign becomes cancelled and the cancel operation succeeds. If cancellation wins preparation,
   * its validation operation becomes cancelled after workers stop; an already succeeded validation stays succeeded.
   * Operation-Id is optional; the service generates one when omitted. After authorization, identical
   * retained Operation-Id and original If-Match replay the same 202 before current-state/token checks,
   * including after deletion/name reuse, and never touch the replacement. Conflicting reuse returns 409.
   * With no replay, absent Campaign returns 404 and stale If-Match returns 412. A current-token
   * repeat in cancelling/cancelled returns the existing cancel monitor; a supplied fresh ID becomes an alias.
   * Terminal cancel-worker failure leaves cancelling with an error and admission closed, rotates etag,
   * and fails only its monitor. Resume with a fresh Operation-Id/current If-Match, creating a new monitor;
   * preserve prior failures. This retry is required to provide Operation-Id. Completed/failed/deleting reject
   * new cancellation with 409. SDK polls this fixed monitor, then performs a guarded Campaign GET.
   */
  @summary("Cancel a telephony campaign")
  @extension(
    "x-ms-examples",
    #{ CancelCampaign: #{ $ref: "../../examples/campaigns/CancelCampaign.json" } }
  )
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:cancel")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(
    TelephonyCampaigns.getOperation,
    { operation_id: ResponseProperty<"operationId"> }
  )
  @finalOperation(
    TelephonyCampaigns.get,
    { operation_id: ResponseProperty<"operationId"> }
  )
  cancel is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact control token. Preserve with Operation-Id for transport retries; wildcards are rejected. */
      @header("If-Match") if_match: Azure.Core.eTag;

      /** Optional idempotency identifier; distinct from validation/delete operations. Required and fresh to resume terminal cancellation failure. */
      @header("Operation-Id") operationId?: string;
    },
    TelephonyCampaignCancelAcceptedResponse
  >;

  /**
   * Asynchronously deletes a terminal, quiescent Campaign, its copied snapshot, validation diagnostics, internal recipient accounting,
   * every owned CallJob/attempt record across all rounds and pending dispatch/outbox records. Other active states return
   * 409: cancel and drain first. Acceptance sets deleting and Campaign.operation_id to the new deletion
   * monitor, hides owned CallJobs/results from reads and
   * blocks name reuse until cleanup succeeds. Never deletes the source Dataset, connections, Agent
   * configuration or independent CallJobs. Actual call records, conversations and recordings are
   * preserved under independent retention. Cleanup is scoped by immutable incarnation, never name alone.
   * Failures remain deleting with an error; retry with a fresh Operation-Id and current token to resume
   * cleanup with a new monitor and update Campaign.operation_id; retain the internal round identity.
   * Identical retained Operation-Id retries replay the original 202 before stale-token checks,
   * even after deletion/name reuse, without touching a replacement. Conflicting IDs return 409.
   * With no matching replay, absent names return 204 and stale tokens return 412. A current-token DELETE
   * during active cleanup returns its existing monitor; a fresh ID is bound to the same operation.
   * No permanent name-reserving tombstone is kept; minimal replay and anti-redial safeguards remain.
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
  delete is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact control token for the instance being deleted. Wildcards are rejected; absent resources still return 204. */
      @header("If-Match") if_match: Azure.Core.eTag;

      /** Optional retry identifier, distinct from creation and previous failed deletion operations. Reuse with the identical original If-Match for transport retries; a changed precondition conflicts. */
      @header("Operation-Id") operationId?: string;
    },
    TelephonyCampaignDeleteAcceptedResponse | NoContentResponse
  >;

  /**
   * Lists invalid-row diagnostics from current validation round against the pinned Agent version.
   * The operation monitor returns a bounded summary; this collection pages detailed errors.
   * During validating the list is partial, and an empty page is not a completion signal.
   * Diagnostic identities are stable by input position within a round. Worker retries and cancellation
   * do not invalidate cursors; failed-state PUT replacement resets the collection and invalidates old
   * cursors. Diagnostics are retained until replacement or deletion. Successful validation has an empty error list; execution failures are
   * exposed through CallJobs and non-row preparation failures through Campaign.error.
   * Cursors bind the Campaign incarnation, internal validation round and row_number boundary; replaced rounds, reused names or invalid cursors
   * return 400 invalid_cursor. Deleting returns 409 campaign_deleting; deleted Campaigns return 404.
   */
  @summary("List campaign validation errors")
  @opExample(
    #{
      returnType: #{
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
    #{ returnType: #{ data: #[], agent_version: "12", has_more: false } },
    #{
      title: "No errors found; inspect Campaign status for validation completion",
    }
  )
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/validation_errors")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  listValidationErrors is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      ...TelephonyCampaignValidationErrorQueryParameters;
    },
    TelephonyCampaignValidationErrorPage
  >;

  /** Polls the exact validation, cancel or delete operation, independently of Campaign.operation_id, replacement, or resource deletion. Retained for the Campaign lifetime and at least 24 hours after both operation completion and resource deletion. Pending responses include Retry-After. PUT and cancel use guarded final Campaign GETs; delete has no final GET. Pollers never switch to a newer operation. */
  @summary("Get a campaign operation")
  @opExample(
    #{
      returnType: #{
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
        id: "prepare-appointment-reminders",
        kind: "validation",
        status: "failed",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        finished_at: FoundryTimestamp.fromISO("2026-09-17T08:01:00Z"),
        error: #{
          code: "campaign_validation_failed",
          message: "Recipient validation failed. Inspect validation_errors, correct the inputs, and PUT the complete replacement with current If-Match and a fresh Operation-Id.",
          param: "inputs",
        },
      },
    },
    #{ title: "Validation failed without dialing" }
  )
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/operations/{operation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  getOperation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Stable validation-, cancellation- or deletion-operation ID returned in Operation-Id. Authorization is checked against its saved project and Agent scope even after resource deletion. */
      @path operation_id: string;
    },
    JobStatusResponse<TelephonyCampaignOperation>
  >;
}
