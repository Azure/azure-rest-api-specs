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
 * Numeric tokens are limited to 128 characters. Strings are limited to 16 KiB in UTF-8 at runtime.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignInputValue {
  string,
  float64,
  int64,
  boolean,
}

/** One recipient in an inline campaign input. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipient {
  /** Optional customer correlation key. It does not control deduplication; each input position is a separate recipient. */
  @minLength(1)
  @maxLength(256)
  key?: string;

  /** Telephone destination; the provider comes from the campaign connection. */
  destination: TelephonyOutboundDestination;

  /** Agent-declared inputs follow required/default/schema semantics. Extra scalars are dynamic variables. At most 128 keys, each 1-256 characters; values must obey the documented byte limits. */
  structured_inputs?: Record<TelephonyCampaignInputValue>;

  /** Earliest dispatch time for recipient scheduling. Required only when schedule.type is recipient; forbidden for other modes. */
  scheduled_at?: FoundryTimestamp;
}

/** How the recipient set is supplied. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignRecipientSourceType {
  string,

  /** Recipients embedded in the creation request. */
  inline: "inline",

  /** Recipients read from a project Dataset file version. */
  dataset: "dataset",
}

/** Source of the immutable recipient snapshot. */
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipientSource {
  /** Recipient source kind. */
  type: TelephonyCampaignRecipientSourceType;
}

/** Small recipient sets supplied with the Campaign. Creation bodies are limited to 1 MiB decoded UTF-8. Reads retain type but omit the array. Keep the original submission; only validation errors and materialized CallJobs are exposed. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model InlineTelephonyCampaignRecipientSource
  extends TelephonyCampaignRecipientSource {
  type: "inline";

  /** At most 100 inline recipients. Larger campaigns use a Dataset. */
  @minItems(1)
  @maxItems(100)
  recipients: TelephonyCampaignRecipient[];
}

/** Supported Dataset file encodings. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignDatasetFormat {
  string,

  /** Comma-separated values with a header row. */
  csv: "csv",

  /** A JSON array of recipient objects. */
  json: "json",

  /** One recipient object per line. */
  jsonl: "jsonl",
}

/**
 * An explicit Dataset file version in the current project; URLs and credentials are not accepted.
 * CSV columns and JSON/JSONL fields use phone_number for the required E.164 destination and key
 * for optional customer correlation. Field-name remapping is not supported.
 * In recipient scheduling mode, the selected time field is also reserved and is not a dynamic variable.
 * The file must contain 1-1,000,000 recipients and at most 256 MiB decoded bytes, with at most 1 MiB per logical row.
 * Duplicate CSV headers or JSON keys fail validation; no last-key-wins parsing. Other flat fields become structured inputs. CSV values preserve strings until parsed against
 * an Agent-declared input schema; undeclared values remain strings.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model DatasetTelephonyCampaignRecipientSource
  extends TelephonyCampaignRecipientSource {
  type: "dataset";

  /** Name of an existing file Dataset. */
  @minLength(1)
  dataset_name: string;

  /** Explicit Dataset version, not a mutable latest label. */
  @minLength(1)
  dataset_version: string;

  /** Encoding of the version's file content. */
  format: TelephonyCampaignDatasetFormat;
}

/** Mutually exclusive ways to determine each recipient's earliest dispatch time. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignScheduleType {
  string,

  /** Eligible after explicit start. */
  immediate: "immediate",

  /** One common earliest dispatch time. */
  scheduled: "scheduled",

  /** A separate earliest dispatch time for each recipient. */
  recipient: "recipient",
}

/** Scheduling never authorizes dialing: successful preparation and explicit start are required. */
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignSchedule {
  /** How each recipient's earliest dispatch time is determined. */
  type: TelephonyCampaignScheduleType;

  /** Exclusive deadline for new attempts, including retries; active calls may finish. Must be later than every scheduled_at. */
  expires_at?: FoundryTimestamp;
}

/** Dispatch as soon as capacity permits after explicit start. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@example(#{ type: "immediate" })
model ImmediateTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: "immediate";
}

/** Apply the same earliest dispatch time to every recipient. A past time means eligible now, not an error. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@example(#{
  type: "scheduled",
  scheduled_at: FoundryTimestamp.fromISO("2026-10-01T01:00:00Z"),
  expires_at: FoundryTimestamp.fromISO("2026-10-02T01:00:00Z"),
})
model ScheduledTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: "scheduled";

  /** Common earliest dispatch time; explicit start is still required. */
  scheduled_at: FoundryTimestamp;
}

