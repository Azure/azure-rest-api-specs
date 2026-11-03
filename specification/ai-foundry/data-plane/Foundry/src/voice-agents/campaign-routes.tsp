import "./campaign-jobs.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-scoped Campaign reads, cursor pages and retained monitors use Foundry operation wrappers; asynchronous actions reuse the shared configurable job templates."
@doc("Name-addressed Campaigns owned by the route Agent.")
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  /**
   * Creates a named Campaign (201) or fully replaces a failed Campaign's inputs (200), authorizing calls after validation.
   * No PATCH or partial updates are supported. Only failed preparation can be replaced; all other states reject changes.
   * Replacement may change connection_name, source, recipients/recipient_dataset, schedule and retry_policy.
   * The route Agent and Campaign name cannot change; server-owned status, progress and resolved versions are not writable.
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}")
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}")
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
  @route("/agents/{agent_name}/telephony_campaigns")
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}:cancel")
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
   * After cleanup, Campaign GET returns 404 and lists omit it; no Campaign tombstone is returned.
   * The retained monitor/replay records support recovery, not a final resource result. Clients can discard the monitor after completion.
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}")
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}/validation_errors")
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
  @route("/agents/{agent_name}/telephony_campaigns/{campaign_name}/operations/{operation_id}")
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
