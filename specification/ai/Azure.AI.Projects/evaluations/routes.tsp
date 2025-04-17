import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @post
  createRun is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to be run")
      @body
      evaluation: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run for agent continuous evaluation.")
  @route("agents/runs")
  @post
  createAgentEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Agent evaluation with asynchronous run")
      @body
      evaluation: AgentEvaluationRequest;
    },
    AgentLongRunningOperationResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get agent evaluation run results.")
  @route("agents/runs/{runId}")
  @get
  getAgentEvaluationResults is Azure.Core.Foundations.Operation<
    {
      @doc("Agent run id, for agent API v1, it's `[thread_id]:[run_id]`; for agent API v2, it's only the run_id.")
      @path
      runId: string;
    },
    Array<AgentEvaluationResult>
  >;
}