/** Read a separate earliest dispatch time for every recipient. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@example(#{ type: "recipient", column: "call_at" })
model RecipientTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: "recipient";

  /** Dataset CSV column or JSON/JSONL field containing an RFC 3339 timestamp with an explicit offset or Z. Cannot be key or phone_number or an Agent input name. Inline recipients use scheduled_at and cannot select another column. */
  @minLength(1)
  column?: string = "scheduled_at";
}

/** Immutable Campaign configuration. Recipients are accepted only on creation; successful input rows are not a separate public resource. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputs {
  /** Human-readable project connection name, not a connection resource ID. */
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  /** Authorized phone number or Teams Resource Account UUID, inferred from the connection category. */
  source: TelephonyOutboundSource;

  /** Recipient source. Reads retain source kind and Dataset provenance but omit the inline array. Keep the original submission to correlate validation errors by input position. */
  recipients: TelephonyCampaignRecipientSource;

  /** Omit for immediate scheduling. Every mode requires successful preparation and explicit start. */
  schedule?: TelephonyCampaignSchedule;

  /** Per-recipient provider retries. Omit for a single attempt. */
  retry_policy?: TelephonyOutboundRetryPolicy;
}

/** Inputs accepted when creating the name-addressed Campaign. Server state and the path name cannot be supplied in the body. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@Azure.ClientGenerator.Core.clientName(
  "CreateTelephonyCampaignContent",
  "csharp"
)
model CreateTelephonyCampaignRequest {
  /** Complete immutable configuration and recipient source. */
  inputs: TelephonyCampaignInputs;
}

/** Readable input provenance without an embedded inline recipient array. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipientSourceSummary {
  /** Original input source kind. */
  type: TelephonyCampaignRecipientSourceType;

  /** Original Dataset name, present only for Dataset input. */
  dataset_name?: string;

  /** Original explicit Dataset version, present only for Dataset input. */
  dataset_version?: string;

  /** Original file format, present only for Dataset input. */
  format?: TelephonyCampaignDatasetFormat;
}

/** Readable immutable configuration without the recipient array. Validation diagnostics and CallJobs have separate list APIs. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputSummary {
  ...OmitProperties<TelephonyCampaignInputs, "recipients">;

  /** Source provenance, never the full inline array. */
  recipients: TelephonyCampaignRecipientSourceSummary;
}

/** Progress of the current validation pass. These counters may reset for a new Agent version; execution counters never reset. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationProgress {
  /** Agent version being checked. Absent until resolved. */
  agent_version?: string;

  /** Number of rows in this pass. Omitted until known; revalidation checks only unfinished recipients. */
  @minValue(0) total_recipients?: int64;

  /** Rows checked in this pass; equals valid_recipients plus invalid_recipients. */
  @minValue(0) checked_recipients: int64;

  /** Rows passing this validation pass. */
  @minValue(0) valid_recipients: int64;

  /** Rows rejected by validation. */
  @minValue(0) invalid_recipients: int64;
}

/** Mutually exclusive recipient execution counts, not provider-attempt counts. All are zero until initial validation succeeds. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignExecutionProgress {
  /** Recipients waiting for start, schedule, capacity, validation, or retry; includes paused work and lazy CallJob materialization. */
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

/** Validation and execution progress have different denominators and must not be added together. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignProgress {
  /** Total input rows, including invalid rows. Omitted until known; never an estimate. */
  @minValue(0) total_recipients?: int64;

  /** Current initial or Agent-version validation pass. */
  validation: TelephonyCampaignValidationProgress;

  /** Execution accounting for this Campaign. After successful preparation, the counts sum to total_recipients. */
  execution: TelephonyCampaignExecutionProgress;
}

