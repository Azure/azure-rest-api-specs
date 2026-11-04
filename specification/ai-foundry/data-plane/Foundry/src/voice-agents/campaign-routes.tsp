import "./campaign-jobs.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent-scoped Campaign reads, cursor pages and retained monitors use Foundry operation wrappers; asynchronous actions reuse the shared configurable job templates."
@doc("Name-addressed Campaigns owned by the route Agent.")
@tag("TelephonyCampaigns")
interface TelephonyCampaigns {
  @doc("Creates a Campaign or fully replaces failed preparation; no PATCH. All recipients must validate and have CallJobs before dialing. Immediate calls may begin before the preparation poller returns.")
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

      @doc("Retry key: matching submitted inputs and original If-Match replay the saved monitor before current-state checks. Conflicting reuse returns 409 operation_id_conflict; retained creation keys after deletion return 409 campaign_deleted.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;

      @doc("Required with a fresh Operation-Id for failed-state replacement; no wildcards. Changed input without it returns 409. Missing replacement ID: 400; stale token/absent resource: 412; other states: 409.")
      @header("If-Match")
      if_match?: Azure.Core.eTag;

      @doc("Complete connection, source, recipients/Dataset, schedule and retry configuration. Omitted optional fields reset to defaults; Agent/name and response-only fields cannot change.")
      @body
      campaign: TelephonyCampaign;
    },
    | TelephonyCampaignCreatedResponse<201>
    | TelephonyCampaignCreatedResponse<200>,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  @doc("Gets Campaign configuration and execution state without inline recipients. Absent or deleted Campaigns return 404.")
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

      @doc("Original response's Operation-Id guards its instance/round and survives same-round actions. Replacement/name reuse: 409 campaign_operation_mismatch; missing/expired/wrong-scope operation: 404.")
      @query
      operation_id?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignResponse
  >;

  @doc("Lists the Agent's Campaigns without inline recipients. Filters are live views, not snapshots.")
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

  @doc("Cancels a validating or running Campaign using If-Match. Stops new calls and retries; connected calls finish naturally. Returns 202 with an operation monitor to track completion.")
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

      @doc("Exact current token; no wildcards. Without replay, missing Campaigns return 404 and stale tokens 412. Starting cancellation outside validating/running returns 409.")
      @header("If-Match")
      if_match: Azure.Core.eTag;

      @doc("Optional retry key, generated if omitted. Original If-Match/key replays 202 even after deletion/name reuse, never touching a replacement; conflicts return 409. Failed cancellation needs a fresh key/current token.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignCancelAcceptedResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Azure DELETE LRO pattern specifies a bodyless 202 with Operation-Location; polling returns the operation body."
  @doc("Deletes a terminal Campaign and its recipient/task data asynchronously. Returns bodyless 202 with a monitor, not a tombstone; completion makes GET return 404 and lists omit it. Dataset, connections, Agent, independent jobs and call history are preserved.")
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

      @doc("Exact current token; no wildcards. Without replay, absent Campaigns return 204 and stale tokens 412. Active calls/workers or unfinished cancellation return 409.")
      @header("If-Match")
      if_match: Azure.Core.eTag;

      @doc("Optional retry key. Original If-Match/key replays 202 even after deletion/name reuse, never touching a new instance; conflicts return 409. Failed cleanup needs a fresh key/current token.")
      @header("Operation-Id")
      operationId?: TelephonyCampaignOperationId;
    },
    TelephonyCampaignDeleteAcceptedResponse | NoContentResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;

  @doc("Lists current-round row validation errors. Results may be partial during preparation; an empty page does not establish success. Execution errors are in CallJobs; non-row failures are in Campaign.error.")
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

      @doc("Campaign name. Deleting returns 409 campaign_deleting; absent/deleted returns 404.")
      @path
      campaign_name: TelephonyCampaignName;

      ...TelephonyCampaignValidationErrorQueryParameters;
    },
    TelephonyCampaignValidationErrorPage & TelephonyCampaignNoStoreResponse
  >;

  @doc("Gets the initiating operation's status. PUT/cancel pollers finish with a guarded Campaign GET; deletion completes without a resource result.")
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

      @doc("Operation-Id from the initiating response. Saved project/Agent authorization still applies after resource deletion.")
      @path
      operation_id: TelephonyCampaignOperationId;
    },
    JobStatusResponse<TelephonyCampaignOperation> &
      TelephonyCampaignNoStoreResponse,
    WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.voice_agents_v1_preview>
  >;
}
