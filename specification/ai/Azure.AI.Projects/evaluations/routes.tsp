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

  @doc("List evaluation run row results.")
  @route("evaluations/{evaluationId}/results ")
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v1)
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listRowResults(
    @doc("""
    The index of the first item to return. Used for pagination.
    """)
    @query startIndex?: int32,

    @doc("""
    The number of items to return in the result set. Used for pagination.
    """)
    @query pageSize?: int32 = 5,
    @doc("""
    Specifies the unique identifier of the evaluation resource.
    """)
    @path evaluationId: string,

    @doc("""
    The number of items to skip before starting to collect the result set. Used for pagination.
    """)
    @query skip?: int32,

    @doc("""
    The maximum number of items to return in the result set. Used for pagination.
    """)
    @query top?: int32,

    @doc("""
    The API version to use for the request.
    """)
    @query apiVersion: string
  ): Azure.Core.Page<LabeledRows>;

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
}
