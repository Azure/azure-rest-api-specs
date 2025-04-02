import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
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
    Evaluation
  >;
}

@route("evaluations/{evaluationId}/results")
interface Results {
  @doc("Get a result by name.")
  get is EvaluationsOperations.ResourceRead<EvaluationResult>;

  @doc("Create a result.")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Result to be created")
      @body
      result: EvaluationResult;
    },
    EvaluationResult
  >;

  @doc("Start pending upload of a result file.")
  @route("startPendingUpload")
  @post
  upload is Azure.Core.Foundations.Operation<
    {
      @doc("Result to be uploaded.")
      @body
      result: EvaluationResult;
    },
    EvaluationResult
  >;
}
