import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../.external-readonly/openai.external.typespec/evals/models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraitsEvals = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvalsOperations = Azure.Core.ResourceOperations<ServiceTraitsEvals>;

@route("openai/evals")
@added(Versions.v2025_10_15_preview)
@removed(Versions.v1)
interface Evals {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<OpenAI.Eval>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<OpenAI.Eval>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to be run")
      @body
      eval: OpenAI.Eval;
    },
    ResourceCreatedResponse<OpenAI.Eval>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Cancel an evaluation run by name")
  @post
  cancel is EvaluationsOperations.ResourceAction<
    OpenAI.Eval,
    {},
    Http.NoContentResponse
  >;

  @doc("Delete an evaluation run by name")
  delete is EvaluationsOperations.ResourceDelete<OpenAI.Eval>;
}
