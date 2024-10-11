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

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Evaluations {
  get is Operations.ResourceRead<Evaluation>;

  create is Operations.ResourceCreateWithServiceProvidedName<Evaluation>;

  list is Operations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  update is Operations.ResourceUpdate<Evaluation>;

  // NoteNote: You did not have a delete Evaluation. What's the cleanup story here
  // delete is Operations.ResourceDelete<Evaluation>;
}

@route("evaluations")
interface EvaluationSchedules {
  create is Operations.ResourceCreateWithServiceProvidedName<
    EvaluationSchedule
  >;

  list is Operations.ResourceList<
    EvaluationSchedule,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  delete is Operations.ResourceDelete<EvaluationSchedule>;
}

model EvaluationCollection is Page<Evaluation>;
