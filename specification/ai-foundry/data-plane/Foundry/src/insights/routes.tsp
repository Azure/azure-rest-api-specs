import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias InsightsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.insights_v1_preview>;

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

@tag("Insights")
interface Insights {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Generate Insights")
  @post
  @route("insights")
  generate is Azure.Core.Foundations.Operation<
    {
      ...InsightsPreviewHeader;

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
    ResourceCreatedResponse<Insight>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a specific insight by Id.")
  get is Azure.Core.Foundations.ResourceOperation<
    Insight,
    {
      ...InsightsPreviewHeader;
      ...IncludeCoordinatesTrait;
    },
    Azure.Core.Foundations.ResourceOkResponse<Insight>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List all insights in reverse chronological order (newest first).")
  @Rest.listsResource(Insight)
  list is Azure.Core.Foundations.ResourceList<
    Insight,
    FilterQueryParamsTraits & InsightsPreviewHeader,
    Azure.Core.Page<Insight>
  >;
}
