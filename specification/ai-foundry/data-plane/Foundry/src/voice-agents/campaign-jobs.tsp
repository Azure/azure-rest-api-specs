import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

/** Scalar template values. Objects, arrays, and null are not accepted. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignInputValue {
  string,
  numeric,
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

  /** Agent-declared inputs follow required/default/schema semantics. Extra scalars are dynamic variables. */
  structured_inputs?: Record<TelephonyCampaignInputValue>;

  /** Earliest dispatch time for recipient scheduling. Required only when schedule.type is recipient; forbidden for other modes. */
  scheduled_at?: FoundryTimestamp;
}

/** How the recipient set is supplied. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignRecipientSourceType {
  inline: "inline",
  dataset: "dataset",
}

/** Source of the immutable recipient snapshot. */
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipientSource {
  /** Recipient source kind. */
  type: TelephonyCampaignRecipientSourceType;
}

/** Small recipient sets supplied with the job. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model InlineTelephonyCampaignRecipientSource
  extends TelephonyCampaignRecipientSource {
  type: TelephonyCampaignRecipientSourceType.inline;

  /** At most 100 inline recipients. Larger campaigns use a Dataset. */
  @minItems(1)
  @maxItems(100)
  recipients: TelephonyCampaignRecipient[];
}

/** Supported Dataset file encodings. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignDatasetFormat {
  csv: "csv",
  json: "json",
  jsonl: "jsonl",
}

/**
 * An explicit Dataset file version in the current project; URLs and credentials are not accepted.
 * CSV columns and JSON/JSONL fields use phone_number for the required E.164 destination and key
 * for optional customer correlation. Field-name remapping is not supported.
 * In recipient scheduling mode, the selected time field is also reserved and is not a dynamic variable.
 * Other flat fields become structured inputs. CSV values preserve strings until parsed against
 * an Agent-declared input schema; undeclared values remain strings.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model DatasetTelephonyCampaignRecipientSource
  extends TelephonyCampaignRecipientSource {
  type: TelephonyCampaignRecipientSourceType.dataset;

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
  immediate: "immediate",
  scheduled: "scheduled",
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
model ImmediateTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.immediate;
}

/** Apply the same earliest dispatch time to every recipient. A past time means eligible now, not an error. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model ScheduledTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.scheduled;

  /** Common earliest dispatch time; explicit start is still required. */
  scheduled_at: FoundryTimestamp;
}

/** Read a separate earliest dispatch time for every recipient. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model RecipientTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: TelephonyCampaignScheduleType.recipient;

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

  /** Full recipient set, supplied only at creation. The service snapshots it consistently before validating and never rereads the original source for retries. */
  @visibility(Lifecycle.Create)
  recipients: TelephonyCampaignRecipientSource;

  /** Omit for immediate scheduling. Every mode requires successful preparation and explicit start. */
  schedule?: TelephonyCampaignSchedule;

  /** Per-recipient provider retries. Omit for a single attempt. */
  retry_policy?: TelephonyOutboundRetryPolicy;
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

  /** True only after the entire pass has been examined. Does not itself mean validation succeeded. */
  complete: boolean;
}

/** Mutually exclusive recipient execution counts, not provider-attempt counts. All are zero until initial validation succeeds. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignExecutionProgress {

  /** Recipients waiting for start, schedule, capacity, validation, or retry; includes paused work and lazy CallJob materialization. */
  @minValue(0) pending: int64;

  /** Recipients with a nonterminal provider call. */
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
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,63}$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  /** Immutable configuration. Read responses omit the recipient source and array; use listRecipientResults to inspect recipients. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  inputs: TelephonyCampaignInputs;

  /** Creation time. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Last observable progress update. */
  @visibility(Lifecycle.Read) updated_at: FoundryTimestamp;

  /** Opaque resource validator for If-Match on start/pause, not a campaign version. */
  @visibility(Lifecycle.Read) etag: Azure.Core.eTag;

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

