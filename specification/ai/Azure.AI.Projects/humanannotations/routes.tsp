import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias HumanAnnotationServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias HumanAnnotationOperations = Azure.Core.ResourceOperations<HumanAnnotationServiceTraits>;

@route("evaluations/human-evaluation-templates")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface HumanEvaluationTemplates {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List available human evaluation templates. Returns builtin templates from the azureml registry and workspace-scoped custom templates.")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Filter by template source: builtin, custom, or all.")
      @query("source")
      source?: TemplateSource;

      @doc("Filter by template name (exact match).")
      @query("name")
      name?: string;

      @doc("The maximum number of templates to return. Default is 50, maximum is 200.")
      @query("top")
      top?: int32;

      @doc("Continuation token for pagination.")
      @query("skip")
      skip?: string;
    },
    HumanEvaluationTemplateList
  >;
}

@doc("Paginated list of human evaluation templates.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanEvaluationTemplateList {
  @doc("The list of human evaluation templates.")
  value: HumanEvaluationTemplate[];

  @doc("The link to the next page of results, if available.")
  @encodedName("application/json", "next_link")
  nextLink?: string;
}

@route("evaluations/human-scores")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface HumanAnnotationScores {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Submit human annotation scores in batch. Accepts 1 to 100 score items per request. Each score is validated against the referenced template and published to App Insights.")
  @route("batch")
  @post
  submitScores is Azure.Core.Foundations.Operation<
    {
      @doc("The batch of human annotation scores to submit.")
      @body
      body: SubmitHumanAnnotationScoresRequest;
    },
    SubmitHumanAnnotationScoresResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Query human annotation scores. Results are returned from App Insights via KQL.")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Filter by trace ID(s), comma-separated.")
      @query("traceIds")
      traceIds?: string;

      @doc("Filter by template name.")
      @query("templateName")
      templateName?: string;

      @doc("Filter by reviewer user ID.")
      @query("reviewer")
      reviewer?: string;

      @doc("Filter by score kind (e.g., thumbs, likert, stars).")
      @query("scoreKind")
      scoreKind?: string;

      @doc("Filter by score value.")
      @query("scoreValue")
      scoreValue?: string;

      @doc("Filter by feedback source (builder or end_user).")
      @query("feedbackSource")
      feedbackSource?: FeedbackSource;

      @doc("Filter by feedback ID type (trace, conversation, or session).")
      @query("feedbackIdType")
      feedbackIdType?: FeedbackIdType;

      @doc("Start of the time range filter (ISO 8601).")
      @query("timeRangeStart")
      timeRangeStart?: utcDateTime;

      @doc("End of the time range filter (ISO 8601).")
      @query("timeRangeEnd")
      timeRangeEnd?: utcDateTime;

      @doc("The maximum number of scores to return. Default is 50, maximum is 200.")
      @query("top")
      top?: int32;
    },
    HumanAnnotationScoreList
  >;
}

@doc("Paginated list of human annotation scores.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model HumanAnnotationScoreList {
  @doc("The list of human annotation scores.")
  value: HumanAnnotationScore[];

  @doc("The link to the next page of results, if available.")
  @encodedName("application/json", "next_link")
  nextLink?: string;
}
