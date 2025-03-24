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
      evaluation: EvaluationRun;
    },
    Evaluation
  >;
<<<<<<< HEAD
=======

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Upload the result to an evaluation run.")
  @route("runs:upload")
  @post
  UploadRun is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to upload.")
      @body
      evaluation: EvaluationUpload;
    },
    Evaluation
  >;
>>>>>>> 9dae5b7564 (switch to a separate input dto)
}