/** The single server-created import-and-validate operation for a Campaign. Its completion does not wait for scheduled or active calls. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignPreparation is JobLike<TelephonyCampaign> {
  /** Creation time of preparation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time; succeeded means the entire recipient snapshot was validated and saved. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;
}
@@lroResult(TelephonyCampaignPreparation.result);

/** Returns the created business resource; the asynchronous preparation is polled separately. */
alias TelephonyCampaignCreatedResponse = TypeSpec.Http.Response<201> &
  TelephonyCampaign & {
    /** URI of the Campaign business resource. */
    @header("Location") location: string;

    /** URI of the automatically created preparation monitor, not the Campaign execution state. */
    @header("Operation-Location") operation_location: string;
  };

/** Filters combined with the shared cursor paging parameters. */
alias TelephonyCampaignFilters = {
  /** Filter by Campaign business state. */
  @query status?: TelephonyCampaignStatus;
};

/** Name-addressed Campaigns owned by the route Agent. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-contained named resources use FoundryDataPlanePreviewOperation with shared job envelopes and paging; shared job templates have fixed project-level ID parameters."
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /** Starts pending work or continues a paused Campaign through required Agent-version checks. Never replays terminal recipients. With a current ETag, repeated start while running returns current state. Any unfinished preparation or Agent validation rejects start with 409, including a paused Campaign with an in-flight check: it cannot authorize continuation or queue another check. Cancelling and terminal Campaigns also reject start. A stale If-Match returns 412 before state checks. */
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:start")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  start is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;

      /** Exact ETag from a fresh read; stale commands return 412 before changing state. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    TelephonyCampaign
  >;
  /** Accepts immutable inputs. Same Operation-Id replays the creation receipt; an existing Campaign name with a different Operation-Id conflicts. */
  @post
  @route("/agents/{agent_name}/telephony/campaigns")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(TelephonyCampaigns.getPreparation)
  create is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      ...WithOperationId;

      /** Complete immutable Campaign definition. */
      @body body: TelephonyCampaign;
    },
    TelephonyCampaignCreatedResponse
  >;

  /** Gets an Agent-owned Campaign without embedding its recipient source or array. */
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  get is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;
    },
    TelephonyCampaign
  >;

  /** Lists Agent-owned Campaigns without embedding recipient sources or arrays. Campaign names serve as paging IDs; ordering uses created_at and name. */
  @get
  @list
  @route("/agents/{agent_name}/telephony/campaigns")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  list is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
      ...TelephonyCampaignFilters;
    },
    AgentsPagedResult<TelephonyCampaign>
  >;

  /** Stops all future dispatch and retries; drains admitted calls before terminal cancellation. */
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:cancel")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  cancel is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;
    },
    TelephonyCampaign
  >;

  /** Deletes a terminal, quiescent Campaign; otherwise returns 409. Repeated deletion returns 204. Retained replay safeguards prevent accidental recreation. Does not delete conversations or recordings. */
  @delete
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  delete is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;
    },
    NoContentResponse
  >;

  /** Stops new attempts for running work or an execution-time validation. Already admitted calls and an in-flight check may finish but cannot undo this pause. Pending/initially validating/terminal Campaigns reject pause with 409. Pausing paused work returns its current state with a current ETag. */
  @post
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}:pause")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  pause is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;

      /** Exact etag from the latest read; stale commands return 412. */
      @header("If-Match") if_match: Azure.Core.eTag;
    },
    TelephonyCampaign
  >;

  /** Lists recipients and their current validation/execution outcomes in any Campaign state. Stable IDs and ordering, but no snapshot guarantee across requests; a new validation does not invalidate cursors. */
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
      @path campaign_name: string;

      ...CommonPageQueryParameters;

      /** Optional live outcome filter, usable before terminal execution. */
      @query status?: TelephonyCampaignRecipientResultStatus;

      /** Filter rows with or without validation errors, including errors that paused an already started Campaign. */
      @query has_validation_error?: boolean;
    },
    AgentsPagedResult<TelephonyCampaignRecipientResult>
  >;

  /** Polls the one preparation operation created automatically with the Campaign. There is no separate import/validate submission API. Succeeded contains the prepared Campaign, not final call outcomes. */
  @get
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/preparation")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  getPreparation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: string;
    },
    JobStatusResponse<TelephonyCampaignPreparation>
  >;
}
