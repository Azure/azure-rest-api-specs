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
  createBatch is Azure.Core.Foundations.Operation<
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
  createSingle is Azure.Core.Foundations.Operation<
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
  @doc("Cancel an evaluation run by name")
  @post
  cancel is EvaluationsOperations.ResourceAction<
    Evaluation,
    {},
    Http.NoContentResponse
  >;

  @doc("Delete an evaluation run by name")
  delete is EvaluationsOperations.ResourceDelete<Evaluation>;

  @doc("Get an evaluation group by name.")
  @added(Versions.v2025_07_31_preview)
  getGroup is EvaluationsOperations.ResourceRead<EvaluationGroup>;

  @doc("List evaluation groups")
  @added(Versions.v2025_07_31_preview)
  listGroup is EvaluationsOperations.ResourceList<
    EvaluationGroup,
    ListQueryParametersTrait<DisplayPreferencesTypeParameterTrait>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List runs under a group")
  @route("groups/{groupId}/runs")
  @added(Versions.v2025_07_31_preview)
  listGroupRuns is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<DisplayPreferencesTypeParameterTrait>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation group.")
  @post
  @added(Versions.v2025_07_31_preview)
  createGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation group to be created")
      @body
      evaluationGroup: EvaluationGroup;
    },
    ResourceCreatedResponse<EvaluationGroup>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create run under a group")
  @post
  createGroupRun is EvaluationsOperations.ResourceAction<
    EvaluationGroup,
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

  @doc("Update an evaluation group by name")
  updateGroup is EvaluationsOperations.ResourceUpdate<EvaluationGroup>;

  @doc("Delete an evaluation group by name")
  deleteGroup is EvaluationsOperations.ResourceDelete<EvaluationGroup>;
}
