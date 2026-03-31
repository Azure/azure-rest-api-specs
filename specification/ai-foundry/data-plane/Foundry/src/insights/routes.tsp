import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias IncludeCoordinatesTrait = {
  @query("includeCoordinates")
  @doc("Whether to include coordinates for visualization in the response. Defaults to false.")
  includeCoordinates?: boolean;
};

alias FilterQueryParamsTraits = {
  @query("type")
  @doc("Filter by the type of analysis.")
  type?: InsightType;

  @query("evalId")
  @doc("Filter by the evaluation ID.")
  evalId?: string;

  @query("runId")
  @doc("Filter by the evaluation run ID.")
  runId?: string;

  @query("agentName")
  @doc("Filter by the agent name.")
  agentName?: string;

  ...IncludeCoordinatesTrait;
};

alias InsightsGetParams = {
  ...IncludeCoordinatesTrait;

  /** The unique identifier for the insights report. */
  @path id: string;
};

@tag("Insights")
@route("insights")
interface Insights {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @doc("Generate Insights")
  @post
  generate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    {
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @doc("Get a specific insight by Id.")
  @route("/{id}")
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    InsightsGetParams,
    Insight
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Following pattern from rest of foundry."
  @doc("List all insights in reverse chronological order (newest first).")
  @list
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.insights_v1_preview,
    FilterQueryParamsTraits,
    Azure.Core.Page<Insight>
  >;
}
