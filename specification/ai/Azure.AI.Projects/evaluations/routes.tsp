import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias DisplayPreferencesTypeParameterTrait = {
  @doc("Filter expression to narrow down the list of evaluations based on specific criteria. Supports filtering by properties such as status, tags, or properties to help manage large evaluation collections.")
  @query
  @added(Versions.v2025_07_31_preview)
  filter?: string;
};

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<Evaluation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to be run")
      @body
      evaluation: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an agent evaluation run.")
  @route("runs:runAgent")
  @post
  createAgentEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Agent evaluation to be run")
      @body
      evaluation: AgentEvaluationRequest;
    },
    ResourceCreatedResponse<AgentEvaluation>
  >;

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

@route("evals")
@added(Versions.v2025_07_31_preview)
@removed(Versions.v1)
interface UnifiedEvaluations {
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

