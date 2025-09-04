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
  @query("filter")
  @doc("Filter in odata format")
  filter?: string;
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
      request: Insight;
    },
    ResourceCreatedResponse<Insight>
  >;

  @doc("Get a specific insights report.")
  @get
  getInsights is InsightsOperations.ResourceRead<Insight>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("insights:latest")
  @doc("Get the latest insights report.")
  @get
  getLatestInsightsReport is Operation<
    FilterQueryParamsTraits,
    OkResponse<Insight>
  >;

  @doc("List all insights reports.")
  @get
  listInsightsReports is InsightsOperations.ResourceList<
    Insight,
    ListQueryParametersTrait<FilterQueryParamsTraits>
  >;
}
