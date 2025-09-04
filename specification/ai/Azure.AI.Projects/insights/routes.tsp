import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias InsightsServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias InsightsOperations = Azure.Core.ResourceOperations<InsightsServiceTraits>;

alias FilterQueryParamsTraits = {
  @query("analysisRequestType")
  @doc("The type of analysis request.")
  analysisRequestType?: AnalysisRequestType;

  @query("evaluationNames")
  @doc("The unique names for the evaluations.")
  evaluationNames?: string[];

  @query("agentId")
  @doc("The unique identifier for the agent.")
  agentId?: string;
};

@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface Insights {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Generate Insights")
  @post
  @route("insights")
  generateInsights is Azure.Core.Foundations.Operation<
    {
      @header("Repeatability-Request-ID")
      @doc("Unique, client-generated identifier for ensuring request idempotency. Use the same ID for retries to prevent duplicate evaluations.")
      repeatabilityRequestId?: string;

      @doc("Timestamp indicating when this request was first initiated. Used in conjunction with repeatability-request-id for idempotency control.")
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;

      @doc("Complete evaluation configuration including data source, evaluators, and result settings")
      @body
      request: ProjectInsight;
    },
    ResourceCreatedResponse<ProjectInsight>
  >;

  @doc("Get a specific insights report.")
  @get
  getInsights is InsightsOperations.ResourceRead<ProjectInsight>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("insights:latest")
  @doc("Get the latest insights report.")
  @get
  getLatestInsightsReport is Operation<
    FilterQueryParamsTraits,
    OkResponse<ProjectInsight>
  >;

  @doc("List all insights reports.")
  @get
  listInsightsReports is InsightsOperations.ResourceList<
    ProjectInsight,
    ListQueryParametersTrait<FilterQueryParamsTraits>
  >;
}