/** Business lifecycle of a Campaign; creation preparation and cascade deletion are separate LROs. Expiry is a recipient outcome, never a Campaign status. An executed Campaign completes when all recipient tasks are terminal, even if some expired. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  /** Initial preparation or a coordinated Agent-version check; no new attempts are admitted. */
  validating: "validating",

  /** Preparation succeeded; waiting for the first explicit start, not for a scheduled time. */
  pending: "pending",

  running: "running",
  paused: "paused",
  cancelling: "cancelling",
  completed: "completed",
  failed: "failed",
  cancelled: "cancelled",

  /** Irreversible cascade cleanup; dialing and name reuse are blocked until deletion succeeds. A failed cleanup remains in this state and can be retried. */
  deleting: "deleting",
}

/** One immutable campaign execution. No configuration update, publish, republish, or campaign version exists. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  /** Business execution state, not an LRO completion signal. */
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  /** Initial preparation failure when failed, a recoverable validation/runtime blocker when paused, or cleanup failure when deleting. Cleared after successful recovery or when cleanup is retried. Never contains secrets or raw recipient values. */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /** Immutable customer-chosen name, unique within the project and Agent. */
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

  /** Immutable configuration. Reads retain source provenance but omit inline recipient arrays; use listValidationErrors for invalid rows and the existing CallJob list for execution details. */
  @visibility(Lifecycle.Read)
  inputs: TelephonyCampaignInputSummary;

  /** Creation time. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Last observable progress update. */
  @visibility(Lifecycle.Read) updated_at: FoundryTimestamp;

  /** Opaque control-state token for conditional actions. Changes with lifecycle, validated Agent version or a new name incarnation, never from progress alone. This is not a validator for caching the full progress-bearing representation. */
  @visibility(Lifecycle.Read) etag: Azure.Core.eTag;

  /** Immutable ID of the initial creation operation. Distinguishes reused names without a public Campaign version. */
  @visibility(Lifecycle.Read) creation_operation_id: string;

  /** Time at which the job entered a terminal status. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;

  /** Exact Agent version approved for the Campaign. Set only after successful validation and unchanged on failure. CallJobs compare it with latest when resolving and execute this explicit version. Absent until initial validation succeeds. */
  @visibility(Lifecycle.Read)
  locked_agent_version?: string;

  /** Available partial accounting even when the job fails or is cancelled. */
  @visibility(Lifecycle.Read) progress: TelephonyCampaignProgress;
}

/** One invalid input row in the current validation pass. Successful rows and execution outcomes are not returned here. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationError {
  /** Customer key if it could be parsed. */
  key?: string;

  /** One-based source row or inline item position. */
  @minValue(1) row_number: int64;

  /** Validation error for this row. param identifies the input field; never echoes raw values or secrets. Non-row source/runtime failures are returned through Campaign.error. */
  error: ApiError;
}

/** Error-only page. During validation this is a partial live view; an empty page does not establish success. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignValidationErrorPage {
  ...TelephonyCampaignPage<TelephonyCampaignValidationError>;

  /** Exact Agent version for this pass, omitted if Agent resolution has not succeeded. Shared by all errors on the page. */
  agent_version?: string;
}

/** Error pages use input-position ordering rather than Campaign creation-time ordering. */
alias TelephonyCampaignValidationErrorQueryParameters = {
  ...OmitProperties<TelephonyCampaignPageQueryParameters, "order">;

  /** Sort invalid rows by their original row_number. */
  @query order?: PageOrder = "desc";
};

/**
 * Status monitor for one creation or cascade-deletion request, not Campaign execution or each internal
 * validation pass. Automatic initial snapshotting and validation belong to the creation operation.
 * Later Agent-version revalidation does not create a public operation or reopen the completed creation
 * monitor; inspect Campaign status/progress and validation_errors instead. Start, pause and cancel
 * return Campaign state without creating another operation. Deletion has its own operation; transport
 * and internal worker retries reuse it, while an explicit retry after terminal deletion failure creates
 * a new operation and preserves the previous failure.
 * The monitor has no result or embedded row-error collection. Its error is a bounded failure summary;
 * current row diagnostics are paged separately and are not retained per operation. Create finishes with
 * a guarded Campaign GET; delete finishes without a result or final resource GET. Monitors are retained
 * independently of the resource.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  /** Creation time of this operation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time. Creation succeeds after the entire snapshot is validated and saved; deletion succeeds after the Campaign, its copied snapshot, validation diagnostics, internal recipient accounting, owned CallJobs/attempt records and pending dispatch/outbox records are removed. The source Dataset, connections, Agent configuration, actual call records, conversations and recordings are preserved. */
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

    /** Absolute URI including api-version of the creation monitor, returned without waiting for the full scan. Tracks initial preparation, not Campaign execution or later revalidation. */
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    /** ID of the one initial preparation monitor; preserved on idempotent retries. */
    @header("Operation-Id") operation_id: string;
  };

