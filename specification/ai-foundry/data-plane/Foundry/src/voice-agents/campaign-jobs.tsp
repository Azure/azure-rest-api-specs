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

/** One recipient in an inline campaign input. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignRecipient {
  /** Optional customer correlation key. Deduplication uses input position; each position is a separate recipient. */
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

/**
 * Reference to a single-file (uri_file) Dataset in the current project.
 * During preparation, an omitted version resolves to the Dataset service's latest version once.
 * Persist that concrete version before reading content; preparation and execution retries
 * use the same version/snapshot. Reads return the resolved version once available.
 * Validation identifies CSV, JSON array or JSONL from bounded content inspection, using file metadata
 * as hints. Unsupported, ambiguous or malformed content fails preparation; a parse error is not
 * grounds to reinterpret the file as another format.
 * File fields use phone_number for the required E.164 destination and key for optional correlation.
 * The selected scheduling field is reserved. Other flat fields become structured inputs; undeclared
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
@example(#{ type: "immediate" })
model ImmediateTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: "immediate";
}

/** Apply the same earliest dispatch time to every recipient. A past time is valid and makes work eligible after preparation succeeds. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@example(#{
  type: "scheduled",
  scheduled_at: FoundryTimestamp.fromISO("2026-10-01T01:00:00Z"),
  expires_at: FoundryTimestamp.fromISO("2026-10-02T01:00:00Z"),
})
model ScheduledTelephonyCampaignSchedule extends TelephonyCampaignSchedule {
  type: "scheduled";

  /** Common earliest dispatch time; successful preparation is required. */
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

/** Immutable Campaign configuration. Recipients are accepted on creation and validated before CallJobs become eligible for automatic dispatch. */
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

/** Readable configuration. Inline arrays are omitted. recipient_dataset is present only for Dataset input and reports the concrete version once resolved. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignInputSummary {
  ...OmitProperties<TelephonyCampaignInputs, "recipients">;
}

/** Mutually exclusive execution counts measured per recipient intent. All are zero until preparation succeeds and all CallJobs are generated. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignExecutionProgress {
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

/** Batch size and outbound execution progress. Validation is reported through Campaign status and validation_errors. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignProgress {
  /** Total input rows, including invalid rows. Omitted until known; never an estimate. */
  @minValue(0) total_recipients?: int64;

  /** Execution accounting for this Campaign. After successful preparation, the counts sum to total_recipients. */
  execution: TelephonyCampaignExecutionProgress;
}

/** Business lifecycle of a Campaign; creation preparation and cascade deletion are separate LROs. Expiry is a recipient outcome, never a Campaign status. An executed Campaign completes when all recipient tasks are terminal, even if some expired. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCampaignStatus {
  string,

  /** Snapshotting, validation against the pinned Agent version and idempotent generation of all CallJobs. Dispatch is gated until preparation succeeds. Cancel enters cancelling and waits for workers to quiesce. */
  validating: "validating",

  /** Preparation succeeded and all CallJobs are generated. Automatic execution includes waiting for schedules, capacity and retries; cancel stops new admission. */
  running: "running",

  /** New admission is closed while validation workers and admitted calls drain. Repeated cancel is idempotent; connected calls finish naturally. */
  cancelling: "cancelling",

  /** Execution-terminal: every recipient is terminal, including failures or expiry. Delete is allowed after quiescence; individual call outcomes determine success. */
  completed: "completed",

  /** Preparation failed and workers are quiescent; no calls were dispatched. Partial task materialization remains fenced. Correct the inputs/Agent and create a new Campaign. This terminal state permits delete. */
  failed: "failed",

  /** Execution-terminal: cancellation is complete and workers/admitted calls are quiescent. Delete is allowed; unfinished work cannot be restarted. */
  cancelled: "cancelled",

  /** Irreversible cascade cleanup; dialing and name reuse are blocked until deletion succeeds. A failed cleanup remains in this state and can be retried. */
  deleting: "deleting",
}

/** One immutable Campaign execution authorized at creation, with cancel and deletion controls. */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaign {
  /** Business execution state. Creation and deletion completion are tracked by their operation monitors. */
  @visibility(Lifecycle.Read)
  status: TelephonyCampaignStatus;

  /** Preparation failure when failed or cleanup failure when deleting. Cleanup errors are cleared when cleanup is retried. Never contains secrets or raw recipient values. */
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

  /** Opaque control-state token for conditional actions. Changes with lifecycle or a new name incarnation, never from progress alone. This is not a validator for caching the full progress-bearing representation. */
  @visibility(Lifecycle.Read) etag: Azure.Core.eTag;

  /** Immutable ID of the initial creation operation. Distinguishes reused names without a public Campaign version. */
  @visibility(Lifecycle.Read) creation_operation_id: string;

  /** Time at which the job entered a terminal status. */
  @visibility(Lifecycle.Read) finished_at?: FoundryTimestamp;

  /** Exact owning Agent version resolved from latest and persisted before the first creation response. Immutable for this Campaign: validation, CallJob execution and every retry use this version; each Attempt records it. Later Agent updates do not trigger comparison or validation. An unavailable/deleted version fails preparation or the affected CallJob explicitly, never falls back to latest. */
  @visibility(Lifecycle.Read)
  locked_agent_version: string;

  /** Available partial accounting even when the job fails or is cancelled. */
  @visibility(Lifecycle.Read) progress: TelephonyCampaignProgress;
}

/** Validation diagnostic for one invalid input row in the initial preparation. Execution details are available through the CallJob list. */
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

  /** Pinned Agent version used for preparation, shared by all errors on the page. */
  agent_version?: string;
}

