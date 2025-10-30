import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias InsightsServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias InsightsOperations = Azure.Core.ResourceOperations<InsightsServiceTraits>;

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

// Query trait for single-resource GET that exposes only includeCoordinates
alias IncludeCoordinatesQueryTrait = {
  @query("includeCoordinates")
  @doc("Whether to include coordinates for visualization in the response. Defaults to false.")
  includeCoordinates?: boolean;
};

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
interface Insights {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Generate Insights")
  @post
  @route("insights")
  generate is Azure.Core.Foundations.Operation<
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
    ResourceCreatedResponse<Insight>
  >;

  @doc("Get a specific insight by Id.")
  @get
  get is InsightsOperations.ResourceRead<
    Insight,
    QueryParametersTrait<IncludeCoordinatesTrait, TraitContext.Read>
  >;

  @doc("List all insights in reverse chronological order (newest first).")
  @get
  list is InsightsOperations.ResourceList<
    Insight,
    ListQueryParametersTrait<FilterQueryParamsTraits>
  >;
}