/** Bodyless acknowledgement of asynchronous cascade deletion. The SDK polls the retained monitor and completes with no result. */
alias TelephonyCampaignDeleteAcceptedResponse = TypeSpec.Http.AcceptedResponse & {
  /** Absolute deletion-monitor URI including api-version, retained after the Campaign is removed. */
  @pollingLocation
  @header("Operation-Location")
  operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

  /** Immutable deletion-operation ID; retries of the same accepted request return the same ID. */
  @header("Operation-Id") operation_id: string;

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

  /** Opaque last_id from the previous page. Binds the original sort boundary, project/Agent scope and filters; validation-error cursors also bind the Campaign incarnation and current internal validation pass. Never supply a name or row number. Cannot be combined with before. Invalid, altered or mismatched cursors return 400 invalid_cursor. */
  @query @continuationToken after?: string;

  /** Opaque first_id for backward traversal with unchanged scope/filters/order. Cannot be combined with after. Does not resolve the current resource by name. */
  @query before?: string;
};

/** Shared Foundry page shape with opaque boundary tokens rather than reusable resource names. */
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
  /** Starts pending work or continues paused work through required Agent-version checks. Never replays terminal recipients. Validating, cancelling and terminal states reject start with 409; paused means no validation worker remains active. With a current control token, repeated start while running returns current state. A stale token returns 412 before state checks. */
  @summary("Start a telephony campaign")
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:start")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  start is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact ETag from a fresh read; stale commands return 412 before changing state. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    TelephonyCampaignResponse
  >;
  /**
   * Creates an immutable named Campaign using the named PUT resource-creation LRO pattern.
   * Rejects invalid request shape, authorization or basic configuration before starting background work.
   * After durably recording the Campaign, creation monitor and recoverable background work, returns 201
   * with the Campaign and Operation-Id/Operation-Location without waiting for the complete recipient scan.
   * The Campaign normally reports validating; a fast scan may already be complete when polled.
   * Snapshotting and automatic validation share this one operation, not a second verify operation.
   * Success completes the monitor and enters pending until explicit start; failure completes it as failed
   * with a summary and exposes row diagnostics through validation_errors. Later Campaign state changes
   * never reopen the creation monitor or make poller completion authorize dialing.
   * A retained identical Operation-Id request replays its original 201 response and monitor without
   * restarting validation; changed inputs with that ID return 409 operation_id_conflict. Without that
   * replay key, an identical existing resource returns 200 and differing inputs return 409
   * campaign_inputs_conflict. Replays for a deleted instance return 409 campaign_deleted and never
   * affect a reused name. PUT does not permit overwriting an existing Campaign.
   */
  @summary("Create a telephony campaign")
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
    }
  )
  @put
  @parameterVisibility(Lifecycle.Create)
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(
    TelephonyCampaigns.getOperation,
    {
      operation_id: ResponseProperty<"operation_id">,
    }
  )
  @finalOperation(
    TelephonyCampaigns.get,
    {
      operation_id: ResponseProperty<"operation_id">,
    }
  )
  create is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable name chosen by the caller; existing resources cannot be overwritten. */
      @path campaign_name: TelephonyCampaignName;

      /** Optional retry identifier. Omitting it does not bypass name idempotency: identical existing inputs return 200; different inputs conflict. Preserve it for retries across deletion. */
      @header("Operation-Id")
      operationId?: string;

      /** Complete immutable Campaign definition. */
      @body body: CreateTelephonyCampaignRequest;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>
  >;

  /** Gets the current Campaign with source provenance but no inline array. An optional operation_id guards SDK final retrieval against deletion/name reuse: a different creation operation returns 409 campaign_instance_changed and a deleted resource returns 404. */
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

      /** Expected creation operation, copied from Operation-Id for the SDK final GET. Never returns a later same-name instance when supplied. */
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

  /** Stops future dispatch and retries for the conditionally selected instance; drains validation workers and admitted calls before terminal cancellation. A stale control token returns 412, including after name reuse. */
  @summary("Cancel a telephony campaign")
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:cancel")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  cancel is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact control token from this Campaign incarnation. Wildcards are rejected. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    TelephonyCampaignResponse
  >;

  /**
   * Asynchronously deletes a terminal, quiescent Campaign, its copied snapshot, validation diagnostics, internal recipient accounting,
   * every owned CallJob/attempt record and pending dispatch/outbox records. Other active states return
   * 409: cancel and drain first. Acceptance sets deleting, hides owned CallJobs/results from reads and
   * blocks name reuse until cleanup succeeds. Never deletes the source Dataset, connections, Agent
   * configuration or independent CallJobs. Actual call records, conversations and recordings are
   * preserved under independent retention. Cleanup is scoped by immutable incarnation, never name alone.
   * Failures remain deleting with an error; retry with a fresh Operation-Id and current token to resume
   * cleanup. Identical retained Operation-Id retries replay the original 202 before stale-token checks,
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
      operation_id: ResponseProperty<"operation_id">,
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

  /** Pauses running execution without disconnecting admitted calls. Initial or execution-time validating states reject pause with 409; use cancel to stop validation. Paused guarantees that no validation scan remains active. Repeating pause on paused work with its current control token returns the current state. Pending and terminal states reject pause. */
  @summary("Pause a telephony campaign")
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:pause")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  pause is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact etag from the latest read; stale commands return 412. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    TelephonyCampaignResponse
  >;

  /**
   * Lists only invalid rows from the current/latest validation pass, never successful rows or CallJob
   * results. This separate paged collection keeps potentially large diagnostics out of SDK operation
   * polling responses. The operation GET is not paginated and has only a bounded failure summary;
   * there is no operation-scoped error endpoint or public validation_operation_id.
   * During validating the list is partial; an empty page does not establish success or authorize start.
   * Campaign status determines completion. Each new pass atomically replaces the previous diagnostics,
   * including a retry for the same Agent version. There is no historical per-operation row-error archive;
   * callers needing a diagnostic copy should retrieve it before initiating another pass.
   * Opaque cursors bind the Campaign incarnation, internal validation pass and row_number boundary;
   * a changed pass or reused name returns 400 invalid_cursor. No public validation ID is required.
   * Successful validation returns an empty page. Execution failures belong to CallJobs, and non-row
   * failures to Campaign.error. Existing CallJobs and revalidation errors can coexist; use the filtered
   * CallJob list for execution details. Deleting returns 409 campaign_deleting; deleted Campaigns return 404.
   */
  @summary("List campaign validation errors")
  @opExample(
    #{
      returnType: #{
        data: #[
          #{
            row_number: 7,
            key: "recipient-7",
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

  /** Polls a creation or deletion operation independently of Campaign deletion/name reuse. Retained for the lifetime of the original resource and at least 24 hours after both operation completion and resource deletion. Nonterminal responses include Retry-After. This is not a paged diagnostic collection: failed operations contain a bounded error summary; current row errors are retrieved through listValidationErrors. Later revalidation never rewrites a terminal creation operation or creates a new public operation. Creation success uses a guarded final Campaign GET; deletion success has no result or final GET. Deletion cannot be cancelled. No standalone operation creation or business Preparation resource exists. */
  @summary("Get a campaign operation")
  @opExample(
    #{
      returnType: #{
        id: "prepare-appointment-reminders",
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
        status: "succeeded",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        finished_at: FoundryTimestamp.fromISO("2026-09-17T08:01:00Z"),
      },
    },
    #{ title: "Preparation finished before manual start" }
  )
  @opExample(
    #{
      returnType: #{
        id: "prepare-appointment-reminders",
        status: "failed",
        created_at: FoundryTimestamp.fromISO("2026-09-17T08:00:00Z"),
        finished_at: FoundryTimestamp.fromISO("2026-09-17T08:01:00Z"),
        error: #{
          code: "campaign_validation_failed",
          message: "Recipient validation failed. Inspect validation_errors, correct the inputs, and create a new Campaign.",
          param: "inputs.recipients",
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

      /** Immutable creation- or deletion-operation ID returned in Operation-Id. Authorization is checked against its saved project and Agent scope even after resource deletion. */
      @path operation_id: string;
    },
    JobStatusResponse<TelephonyCampaignOperation>
  >;
}
