import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

/**
 * Scalar template values. Objects, arrays, null and non-finite numbers are not accepted.
 * Numbers use JSON-number semantics, not separate int64/double wire tags: 1, 1.0 and 1e0 are
 * equivalent for replay; -0 equals 0. Replay uses the exact decimal coefficient/exponent of
 * the received JSON token, so distinct int64 values remain distinct even if binary64 rounding
 * would make them equal. Strings such as "1" remain distinct from numbers. Int64 values retain
 * exact precision; other numeric values must be finite binary64 without nonzero underflow to zero.
 * Replay comparison applies to the JSON actually received by the service. SDK serialization can round
 * caller-side numeric values before transmission; clients needing exact values must use a lossless
 * serialization path. A retry with the same serialized numeric values preserves replay identity.
 * Numeric tokens are limited to 128 characters. Strings are limited to 16 KiB in UTF-8 at runtime.
 */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Preserve the existing scalar-only Campaign input contract and SDK representation; adopting experimental union constraints would require project configs unsupported by the pinned SDK generation CLI."
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignInputValue {
  string,
  float64,
  int64,
  boolean,
}

/** One recipient in an inline campaign input. Each input position is a separate intended call, including repeated destinations. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyRecipient {
  /** Recipient destination address. Initial provider support accepts phone_number; non-phone variants can be introduced without replacing this field. Unsupported destination types fail preparation. */
  destination: TelephonyAddress;

  /** Agent-declared inputs follow required/default/schema semantics. Extra scalars are dynamic variables. At most 128 keys, each 1-256 characters; values must obey the documented byte limits. */
  structured_inputs?: Record<TelephonyCampaignInputValue>;

  /** Earliest dispatch time for recipient scheduling. Required only when schedule.type is recipient; forbidden for other modes. */
  scheduled_at?: FoundryTimestamp;
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
model ImmediateSchedule extends TelephonyCampaignSchedule {
  /** Identifies immediate scheduling after successful preparation. */
  type: TelephonyCampaignScheduleType.immediate;
}

/** Apply the same earliest dispatch time to every recipient. A past time is valid and makes work eligible after preparation succeeds. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model AtTimeSchedule extends TelephonyCampaignSchedule {
  /** Identifies scheduling with one common earliest dispatch time. */
  type: TelephonyCampaignScheduleType.scheduled;

  /** Common earliest dispatch time; successful preparation is required. */
  scheduled_at: FoundryTimestamp;
}

/** Read every recipient's earliest dispatch time from the fixed scheduled_at field. Dataset CSV/JSON/JSONL values use RFC 3339 with an explicit offset or Z; inline values use FoundryTimestamp. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model PerRecipientSchedule extends TelephonyCampaignSchedule {
  /** Identifies scheduling with a separate earliest dispatch time for each recipient. */
  type: TelephonyCampaignScheduleType.recipient;
}

/** Complete writable configuration shared by Campaign creation, replacement and reads. */
alias TelephonyCampaignConfiguration = {
  /** Human-readable name of the provider connection in the current project. */
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  /** Authorized typed caller address. The connection validates which address variants it supports for the source role independently of recipient destination support. Generated CallJobs use the same TelephonyAddress representation. */
  source: TelephonyAddress;

  /** One to 100 inline recipients. Supply either this array or recipient_dataset, not both. Missing, empty or conflicting recipient sources return 400. The entire creation body is limited to 1 MiB decoded UTF-8, including every recipient and configuration field; the budget is shared, not a per-recipient allowance. Reads omit this array, so retain the submission to correlate source rows. */
  @minItems(1)
  @maxItems(100)
  @visibility(Lifecycle.Create)
  recipients?: TelephonyRecipient[];

  /**
   * Generic same-project Dataset reference, mutually exclusive with recipients. Exactly one source is required.
   * Dataset name and any supplied version must be non-empty; invalid references return 400 before acceptance.
   * Campaign preparation requires a single-file (uri_file) Dataset; folder Datasets fail validation.
   * An omitted version resolves to latest once per validation round and is persisted before content reads.
   * Worker retries reuse that concrete version and consistent snapshot. Reads expose the requested version
   * before resolution and concrete version afterward; an omitted unresolved version remains absent.
   * The submitting principal's assets/read permission is checked again for the resolved version before content reads.
   * Authorization failure fails preparation and prevents dispatch.
   * Validation identifies CSV, JSON array or JSONL by bounded content inspection using file metadata as hints.
   * Unsupported, ambiguous or malformed content fails preparation; parse failure does not select another format.
   * Fixed destination_type and destination_value fields construct each recipient's TelephonyAddress.
   * Initially destination_type is phone_number and destination_value is E.164; unsupported types fail validation.
   * These fields and fixed scheduled_at are reserved and excluded from dynamic variables. scheduled_at is
   * required for recipient scheduling and forbidden in other modes. Other flat fields become structured inputs;
   * undeclared CSV cells remain strings. Duplicate headers or JSON keys fail validation.
   * Every input position is a separate intended call, including duplicate destinations.
   * Files contain 1-1,000,000 recipients, at most 256 MiB decoded bytes and 1 MiB per logical row.
   */
  recipient_dataset?: DatasetReference;

  /** Dispatch schedule. Omission defaults to immediate scheduling; an explicit ImmediateSchedule has the same behavior. Every mode waits for successful preparation and then dispatches subject to its schedule and capacity. */
  schedule?: TelephonyCampaignSchedule;

  /** Per-recipient provider retries. Omit for one initial attempt with no retry. Generated CallJobs return fixed_interval with max_attempts=1 and interval=0 seconds for an omitted policy. */
  retry_policy?: TelephonyOutboundRetryPolicy;
};

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

