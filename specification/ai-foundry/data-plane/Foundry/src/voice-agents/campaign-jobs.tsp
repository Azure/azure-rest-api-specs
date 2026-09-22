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

/** Small recipient sets supplied with the Campaign. Creation bodies are limited to 1 MiB decoded UTF-8. Reads retain type but omit the array; use recipient_results. */
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

/** Immutable Campaign configuration. Recipients are accepted only on creation and read through the paged recipient list. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputs {
  /** Human-readable project connection name, not a connection resource ID. */
  @minLength(1)
  @maxLength(256)
  connection_name: string;

  /** Authorized phone number or Teams Resource Account UUID, inferred from the connection category. */
  source: TelephonyOutboundSource;

  /** Recipient source. Reads retain the source kind and Dataset provenance but omit the inline array, which is available through the paged recipient list. */
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

/** Readable immutable configuration. Full recipient values are available in the paged recipient list. */
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

/** Business lifecycle of a Campaign; only preparation is an LRO. Expiry is a recipient outcome, never a Campaign status. An executed Campaign completes when all recipient tasks are terminal, even if some expired. */
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
}

/** One immutable campaign execution. No configuration update, publish, republish, or campaign version exists. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  /** Business execution state, not an LRO completion signal. */
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  /** Initial preparation failure when failed, or a recoverable validation/runtime blocker when paused. Cleared after successful recovery. Never contains secrets or raw recipient values. */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /** Immutable customer-chosen name, unique within the project and Agent. */
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

  /** Immutable configuration. Reads retain source provenance but omit inline recipient arrays; use listRecipientResults for rows. */
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

/** Execution outcome of one recipient. Validation belongs to the Campaign and row validation_error, not this status. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignRecipientResultStatus {
  string,

  /** Not executed, including unchecked or invalid input. Does not imply validation passed or dialing is authorized. */
  pending: "pending",

  active: "active",
  completed: "completed",
  failed: "failed",
  cancelled: "cancelled",
  expired: "expired",
}

/** Durable row-level validation or execution evidence, contained by one job. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipientResult {
  /** Stable service-generated recipient ID, persisted by input position; also used for paging. Never derived from a phone number or customer key. */
  id: string;

  /** Customer key if it could be parsed. */
  key?: string;

  /** One-based source row or inline item position. */
  @minValue(1) row_number: int64;

  /** Timestamp used for stable cursor ordering. */
  created_at: FoundryTimestamp;

  /** Parsed destination for display; absent when the source destination is invalid. */
  destination?: TelephonyOutboundDestination;

  /** Saved caller inputs before Agent defaults. Available after parsing; reserved file control columns are excluded. */
  structured_inputs?: Record<TelephonyCampaignInputValue>;

  /** Resolved earliest dispatch time. Absent for immediate mode or an invalid source value. */
  scheduled_at?: FoundryTimestamp;

  /** Execution outcome only. Before initial execution, rows remain pending, including after preparation fails or is cancelled. Validation errors never replace execution state; Campaign admission controls dialing. */
  status: TelephonyCampaignRecipientResultStatus;

  /** Execution error; never includes secrets or raw source values. */
  error?: ApiError;

  /** Error from the most recent check of this row, independent of its execution outcome. Cleared when this row is checked successfully. */
  validation_error?: ApiError;

  /** Agent version for this row's last validation, when available. Allows older diagnostics to be distinguished during a new pass. */
  validation_agent_version?: string;

  /** Existing CallJob identifier, present once a call job has been materialized. */
  call_job_id?: TelephonyCallJobId;

  /** Exact locked version used for the latest admitted attempt, not another latest lookup. Each subsequent attempt compares the Campaign lock with latest before proceeding. Never caller-configurable. */
  resolved_agent_version?: string;
}

/** The initial resource-creation status monitor. No result payload: after preparation succeeds the SDK retrieves the Campaign through the final GET operation. Its completion never waits for scheduled or active calls. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  /** Creation time of the initial validation operation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time after the worker is quiescent; succeeded means the entire snapshot was validated and saved. */
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

    /** URI of the automatically created preparation monitor, not the Campaign execution state. */
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignOperation>;

    /** ID of the one initial preparation monitor; preserved on idempotent retries. */
    @header("Operation-Id") operation_id: string;
  };

/** Filters combined with the shared cursor paging parameters. */
alias TelephonyCampaignFilters = {
  /** Filter by Campaign business state. */
  @query status?: TelephonyCampaignStatus;
};

/** Campaign-scoped cursor parameters. Preserve shared wire names without treating reusable resource names as cursors. */
alias TelephonyCampaignPageQueryParameters = {
  ...OmitProperties<CommonPageQueryParameters, "after" | "before">;

  /** Opaque last_id from the previous page. Binds the original sort boundary, project/Agent scope and filters; recipient cursors also bind the Campaign incarnation. Never supply a name or row ID. Cannot be combined with before. Invalid, altered or mismatched cursors return 400 invalid_cursor. */
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
  /** Creates an immutable named Campaign and starts asynchronous validation. A retained identical Operation-Id request replays its original 201 response and monitor; changed inputs with that ID return 409 operation_id_conflict. Without that replay key, an identical existing resource returns 200 and differing inputs return 409 campaign_inputs_conflict. Replays for a deleted instance return 409 campaign_deleted and never affect a reused name. */
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

  /** Deletes the conditionally selected terminal, quiescent Campaign; nonterminal work returns 409. Missing names return 204; reused names with an old control token return 412. Immediately releases the name, without a name-reserving tombstone. Retains operation polling/replay records for at least 24 hours after completion and deletion, without deleting conversations or recordings. */
  @summary("Delete a telephony campaign")
  @delete
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  delete is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      /** Exact control token for the instance being deleted. Wildcards are rejected; absent resources still return 204. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    NoContentResponse
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

  /** Lists recipients with live filters. Opaque cursors bind the Campaign incarnation and original row sort boundary; a cursor from a deleted same-name Campaign returns 400 invalid_cursor, never rows from its replacement. New validation of the same instance does not invalidate cursors. */
  @summary("List campaign recipient results")
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/recipient_results")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  listRecipientResults is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;

      ...TelephonyCampaignPageQueryParameters;

      /** Optional live outcome filter, usable before terminal execution. */
      @query status?: TelephonyCampaignRecipientResultStatus;

      /** Filter rows with or without validation errors, including errors that paused an already started Campaign. */
      @query has_validation_error?: boolean;
    },
    TelephonyCampaignPage<TelephonyCampaignRecipientResult>
  >;

  /** Polls an immutable creation operation independently of Campaign deletion/name reuse. Retained for the lifetime of the original resource and at least 24 hours after both operation completion and resource deletion. Nonterminal responses include Retry-After. On success, GET the Campaign with operation_id to avoid reading a reused name. No standalone operation creation or business Preparation resource exists. */
  @summary("Get a campaign creation operation")
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
          message: "Recipient validation failed. Inspect recipient_results, correct the inputs, and create a new Campaign.",
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

      /** Immutable creation-operation ID returned in Operation-Id. Authorization is checked against its saved project and Agent scope. */
      @path operation_id: string;
    },
    JobStatusResponse<TelephonyCampaignOperation>
  >;
}
