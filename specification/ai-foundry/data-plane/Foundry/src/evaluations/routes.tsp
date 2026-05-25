import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias EvaluationsOperations = FoundryAzureOperations<{}>;

@route("evaluations")
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
  create is FoundryOperation<
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
  createAgentEvaluation is FoundryOperation<
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