/** Error pages order diagnostics by their original input position. */
alias TelephonyCampaignValidationErrorQueryParameters = {
  ...OmitProperties<TelephonyCampaignPageQueryParameters, "order">;

  /** Sort invalid rows by their original row_number. */
  @query order?: PageOrder = "desc";
};

/**
 * Status monitor for creation preparation or cascade deletion. Creation tracks snapshotting,
 * validation against the pinned Agent version and generation of all CallJobs. Success atomically
 * releases the Campaign dispatch gate unless cancellation has won; it does not wait for phone calls.
 * Automatic dispatch may begin before the creation poller returns. Cancel returns Campaign state.
 * Deletion transport and worker retries reuse their monitor; explicit retry after terminal cleanup
 * failure creates a new operation. Creation/deletion monitors omit result; validation diagnostics are
 * paged separately. Create finishes with a guarded Campaign GET; delete has no final resource GET.
 * Monitors remain retained independently of the resource.
 */
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCampaignOperation is JobLike {
  /** Creation time of this operation. */
  @visibility(Lifecycle.Read) created_at: FoundryTimestamp;

  /** Completion time. Creation succeeds after the entire snapshot is validated and saved, all CallJobs are durably generated and automatic dispatch is enabled; deletion succeeds after the Campaign, its copied snapshot, validation diagnostics, internal recipient accounting, owned CallJobs/attempt records and pending dispatch/outbox records are removed. The source Dataset, connections, Agent configuration, actual call records, conversations and recordings are preserved. */
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

    /** Absolute URI including api-version of the initial preparation monitor, returned while the recipient scan proceeds asynchronously. Campaign state tracks subsequent execution. */
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

  /** Opaque last_id from the previous page. Binds the original sort boundary, project/Agent scope and filters; validation-error cursors also bind the Campaign incarnation and immutable input snapshot. Never supply a name or row number. Cannot be combined with before. Invalid, altered or mismatched cursors return 400 invalid_cursor. */
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
   * Creates an immutable named Campaign and authorizes automatic execution after preparation.
   * Synchronous shape/auth checks and resolution of the owning Agent's latest version precede acceptance.
   * Persist the concrete Agent version with the Campaign, monitor and recoverable work before returning
   * 201 and Operation-Id/Operation-Location. Identical retries reuse that pinned version and original monitor.
   * Snapshot/validate all recipients, then idempotently generate one CallJob per input position.
   * Stay validating until all tasks exist; workers must check the Campaign dispatch gate. Publish running
   * and creation success only after complete materialization, unless cancellation won. Partial generation
   * is recoverable and cannot dial. Exhausted preparation failure enters failed after workers stop,
   * preserving diagnostics and fenced partial tasks for deletion. Row errors use validation_errors.
   * Immediate tasks may dial before the create poller returns; future tasks wait for their schedule.
   * Agent updates do not alter existing Campaigns or trigger another validation. An unavailable pinned
   * version fails preparation or affected CallJobs explicitly; execution and retries never select latest.
   * Same retained Operation-Id and input replays original 201; conflicting input returns 409 operation_id_conflict.
   * Exactly one of inputs.recipients and inputs.recipient_dataset is required. Replay compares original
   * inputs including Dataset version omission, excluding resolved versions/format and rendered defaults.
   * Without matching replay, an identical existing resource returns 200 and its original monitor;
   * changed inputs return 409 campaign_inputs_conflict. After deletion a retained creation key returns
   * 409 campaign_deleted. A fresh unkeyed creation after name reuse authorizes new work.
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

      /** Optional retry identifier. Name idempotency also applies when omitted: identical existing inputs return 200; different inputs conflict. Preserve it for retries across deletion. */
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

  /** Stops future dispatch and retries for the conditionally selected instance. Allowed while validating or running; enters cancelling and drains validation workers and admitted calls before cancelled. Connected calls finish naturally. Cancellation that wins during preparation completes the creation operation as cancelled after worker quiescence and prevents partial tasks from dialing. Cancellation after preparation preserves the terminal creation operation. Repeated cancel while cancelling/cancelled returns current state; completed/failed reject cancel with 409. A stale control token returns 412, including after name reuse. */
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

  /**
   * Lists invalid-row diagnostics from initial preparation against the pinned Agent version.
   * The operation monitor returns a bounded summary; this collection pages detailed errors.
   * During validating the list is partial, and an empty page is not a completion signal.
   * Diagnostic identities are stable by input position across worker retries; retries do not replace
   * the diagnostic collection or invalidate cursors. After preparation ends, diagnostics are retained
   * until Campaign deletion. Successful validation has an empty error list; execution failures are
   * exposed through CallJobs and non-row preparation failures through Campaign.error.
   * Cursors bind the Campaign incarnation and row_number boundary; reused names or invalid cursors
   * return 400 invalid_cursor. Deleting returns 409 campaign_deleting; deleted Campaigns return 404.
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

  /** Polls a creation or deletion operation independently of resource deletion/name reuse. Retained for the resource lifetime and at least 24 hours after both operation completion and deletion. Nonterminal responses include Retry-After. A failed monitor has a bounded error summary; listValidationErrors pages preparation diagnostics. Creation success includes full CallJob generation and automatic dispatch enablement, then a guarded final Campaign GET. Call execution can already be underway or complete when the poller returns. Delete has no result or final GET and cannot be cancelled. */
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
    #{ title: "Preparation finished and automatic dispatch is enabled" }
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

      /** Immutable creation- or deletion-operation ID returned in Operation-Id. Authorization is checked against its saved project and Agent scope even after resource deletion. */
      @path operation_id: string;
    },
    JobStatusResponse<TelephonyCampaignOperation>
  >;
}
