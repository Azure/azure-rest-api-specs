import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

/** Immutable customer-chosen Campaign name within a project and Agent. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@minLength(1)
@maxLength(64)
@pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,63}$")
scalar TelephonyCampaignName extends string;

/** Scalar template values. Objects, arrays, and null are not accepted. */
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

  /** Agent-declared inputs follow required/default/schema semantics. Extra scalars are dynamic variables. */
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

/** Small recipient sets supplied with the job. */
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
 * Other flat fields become structured inputs. CSV values preserve strings until parsed against
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

  /** Full recipient set, supplied only at creation. The service snapshots it consistently before validating and never rereads the original source for retries. */
  @visibility(Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  name: TelephonyCampaignName;

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

/** The initial resource-creation status monitor. No result payload: after preparation succeeds the SDK retrieves the Campaign through the final GET operation. Its completion never waits for scheduled or active calls. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignPreparation is JobLike {
  /** Creation time of preparation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time; succeeded means the entire recipient snapshot was validated and saved. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;
}
@@lroErrorResult(TelephonyCampaignPreparation.error);

/** Returns the created business resource; the asynchronous preparation is polled separately. */
alias TelephonyCampaignCreatedResponse<Status extends int32> = TypeSpec.Http.Response<Status> &
  TelephonyCampaign & {
    /** URI of the Campaign business resource. */
    @header("Location")
    location: TypeSpec.Rest.ResourceLocation<TelephonyCampaign>;

    /** URI of the automatically created preparation monitor, not the Campaign execution state. */
    @pollingLocation
    @header("Operation-Location")
    operation_location: TypeSpec.Rest.ResourceLocation<TelephonyCampaignPreparation>;

    /** ID of the one initial preparation monitor; preserved on idempotent retries. */
    @header("Operation-Id") operation_id: string;
  };

/** Filters combined with the shared cursor paging parameters. */
alias TelephonyCampaignFilters = {
  /** Filter by Campaign business state. */
  @query status?: TelephonyCampaignStatus;
};

const exampleInlineRecipients: InlineTelephonyCampaignRecipientSource = #{
  type: "inline",
  recipients: #[
    #{
      destination: #{ type: "phone_number", value: "+14255550123" },
      structured_inputs: #{ customer_name: "Avery" },
    }
  ],
};
const exampleDatasetRecipients: DatasetTelephonyCampaignRecipientSource = #{
  type: "dataset",
  dataset_name: "reminder-recipients",
  dataset_version: "1",
  format: "csv",
};
const exampleCommonSchedule: ScheduledTelephonyCampaignSchedule = #{
  type: "scheduled",
  scheduled_at: FoundryTimestamp.fromISO("2026-10-01T01:00:00Z"),
};
const exampleRecipientSchedule: RecipientTelephonyCampaignSchedule = #{
  type: "recipient",
  column: "call_at",
};

