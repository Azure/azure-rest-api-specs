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
@removed(Versions.v1)
interface Evaluations {
  /** Retrieves the specified evaluation run and its current status. */
  @summary("Get an evaluation run")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  /** Returns the evaluation runs available in the current project. */
  @summary("List evaluation runs")
  list is EvaluationsOperations.ResourceList<Evaluation>;

  /** Submits a new evaluation run with the provided configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create an evaluation run")
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

  /** Submits a new agent evaluation run with the provided request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create an agent evaluation run")
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

  /** Cancels the specified evaluation run before it completes. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Cancel an evaluation run")
  @post
  cancel is EvaluationsOperations.ResourceAction<
    Evaluation,
    {},
    Http.NoContentResponse
  >;

  /** Removes the specified evaluation run from the project. */
  @summary("Delete an evaluation run")
  delete is EvaluationsOperations.ResourceDelete<Evaluation>;
}