/** Business lifecycle of a Campaign; validation, cancellation and deletion have independent LROs. An executed Campaign completes when every recipient task is terminal, independently of individual call outcomes. */
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
  ...TelephonyCampaignConfiguration;

  /** Business execution state. Each asynchronous action has its own retained operation monitor. */
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  /** Preparation failure when failed, cancellation failure when cancelling, or cleanup failure when deleting. Cleared when that work is retried. Never contains secrets or raw recipient values. */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /** Immutable customer-chosen name, unique within the project and Agent. */
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

  /** Creation time. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Last observable progress update. */
  @visibility(Lifecycle.Read) updated_at: FoundryTimestamp;

  /** Opaque control-state token for conditional actions. Changes with lifecycle, a newly accepted operation or terminal cancellation/deletion failure, never from progress alone. This is not a validator for caching the full progress-bearing representation. */
  @visibility(Lifecycle.Read) etag: Azure.Core.eTag;

  /** ID of the most recently accepted asynchronous operation: validation, cancellation or deletion. Retained after completion and updated only when a new operation is accepted; completing an older operation never overwrites it. Use for operation discovery, not validation-round identity. Poll an individual request using its returned Operation-Id/Operation-Location rather than following this changing pointer. */
  @visibility(Lifecycle.Read) operation_id: string;

  /** Time of terminal completion for the current round; cleared when failed preparation is replaced. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;

  /** Exact owning Agent version selected once when background processing starts the current validating round. Omitted until resolution succeeds; cleared on failed-state replacement. The version is fixed before recipient validation or task generation and is shared by validation, worker retries, CallJobs and voice sessions for that round. New rounds resolve latest again; later Agent updates do not change an executing round. Resolution failure fails preparation; an unavailable pinned version fails preparation or the affected task without fallback. */
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
 * Each monitor remains associated with the Campaign instance and validation round that created it.
 * Cancellation and deletion can change Campaign.operation_id without changing that association or
 * the pinned Agent version.
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-contained named resources use FoundryDataPlaneRequiredPreviewOperation with shared job envelopes and paging; shared job templates have fixed project-level ID parameters."
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /**
   * Creates a named Campaign or fully replaces a failed Campaign's inputs, authorizing execution after validation.
   * Request-shape and caller authorization checks precede acceptance. New creation returns 201.
   * Failed-state replacement requires exact If-Match and a fresh Operation-Id and returns 200;
   * a missing replacement Operation-Id returns 400, stale token returns 412, invalid state returns 409.
   *
   * Acceptance returns the Campaign in validating state with a separate validation monitor
   * identified by Campaign.operation_id. Replacement starts a new round and resets previous errors,
   * finished_at, progress, Dataset resolution and locked_agent_version. Superseded diagnostics and
   * CallJobs are no longer listed, counted or dispatched, and old validation-error cursors become invalid.
   * Previous operation monitors and replay safeguards remain available.
   *
   * Background preparation resolves the owning Agent's latest authorized version and any omitted Dataset
   * version once per validation round, before recipient validation. Both versions remain fixed across retries.
   * Resolution failure fails preparation. Each input position produces one CallJob; dispatch starts only
   * after the complete recipient snapshot is validated and all CallJobs exist. Failed rounds never dial,
   * and preparation work has stopped before the Campaign reports failed. Immediate calls may start before
   * the PUT poller returns. Later Agent publication does not change the pinned execution version.
   *
   * Retrying Operation-Id with identical input and the original If-Match replays its receipt and monitor
   * before evaluating current ETag/state, without restarting a round or changing pinned versions.
   * Conflicting key reuse returns 409 operation_id_conflict. Retained superseded keys replay old monitors.
   * Without a matching replay, PUT with If-Match requires failed state and a fresh Operation-Id,
   * even if the complete input is unchanged (for example, retry after an Agent fix).
   * Without If-Match, equivalent existing input reads the current resource and monitor; different
   * input conflicts. Its response headers still identify the saved validation monitor, even if a later
   * cancel/delete changed Campaign.operation_id. Retried PUT never resets that public pointer.
   *
   * If-Match on a missing resource returns 412, never recreates a deleted Campaign.
   * Exactly one recipient source is required; omitted optional fields reset to defaults on replacement.
   * Replay compares original inputs including Dataset version omission, excluding resolved versions/defaults.
   * After deletion a retained PUT key returns 409 campaign_deleted; new intent requires a fresh key.
   * Running/completed/cancelled Campaigns cannot be replaced.
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
  create is FoundryDataPlaneRequiredPreviewOperation<
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
      @body campaign: TelephonyCampaign;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>
  >;

  /** Gets the current Campaign with source provenance but no inline array. Optional operation_id checks the saved operation's owning Campaign incarnation and internal validation round, NOT equality with Campaign.operation_id. A later cancellation on the same round is allowed; replacement/name reuse returns 409 campaign_operation_mismatch, missing/expired/wrong-scope operation or absent Campaign returns 404. Authorization precedes the lookup. */
  @summary("Get a telephony campaign")
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  get is FoundryDataPlaneRequiredPreviewOperation<
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
  list is FoundryDataPlaneRequiredPreviewOperation<
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
   * Acceptance stops new dispatch and retries, changes the Campaign to cancelling, and returns 202
   * with the cancellation monitor, Operation-Id, Operation-Location and Retry-After, even if already done.
   * Campaign.operation_id identifies the cancellation monitor; the validation round and pinned Agent
   * version are unchanged. Connected calls finish naturally. The Campaign becomes cancelled and its
   * cancellation operation succeeds only after preparation and admitted calls have stopped.
   * If cancellation wins preparation, the validation operation becomes cancelled after preparation
   * stops; an already succeeded validation operation remains succeeded.
   *
   * Operation-Id is optional; the service generates one when omitted. After authorization, identical
   * retained Operation-Id and original If-Match replay the same 202 before current-state/token checks,
   * including after deletion/name reuse, and never touch the replacement. Conflicting reuse returns 409.
   * With no replay, absent Campaign returns 404 and stale If-Match returns 412. A current-token
   * repeat in cancelling/cancelled returns the existing cancel monitor; a supplied fresh ID becomes an alias.
   *
   * A failed cancellation leaves the Campaign in cancelling with an error and dispatch disabled,
   * changes its etag, and fails only that cancellation monitor. A retry requires a fresh Operation-Id
   * and current If-Match; it creates a new monitor without changing previous failures.
   * Completed/failed/deleting Campaigns reject new cancellation with 409.
   * The SDK polls the accepted monitor, then performs a guarded Campaign GET.
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
  cancel is FoundryDataPlaneRequiredPreviewOperation<
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
   * Asynchronously deletes a terminal Campaign after preparation and admitted calls have stopped.
   * Cleanup includes its recipient snapshot, validation diagnostics, recipient accounting, every owned
   * CallJob/attempt record across all rounds, and pending dispatch work. Other active states return 409;
   * cancellation must finish before deletion. Acceptance sets deleting and Campaign.operation_id to
   * the deletion monitor, hides owned CallJobs/results from reads, and blocks name reuse until cleanup succeeds.
   *
   * The source Dataset, connections, Agent configuration and independent CallJobs are not deleted.
   * Actual call records, conversations and recordings retain their independent retention policies.
   * Cleanup affects only the Campaign instance associated with the accepted request, not a later
   * Campaign with the same name. Failures leave deleting with an error. A retry requires a fresh
   * Operation-Id and current If-Match; it resumes cleanup with a new monitor, updates Campaign.operation_id,
   * and preserves the validation round.
   *
   * Identical retained Operation-Id retries replay the original 202 before stale-token checks,
   * even after deletion/name reuse, without touching a replacement. Conflicting IDs return 409.
   * With no matching replay, absent names return 204 and stale tokens return 412. A current-token DELETE
   * during active cleanup returns its existing monitor; a fresh ID is bound to the same operation.
   * Names become reusable after successful cleanup; replay and duplicate-dialing safeguards remain.
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
  delete is FoundryDataPlaneRequiredPreviewOperation<
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
  listValidationErrors is FoundryDataPlaneRequiredPreviewOperation<
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
  getOperation is FoundryDataPlaneRequiredPreviewOperation<
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
