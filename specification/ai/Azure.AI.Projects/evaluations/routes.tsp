import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias RetryServiceTrait = {
  @header("Retry-After")
  @doc("Recommended time interval in seconds before making another request when the evaluation is still processing. This helps prevent excessive polling and reduces server load during long-running evaluations.")
  @added(Versions.v2025_07_31_preview)
  @visibility(Lifecycle.Read)
  retryAfter?: string;
};

alias DisplayPreferencesTypeParameterTrait = {
  @doc("Filter expression to narrow down the list of evaluations based on specific criteria. Supports filtering by properties such as status, tags, or properties to help manage large evaluation collections.")
  @query
  @added(Versions.v2025_07_31_preview)
  filter?: string;
};

alias EvaluationsOperations = ResourceOperations<ServiceTraits>;

@route("evaluations")
@added(Versions.v2025_05_15_preview)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation & RetryServiceTrait>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<DisplayPreferencesTypeParameterTrait>
  >;

  // create is deprecated from version v2025_07_31_preview onwards.
  #deprecated "Use /evaluations/runs:runBatch or /evaluations/runs:runSingle instead."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @removed(Versions.v2025_07_31_preview)
  @post
  @sharedRoute
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to be run")
      @body
      evaluation: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #deprecated "Use /evaluations/runs:runBatch or /evaluations/runs:runSingle instead."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an agent evaluation run.")
  @route("runs:runAgent")
  @removed(Versions.v2025_07_31_preview)
  @post
  @sharedRoute
  createAgentEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Agent evaluation to be run")
      @body
      evaluation: AgentEvaluationRequest;
    },
    ResourceCreatedResponse<AgentEvaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a new evaluation with the specified configuration.")
  @added(Versions.v2025_07_31_preview)
  @route("runs:runBatch")
  @post
  createBatchEvaluation is Azure.Core.Foundations.Operation<
    {
      @header("Repeatability-Request-ID")
      @doc("Unique, client-generated identifier for ensuring request idempotency. Use the same ID for retries to prevent duplicate evaluations.")
      repeatabilityRequestId?: string;

      @doc("Timestamp indicating when this request was first initiated. Used in conjunction with repeatability-request-id for idempotency control.")
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;

      @doc("Complete evaluation configuration including data source, evaluators, and result settings")
      @body
      evaluation: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Independent API operation to perform a single evaluation and immediately get a result.")
  @added(Versions.v2025_07_31_preview)
  @route("runs:runSingle")
  @post
  createSingleEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Complete evaluation configuration including data source, evaluators, and result settings")
      @body
      singleEvaluation: SingleEvaluation;
    },
    OkResponse<SingleEvaluationResult>
  >;

  @doc("Updates specific properties of an existing evaluation. Supports modification of metadata fields including description, display name, and tags. Note: Core evaluation configuration such as data sources and evaluators cannot be modified after creation.")
  @added(Versions.v2025_07_31_preview)
  update is EvaluationsOperations.ResourceUpdate<Evaluation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Retrieves detailed row-by-row evaluation results with pagination support. This endpoint provides access to individual evaluation outcomes, scores, and reasoning for each data row processed.")
  @route("runs/{id}/results")
  @get
  @added(Versions.v2025_07_31_preview)
  getEvaluationResults(
    @doc("Unique identifier of the evaluation whose results are being retrieved")
    @path
    id: string,

    @doc("API version specifier for this operation")
    @query("api-version")
    apiVersion: string,

    @query
    @doc("Maximum number of result items to return in a single response. Must be a multiple of 10 (e.g., 10, 20, 100, 1000). Defaults to 10 if not specified.")
    top?: int32,

    @query
    @doc("Number of result items to skip before returning results, enabling pagination through large result sets. Must be a multiple of 10. Defaults to 0.")
    skip?: int32 = 0,

    ...ClientRequestIdHeader,
  ): Azure.Core.Page<EvaluationResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Cancel an evaluation run by name")
  @post
  cancel is EvaluationsOperations.ResourceAction<
    Evaluation,
    {},
    Http.NoContentResponse
  >;

  @doc("Delete an evaluation run by name")
  delete is EvaluationsOperations.ResourceDelete<Evaluation>;
}
