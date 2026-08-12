import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias AgentInsightsPreviewKey = FoundryFeaturesOptInKeys.agent_insights_v1_preview;

alias AgentInsightsPageQueryParameters = {
  /** A cursor that identifies the last item in the previous page. */
  @query
  @continuationToken
  after?: string;

  /** A cursor that identifies the first item in the next page. */
  @query before?: string;

  /** The maximum number of items to return. Defaults to 20. */
  @query
  @minValue(1)
  @maxValue(100)
  limit?: int32 = 20;

  /** Sort order by creation time. Defaults to descending. */
  @query order?: PageOrder = "desc";
};

alias AgentInsightListFilters = {
  /** Filter insights by category. */
  @query category?: string;

  /** Filter insights by severity. */
  @query severity?: AgentInsightSeverity;

  /** Filter insights by lifecycle status. */
  @query status?: AgentInsightStatus;
};

alias AgentInsightReadOptions = {
  /** Whether to include expanded insight details such as evidence and run links in the response. Defaults to false. */
  @query include_details?: boolean = false;
};

alias AgentInsightMonitorFilters = {
  /** Filter monitors by agent name. */
  @query agent_name?: string;
};

alias AgentInsightRunFilters = {
  /** Filter runs by status. */
  @query status?: AgentInsightRunStatus;

  /** Filter runs by trigger. */
  @query trigger?: AgentInsightRunTrigger;
};

alias AgentInsightMonitorCreatedResponse = ResourceCreatedResponse<AgentInsightMonitor> & {
  /** URL of the created monitor. */
  @header("Location")
  location: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agent Insights uses project-standard FoundryDataPlanePreviewOperation templates for Foundry data-plane preview routing and error handling."
@tag("Agent Insight Monitors")
@removed(Versions.v1)
interface AgentInsightMonitors {
  /** List Agent Insights monitors, optionally filtered by agent name. */
  @get
  @list
  @route("/agent_insight_monitors")
  list is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      ...AgentInsightsPageQueryParameters;
      ...AgentInsightMonitorFilters;
    },
    AgentsPagedResult<AgentInsightMonitor>
  >;

  /** Create an Agent Insights monitor for an agent. */
  @post
  @route("/agent_insight_monitors")
  create is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The monitor to create. */
      @body monitor: AgentInsightMonitorCreate;
    },
    AgentInsightMonitorCreatedResponse
  >;

  /** Get an Agent Insights monitor. */
  @get
  @route("/agent_insight_monitors/{monitor_id}")
  get is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;
    },
    AgentInsightMonitor
  >;

  /** Delete an Agent Insights monitor and all of its runs, insights, and state. */
  @delete
  @route("/agent_insight_monitors/{monitor_id}")
  delete is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;
    },
    NoContentResponse
  >;

  /** Update an Agent Insights monitor. */
  @patch
  @route("/agent_insight_monitors/{monitor_id}")
  update is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** Content type for patch operations. */
      @header("Content-Type")
      content_type: "application/merge-patch+json";

      /** The monitor fields to update. */
      @body monitor: AgentInsightMonitorUpdate;
    },
    OkResponse & AgentInsightMonitor
  >;

  /** Reset an Agent Insights monitor's overview, checkpoint, and active insight state. */
  @post
  @route("/agent_insight_monitors/{monitor_id}:reset")
  reset is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;
    },
    NoContentResponse
  >;

  /** Start an Agent Insights run for a monitor. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Run creation returns Operation-Location and Location headers through the project-standard JobCreatedResponse envelope."
  @post
  @route("/agent_insight_monitors/{monitor_id}/runs")
  createRun is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** Optional run inputs. */
      @body run?: AgentInsightRunCreate;
    },
    JobCreatedResponse<AgentInsightRun>
  >;

  /** List Agent Insights runs for a monitor. */
  @get
  @list
  @route("/agent_insight_monitors/{monitor_id}/runs")
  listRuns is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      ...AgentInsightsPageQueryParameters;
      ...AgentInsightRunFilters;
    },
    AgentsPagedResult<AgentInsightRun>
  >;

  /** Get an Agent Insights run. */
  @get
  @route("/agent_insight_monitors/{monitor_id}/runs/{run_id}")
  getRun is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** The identifier of the run. */
      @path run_id: string;
    },
    AgentInsightRun
  >;

  /** Cancel an Agent Insights run. */
  @post
  @route("/agent_insight_monitors/{monitor_id}/runs/{run_id}:cancel")
  cancelRun is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** The identifier of the run. */
      @path run_id: string;
    },
    OkResponse & AgentInsightRun
  >;

  /** List current insights for an Agent Insights monitor. */
  @get
  @list
  @route("/agent_insight_monitors/{monitor_id}/insights")
  listInsights is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      ...AgentInsightsPageQueryParameters;
      ...AgentInsightListFilters;
      ...AgentInsightReadOptions;
    },
    AgentsPagedResult<AgentInsight>
  >;

  /** Get a full insight for an Agent Insights monitor. */
  @get
  @route("/agent_insight_monitors/{monitor_id}/insights/{insight_id}")
  getInsight is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** The identifier of the insight. */
      @path insight_id: string;

      ...AgentInsightReadOptions;
    },
    AgentInsight
  >;

  /** Update the lifecycle status of an insight. */
  @patch
  @route("/agent_insight_monitors/{monitor_id}/insights/{insight_id}")
  updateInsight is FoundryDataPlanePreviewOperation<
    AgentInsightsPreviewKey,
    {
      /** The identifier of the monitor. */
      @path monitor_id: string;

      /** The identifier of the insight. */
      @path insight_id: string;

      /** Content type for patch operations. */
      @header("Content-Type")
      content_type: "application/merge-patch+json";

      /** The insight fields to update. */
      @body update: AgentInsightUpdate;
    },
    OkResponse & AgentInsight
  >;
}
