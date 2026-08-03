import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias IncludeCoordinatesTrait = {
  /** The include coordinates query parameter. */
  @query("includeCoordinates")
  @doc("Whether to include coordinates for visualization in the response. Defaults to false.")
  includeCoordinates?: boolean;
};

alias FilterQueryParamsTraits = {
  /** The type query parameter. */
  @query("type")
  @doc("Filter by the type of analysis.")
  type?: InsightType;

  /** The eval id query parameter. */
  @query("evalId")
  @doc("Filter by the evaluation ID.")
  evalId?: string;

  /** The run id query parameter. */
  @query("runId")
  @doc("Filter by the evaluation run ID.")
  runId?: string;

  /** The agent name query parameter. */
  @query("agentName")
  @doc("Filter by the agent name.")
  agentName?: string;

  ...IncludeCoordinatesTrait;
};

// Keep this alias, as it's used by client decorators in SDKs to map "id" to "insight_id"
alias InsightsGetParams = {
  ...IncludeCoordinatesTrait;

  /** The unique identifier for the insights report. */
  @path id: string;
};

@tag("Insights")
@route("insights")
interface Insights {
  /** Generates an insights report from the provided evaluation configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @summary("Generate insights")
  @post
  generate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    {
      /** The repeatability request id request header. */
      @header("Repeatability-Request-ID")
      @doc("Unique, client-generated identifier for ensuring request idempotency. Use the same ID for retries to prevent duplicate evaluations.")
      repeatabilityRequestId?: string;

      @doc("Timestamp indicating when this request was first initiated. Used in conjunction with repeatability-request-id for idempotency control.")
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;

      @doc("Complete evaluation configuration including data source, evaluators, and result settings")
      @body
      insight: Insight;
    },
    CreatedResponse & Insight
  >;

  /** Retrieves the specified insight report and its results. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @summary("Get an insight")
  @route("/{id}")
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    {
      ...InsightsGetParams;
    },
    Insight
  >;

  /** Returns insights in reverse chronological order, with the most recent entries first. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @summary("List insights")
  @list
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    FilterQueryParamsTraits,
    Azure.Core.Page<Insight>
  >;
}
