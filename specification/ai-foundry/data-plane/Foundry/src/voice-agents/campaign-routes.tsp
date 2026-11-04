import "./campaign-jobs.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-scoped Campaign reads, cursor pages and retained monitors use Foundry operation wrappers; asynchronous actions reuse the shared configurable job templates."
@doc("Name-addressed Campaigns owned by the route Agent.")
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  @doc("""
    Creates (201) or fully replaces quiescent failed preparation (200), authorizing execution after validation; no PATCH.
    Replacement can change connection/source, recipients or Dataset, schedule and retries, not Agent/name or server fields.
    It requires exact If-Match and a fresh Operation-Id: missing ID returns 400, stale token 412, other states 409.
    If-Match on an absent Campaign returns 412. Omitted optional fields reset to defaults.
    Acceptance returns validating and a preparation monitor. A new round resets pins, progress and diagnostics,
    fences old jobs and invalidates their diagnostic cursors; previous monitors remain. Agent/Dataset versions pin before
    validation. All recipients and CallJobs must be ready before dispatch; failed rounds never dial. Immediate calls may
    begin before the poller returns.
    After shape/authorization checks, the same ID, submitted inputs and original If-Match replay the original monitor
    before current-state checks, without changing pins; conflicting reuse returns 409 operation_id_conflict.
    Without If-Match, equivalent input returns the current resource/original monitor; changed input conflicts.
    With If-Match, a fresh ID is required even for unchanged inputs. Replay compares submitted values, not resolved
    versions/defaults. Retained creation keys return 409 campaign_deleted after deletion; new intent needs a fresh key.
    """)
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

  @doc("Gets the Campaign without inline recipients. Optional operation_id guards the original instance/round: same-round cancel is allowed; replacement/name reuse returns 409 campaign_operation_mismatch. Missing/expired/wrong-scope operations or absent Campaigns return 404.")
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

      @doc("Original response's Operation-Id for guarded final GET, not the current Campaign pointer. Survives same-round actions; replacement/name reuse returns 409 campaign_operation_mismatch.")
      @query
      operation_id?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignResponse
  >;

  @doc("Lists Agent-owned Campaigns without inline recipients. Opaque cursors retain their original sort/instance boundary across deletion/name reuse. Filters are live, not snapshots.")
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

  @doc("""
    Cancels validating/running Campaigns with exact If-Match; returns 202 and its monitor, even when complete.
    Stops new dispatch/retries and drains workers/admitted calls; connected calls finish naturally. The round/Agent pin stays.
    Cancellation that wins preparation cancels its validation monitor; completed validation is unchanged.
    After authorization, the same Operation-Id/original If-Match replays 202 even after deletion/name reuse, never changing
    a replacement. Conflicting IDs return 409; without replay, missing Campaigns return 404 and stale tokens 412.
    Omitted IDs are generated. Current-token repeats reuse the monitor; fresh IDs alias it. New cancellation of
    completed/failed/deleting returns 409. Failure leaves cancelling/error and dispatch disabled; resume with current
    If-Match and a fresh ID, preserving previous failures. Poll the accepted monitor, then perform a guarded Campaign GET.
    """)
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

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Azure DELETE LRO pattern specifies a bodyless 202 with Operation-Location; polling returns the operation body."
  @doc("""
    Deletes a terminal, quiescent Campaign asynchronously; cancel must finish first, otherwise 409.
    Acceptance sets deleting, hides owned jobs/results and reserves the name. Cleanup removes all rounds' recipient/task
    data and pending dispatch work, not the Dataset, connections, Agent or independent CallJobs. Call records, conversations
    and media retain their own policies. Returns bodyless 202 with a monitor; completion has no resource result (GET 404, list omission).
    The same Operation-Id/original If-Match replays 202 before stale-token checks, even after deletion/name reuse, never
    touching a later instance. Conflicting IDs return 409; without replay, absent names return 204 and stale tokens 412.
    Current-token repeats reuse the monitor; fresh IDs alias it. Failure leaves deleting/error; resume cleanup with current
    If-Match and a fresh ID. Success frees the name, retaining replay/duplicate-dialing safeguards, not a public tombstone.
    """)
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

  @doc("""
    Pages invalid-row diagnostics for the current round/pinned Agent; partial while validating, so empty does not mean success.
    Cursors bind instance/round/row and survive retries/cancel; replacement/name reuse invalidates them (400 invalid_cursor).
    Diagnostics persist until replacement or deletion. Deleting returns 409 campaign_deleting; deleted returns 404.
    Execution failures are in CallJobs; non-row preparation failures are in Campaign.error. The monitor has only a summary.
    """)
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

  @doc("Polls a fixed operation despite later actions, replacement or deletion. Retained for the Campaign lifetime and at least 24 hours after both completion and deletion. Pending replies include Retry-After; PUT/cancel end with guarded Campaign GETs, delete without a resource result.")
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
