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

  @doc("Get an evaluation group by name.")
  getgroup is EvaluationsOperations.ResourceRead<EvaluationGroup>;

  @doc("List evaluation groups")
  listgroup is EvaluationsOperations.ResourceList<EvaluationGroup>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation group.")
  @post
  creategroup is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation group to be created")
      @body
      evaluationGroup: EvaluationGroup;
    },
    ResourceCreatedResponse<EvaluationGroup>
  >;

  @doc("Delete an evaluation group by name")
  deletegroup is EvaluationsOperations.ResourceDelete<EvaluationGroup>;
}
