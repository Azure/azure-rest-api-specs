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

namespace Azure.AI.Client.Evaluations;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests supresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
interface Evaluations {
  get is Operations.ResourceRead<Evaluation>;

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

  list is Operations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  update is Operations.ResourceUpdate<Evaluation>;
}

@route("evaluations")
interface EvaluationSchedules {
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  createOrReplace is Operations.ResourceCreateOrReplace<EvaluationSchedule>;

  list is Operations.ResourceList<
    EvaluationSchedule,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  delete is Operations.ResourceDelete<EvaluationSchedule>;
}

// model EvaluationCollection is Page<Evaluation>;
