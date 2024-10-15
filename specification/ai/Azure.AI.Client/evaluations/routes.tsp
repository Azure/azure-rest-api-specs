import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

// namespace Azure.AI.Client.Evaluations;
namespace Azure.AI.Client;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests supresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
interface Evaluations {
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  // create is Operations.ResourceCreateWithServiceProvidedName<Evaluation>;
  // run is Operations.ResourceCollectionAction<Evaluation, {}, Evaluation>;
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @route("runs:run")
  @post
  @doc("Run the evaluation.")
  createEvaluation(
    @body
    @doc("Evaluation to run.")
    evaluation: Evaluation,
  ): CreatedEvaluationResponse;

  list is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  update is EvaluationsOperations.ResourceUpdate<Evaluation>;

  getEvaluationSchedule is EvaluationsOperations.ResourceRead<EvaluationSchedule>;

  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createOrReplaceEvaluationSchedule is EvaluationsOperations.ResourceCreateOrReplace<EvaluationSchedule>;

  listEvaluationSchedule is EvaluationsOperations.ResourceList<
  EvaluationSchedule,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

  deleteEvaluationSchedule is EvaluationsOperations.ResourceDelete<EvaluationSchedule>;
}

// model EvaluationCollection is Page<Evaluation>;