/** Name-addressed Campaigns owned by the route Agent. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-contained named resources use FoundryDataPlanePreviewOperation with shared job envelopes and paging; shared job templates have fixed project-level ID parameters."
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /** Starts pending work or continues a paused Campaign through required Agent-version checks. Never replays terminal recipients. With a current ETag, repeated start while running returns current state. Any unfinished preparation or Agent validation rejects start with 409, including a paused Campaign with an in-flight check: it cannot authorize continuation or queue another check. Cancelling and terminal Campaigns also reject start. A stale If-Match returns 412 before state checks. */
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
    TelephonyCampaign
  >;
  /** Creates an immutable named Campaign and its preparation monitor. Returns 201 on first creation and 200 with the existing resource for identical inputs; differing inputs return 409 campaign_inputs_conflict. Retries never restart preparation or dialing. Operation-Id collisions with a different request return 409 operation_id_conflict. The monitor completes after initial validation, before any manual start or scheduled call. */
  @summary("Create a telephony campaign")
  @opExample(
    #{
      parameters: #{
        agent_name: "contoso-reminder-agent",
        campaign_name: "appointment-reminders",
        apiVersion: "v1",
        body: #{
          inputs: #{
            connection_name: "contoso-phone-provider",
            source: "+14255550100",
            recipients: exampleInlineRecipients,
          },
        },
      },
    },
    #{ title: "Prepare immediate calls without dialing" }
  )
  @opExample(
    #{
      parameters: #{
        agent_name: "contoso-reminder-agent",
        campaign_name: "scheduled-reminders",
        apiVersion: "v1",
        body: #{
          inputs: #{
            connection_name: "contoso-phone-provider",
            source: "+14255550100",
            recipients: exampleDatasetRecipients,
            schedule: exampleCommonSchedule,
          },
        },
      },
    },
    #{ title: "Prepare calls with a common scheduled time" }
  )
  @opExample(
    #{
      parameters: #{
        agent_name: "contoso-reminder-agent",
        campaign_name: "recipient-time-reminders",
        apiVersion: "v1",
        body: #{
          inputs: #{
            connection_name: "contoso-phone-provider",
            source: "+14255550100",
            recipients: exampleDatasetRecipients,
            schedule: exampleRecipientSchedule,
          },
        },
      },
    },
    #{ title: "Prepare calls with a per-recipient time column" }
  )
  @put
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  @pollingOperation(TelephonyCampaigns.getPreparation)
  @finalOperation(TelephonyCampaigns.get)
  create is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent; never overridden in recipient inputs. */
      @path agent_name: string;

      /** Immutable name chosen by the caller; existing resources cannot be overwritten. */
      @path campaign_name: TelephonyCampaignName;

      ...WithOperationId;

      /** Complete immutable Campaign definition. */
      @body body: CreateTelephonyCampaignRequest;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>
  >;

  /** Gets an Agent-owned Campaign without embedding its recipient source or array. */
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
    },
    TelephonyCampaign
  >;

  /** Lists Agent-owned Campaigns without embedding recipient sources or arrays. Campaign names serve as paging IDs; ordering uses created_at and name. */
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

      ...CommonPageQueryParameters;
      ...TelephonyCampaignFilters;
    },
    AgentsPagedResult<TelephonyCampaign>
  >;

  /** Stops all future dispatch and retries; drains admitted calls before terminal cancellation. */
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
    },
    TelephonyCampaign
  >;

  /** Deletes a terminal, quiescent Campaign; otherwise returns 409. Repeated deletion returns 204. Retained replay safeguards prevent accidental recreation. Does not delete conversations or recordings. */
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
    },
    NoContentResponse
  >;

  /** Stops new attempts for running work or an execution-time validation. Already admitted calls and an in-flight check may finish but cannot undo this pause. Pending/initially validating/terminal Campaigns reject pause with 409. Pausing paused work returns its current state with a current ETag. */
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
    TelephonyCampaign
  >;

  /** Lists recipients and their current validation/execution outcomes in any Campaign state. Stable IDs and ordering, but no snapshot guarantee across requests; a new validation does not invalidate cursors. */
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

      ...CommonPageQueryParameters;

      /** Optional live outcome filter, usable before terminal execution. */
      @query status?: TelephonyCampaignRecipientResultStatus;

      /** Filter rows with or without validation errors, including errors that paused an already started Campaign. */
      @query has_validation_error?: boolean;
    },
    AgentsPagedResult<TelephonyCampaignRecipientResult>
  >;

  /** Polls the preparation operation created with the Campaign. Nonterminal responses include Retry-After. On success, retrieve the Campaign with GET; on failure, error contains the cause. There is no separate import/validate submission and no call-outcome result in this monitor. */
  @summary("Get campaign preparation status")
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
  @route("/agents/{agent_name}/telephony/campaigns/{campaign_name}/preparation")
  @extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
  getPreparation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** Owning Agent. */
      @path agent_name: string;

      /** Immutable Campaign name. */
      @path campaign_name: TelephonyCampaignName;
    },
    JobStatusResponse<TelephonyCampaignPreparation>
  >;
}
